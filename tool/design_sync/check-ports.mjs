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
const WIDGET_RX =
  /^class\s+([A-Z]\w*)(?:<[^>]*>)?\s+extends\s+(?:StatelessWidget|StatefulWidget)\b/gm;

const cfg = existsSync(EXCEPTIONS)
  ? JSON.parse(readFileSync(EXCEPTIONS, 'utf8'))
  : { ignore: [], aliases: {} };
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
      return `components/${group}/${port}/${port}.html`;
    }
  }
  return null;
}

const files = process.argv.slice(2).filter((f) => f.endsWith('.dart'));
const missing = [];
let checked = 0;

for (const rel of files) {
  const abs = resolve(REPO, rel);
  if (!existsSync(abs)) continue; // borrado en la misma PR
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
      console.log(`  ✓ ${cls} → _src/${port}/ + ${card}`);
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
    ? `Faltan tool/design_sync/_src/${port}/${port}.impl.js y su tarjeta components/<grupo>/${port}/${port}.html`
    : !hasImpl
      ? `Falta tool/design_sync/_src/${port}/${port}.impl.js (la tarjeta ${card} sí está)`
      : `Falta la tarjeta components/<grupo>/${port}/${port}.html (el _src/${port}/ sí está)`;
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
