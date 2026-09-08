// Detecta widgets nuevos de lib/src/components/ que llegan SIN su port web en
// tool/design_sync/_src/. Cada componente del design system tiene dos mitades:
// la Flutter (la que usa la app) y el port React que consume claude.ai/design.
// Cuando una PR añade solo la primera, el design system se desincroniza en
// silencio y los diseños dejan de poder montar ese componente.
//
// Uso:  node tool/design_sync/check-ports.mjs <archivo.dart> [<archivo.dart>…]
// Sin argumentos no comprueba nada (no hay ficheros nuevos que mirar).
import { existsSync, readdirSync, readFileSync, statSync } from 'node:fs';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const SYNC_DIR = dirname(fileURLToPath(import.meta.url));
const REPO = resolve(SYNC_DIR, '..', '..');
const EXCEPTIONS = join(SYNC_DIR, '.port-exceptions.json');

// Clases públicas que extienden un widget de Flutter. Las privadas (_Foo) son
// internas del propio archivo y nunca se portan. El `<T>` opcional cubre los
// widgets genéricos (p.ej. `class DotsMenu<T> extends StatefulWidget`).
// Los modificadores son los de Dart 3 (el paquete va con sdk ^3.9.0): hoy no
// se usan en widgets, pero `final class Foo extends StatelessWidget` es legal
// y no debería colarse.
// Nombres de clase / carpeta: identificador simple. Sirve para cazar erratas
// del tipo "cards/DotsGameCard", que si no acabarían buscando en un sitio raro
// y dando un error confuso.
const NAME_RX = /^[A-Za-z_$][A-Za-z0-9_$]*$/;

const WIDGET_RX =
  /^\s*(?:(?:abstract|base|final|interface|sealed|mixin)\s+)*class\s+([A-Z]\w*)(?:<[^>]*>)?\s+extends\s+(?:StatelessWidget|StatefulWidget)\b/gm;

let cfg = { ignore: [], aliases: {} };
if (existsSync(EXCEPTIONS)) {
  try {
    cfg = JSON.parse(readFileSync(EXCEPTIONS, 'utf8'));
  } catch (e) {
    // Sin esto, un JSON mal formado revienta con un stacktrace que no dice
    // qué arreglar; el fallo del workflow debe ser accionable.
    console.log(
      `::error file=tool/design_sync/.port-exceptions.json::JSON inválido: ${e.message}. ` +
        'Corrige el archivo (o bórralo para volver al comportamiento por defecto: sin ignore ni aliases).',
    );
    process.exit(1);
  }
}
// JSON válido pero mal tipado (ignore como objeto, aliases como array…) haría
// reventar el Set o daría alias que nunca resuelven; se avisa igual que con el
// JSON roto, porque este archivo lo edita gente a mano.
const badType = [];
if (cfg.ignore !== undefined && !Array.isArray(cfg.ignore)) {
  badType.push(`"ignore" debe ser un array de nombres de clase (llegó ${typeof cfg.ignore})`);
}
if (
  cfg.aliases !== undefined &&
  (typeof cfg.aliases !== 'object' || cfg.aliases === null || Array.isArray(cfg.aliases))
) {
  badType.push(`"aliases" debe ser un objeto ClaseDart -> CarpetaPort (llegó ${Array.isArray(cfg.aliases) ? 'array' : typeof cfg.aliases})`);
}
// Y los valores de dentro: un número o un null acabarían en path.join() como un
// TypeError sin contexto, justo lo que este bloque existe para evitar.
if (Array.isArray(cfg.ignore)) {
  for (const [i, v] of cfg.ignore.entries()) {
    if (typeof v !== 'string') {
      badType.push(`"ignore[${i}]" debe ser el nombre de una clase Dart (string), llegó ${JSON.stringify(v)}`);
    } else if (!NAME_RX.test(v)) {
      badType.push(`"ignore[${i}]" debe ser un nombre de clase simple: llegó ${JSON.stringify(v)}`);
    }
  }
}
if (cfg.aliases && typeof cfg.aliases === 'object' && !Array.isArray(cfg.aliases)) {
  for (const [k, v] of Object.entries(cfg.aliases)) {
    if (typeof v !== 'string') {
      badType.push(`"aliases.${k}" debe ser el nombre de la carpeta del port (string), llegó ${JSON.stringify(v)}`);
    } else if (!NAME_RX.test(v)) {
      badType.push(`"aliases.${k}" debe ser un nombre simple de carpeta, sin barras ni "..": llegó ${JSON.stringify(v)}`);
    }
  }
}
if (badType.length) {
  for (const msg of badType) {
    console.log(`::error file=tool/design_sync/.port-exceptions.json::${msg}`);
  }
  process.exit(1);
}

const ignore = new Set(cfg.ignore ?? []);
const aliases = cfg.aliases ?? {};

// La tarjeta vive en components/<grupo>/<Name>/<Name>.html y el grupo lo elige
// quien porta, así que se busca por todos los grupos.
function findCard(port) {
  const root = join(SYNC_DIR, 'components');
  if (!existsSync(root)) return null;
  for (const group of readdirSync(root)) {
    const p = join(root, group, port, `${port}.html`);
    if (statSync(join(root, group)).isDirectory() && existsSync(p)) {
      return `tool/design_sync/components/${group}/${port}/${port}.html`;
    }
  }
  return null;
}

const files = process.argv.slice(2).filter((f) => f.endsWith('.dart'));
const missing = [];
let checked = 0;

for (const rel of files) {
  // El workflow pasa rutas relativas a la raíz del repo; en local es cómodo
  // poder pasarlas relativas al cwd. Si no aparece por ninguna de las dos vías
  // se avisa, en vez de ignorarlo en silencio (se pierde el aviso más útil:
  // que el archivo no era el que creías).
  const abs = [resolve(REPO, rel), resolve(process.cwd(), rel)].find((p) => existsSync(p));
  if (!abs) {
    console.log(`  · ${rel} — no existe (¿borrado en esta PR?), se omite`);
    continue;
  }
  const src = readFileSync(abs, 'utf8');
  for (const [, cls] of src.matchAll(WIDGET_RX)) {
    checked++;
    if (ignore.has(cls)) {
      console.log(`  · ${cls} — en la lista de excepciones, se omite`);
      continue;
    }
    const port = aliases[cls] ?? cls;
    const hasImpl = existsSync(join(SYNC_DIR, '_src', port, `${port}.impl.js`));
    const card = findCard(port);
    if (hasImpl && card) {
      console.log(`  ✓ ${cls} → tool/design_sync/_src/${port}/ + ${card}`);
    } else {
      missing.push({ cls, port, rel, hasImpl, card });
    }
  }
}

if (!files.length) {
  console.log('No hay archivos .dart nuevos bajo lib/src/components/ — nada que comprobar.');
  process.exit(0);
}
console.log(`Widgets públicos nuevos analizados: ${checked}`);

if (!missing.length) {
  console.log('OK: todos tienen su port web.');
  process.exit(0);
}

for (const { cls, port, rel, hasImpl, card } of missing) {
  const falta = !hasImpl && !card
    ? `Faltan tool/design_sync/_src/${port}/${port}.impl.js y su tarjeta tool/design_sync/components/<grupo>/${port}/${port}.html`
    : !hasImpl
      ? `Falta tool/design_sync/_src/${port}/${port}.impl.js (la tarjeta ${card} sí está)`
      : `Falta la tarjeta tool/design_sync/components/<grupo>/${port}/${port}.html (el tool/design_sync/_src/${port}/ sí está)`;
  console.log(`::error file=${rel}::${cls} no tiene port web completo. ${falta}.`);
}
console.log(`
Cómo resolverlo, según el caso:

  1. Es un componente con UI que los diseños deberían poder montar
     → añade su port siguiendo tool/design_sync/_src/CONVENTIONS.md
       (<Name>.impl.js + <Name>.css, y components/<grupo>/<Name>/ con
       .html, .d.ts y .prompt.md), y regenera el bundle:
       node tool/design_sync/_src/build.mjs

  2. El widget no tiene sentido en el design system (helper interno, wrapper
     de layout, algo que solo existe dentro de otro componente)
     → añádelo a "ignore" en tool/design_sync/.port-exceptions.json

  3. Ya está portado pero con otro nombre
     → mapéalo en "aliases" de ese mismo archivo

  4. Vas con prisa y lo portas en otra PR
     → pon la label design-sync:skip (mejor abrir issue para no perderlo)
`);
process.exit(1);
