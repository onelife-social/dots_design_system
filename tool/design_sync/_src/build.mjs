// Ensambla _ds_bundle.js, _ds_bundle.css, styles.css, stubs .jsx y el sentinel
// a partir de _src/<Name>/{<Name>.impl.js,<Name>.css} y components/<group>/<Name>/.
// Formato objetivo: el contrato @ds-bundle format 4 de claude.ai/design.
import { createHash } from 'node:crypto';
import { existsSync, mkdirSync, readFileSync, readdirSync, statSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = dirname(dirname(fileURLToPath(import.meta.url))); // tool/design_sync
const SRC = join(ROOT, '_src');
const NAMESPACE = 'DotsDesignSystem_9e41da';
const PKG = 'dots_design_system';
const VERSION = '0.0.1';

// ── descubrir componentes: _src/<Name>/<Name>.impl.js ───────────────────────
const names = readdirSync(SRC).filter(
  (n) => statSync(join(SRC, n)).isDirectory() && existsSync(join(SRC, n, `${n}.impl.js`)),
);
// DotsIcon primero: otros componentes lo referencian.
names.sort((a, b) => (a === 'DotsIcon' ? -1 : b === 'DotsIcon' ? 1 : a.localeCompare(b)));

// ── localizar el dir components/<group>/<Name> de cada uno ──────────────────
const compRoot = join(ROOT, 'components');
const groupOf = {};
for (const g of readdirSync(compRoot)) {
  const gp = join(compRoot, g);
  if (!statSync(gp).isDirectory()) continue;
  for (const n of readdirSync(gp)) {
    if (statSync(join(gp, n)).isDirectory()) groupOf[n] = g;
  }
}
const missing = names.filter((n) => !groupOf[n]);
if (missing.length) {
  console.error(`✗ sin dir components/<group>/<Name>: ${missing.join(', ')}`);
  process.exit(1);
}

// ── _ds_bundle.js ───────────────────────────────────────────────────────────
const chunks = names.map((n) => readFileSync(join(SRC, n, `${n}.impl.js`), 'utf8'));
const body = `(() => {

const __ds_ns = (window.${NAMESPACE} = window.${NAMESPACE} || {});
const __ds = __ds_ns;
(__ds_ns.__errors = __ds_ns.__errors || []);
const h = (...a) => window.React.createElement(...a);
const hooks = () => window.React;

${chunks.join('\n\n')}

})();
`;
const bundleJs = join(ROOT, '_ds_bundle.js');
writeFileSync(bundleJs, body);

// ── stubs .jsx ──────────────────────────────────────────────────────────────
for (const n of names) {
  const dir = join(compRoot, groupOf[n], n);
  writeFileSync(
    join(dir, `${n}.jsx`),
    `// Re-export of ${PKG}@${VERSION} ${n}. Implementation is in the root _ds_bundle.js (window.${NAMESPACE}).\n` +
      `Object.assign(window, { ${n}: window.${NAMESPACE}.${n} });\n`,
  );
}

// ── header @ds-bundle ───────────────────────────────────────────────────────
const sourceHashes = {};
for (const n of names) {
  const base = `components/${groupOf[n]}/${n}/${n}`;
  for (const ext of ['.jsx', '.d.ts', '.prompt.md']) {
    const p = join(ROOT, base + ext);
    if (existsSync(p))
      sourceHashes[base + ext] = createHash('sha256').update(readFileSync(p)).digest('hex').slice(0, 12);
  }
}
const meta = {
  format: 4,
  namespace: NAMESPACE,
  components: names.map((n) => ({ name: n, sourcePath: `components/${groupOf[n]}/${n}/${n}.jsx` })),
  sourceHashes,
  inlinedExternals: [],
  unexposedExports: [],
  builtBy: 'cc-design-sync',
};
const headerJson = JSON.stringify(meta).replace(/\*\//g, '*\\/');
writeFileSync(bundleJs, `/* @ds-bundle: ${headerJson} */\n` + body);

// ── _ds_bundle.css ──────────────────────────────────────────────────────────
const css = names
  .filter((n) => existsSync(join(SRC, n, `${n}.css`)))
  .map((n) => `/* ── ${n} ── */\n` + readFileSync(join(SRC, n, `${n}.css`), 'utf8'))
  .join('\n');
writeFileSync(join(ROOT, '_ds_bundle.css'), css + '\n');

// ── styles.css (única entrada de estilos para los diseños) ──────────────────
writeFileSync(
  join(ROOT, 'styles.css'),
  `/* Entrada única de estilos del DS — los diseños consumen SOLO esta clausura. */
@import "./foundations/tokens.css";
@import "./_ds_bundle.css";
`,
);

// ── sentinel ────────────────────────────────────────────────────────────────
writeFileSync(join(ROOT, '_ds_needs_recompile'), '{"by":"design-sync-cli"}\n');

// ── checks ──────────────────────────────────────────────────────────────────
try {
  new Function(readFileSync(bundleJs, 'utf8'));
  console.log(`✓ _ds_bundle.js: ${(statSync(bundleJs).size / 1024).toFixed(0)} KB, syntax OK`);
} catch (e) {
  console.error(`✗ _ds_bundle.js syntax: ${e.message}`);
  process.exit(1);
}
for (const n of names) {
  const dir = join(compRoot, groupOf[n], n);
  for (const ext of ['.html', '.d.ts', '.prompt.md']) {
    if (!existsSync(join(dir, `${n}${ext}`))) console.error(`! falta ${groupOf[n]}/${n}/${n}${ext}`);
  }
  const html = existsSync(join(dir, `${n}.html`)) ? readFileSync(join(dir, `${n}.html`), 'utf8') : '';
  if (html && !/^<!--\s*@dsCard\s+group="[^"]*"[^>]*-->/.test(html.split('\n', 1)[0]))
    console.error(`! ${n}.html: primera línea sin @dsCard`);
  const pm = join(dir, `${n}.prompt.md`);
  if (existsSync(pm) && !readFileSync(pm, 'utf8').split('\n', 1)[0].trim())
    console.error(`! ${n}.prompt.md: primera línea vacía`);
}
console.log(`✓ ${names.length} componentes: ${names.join(', ')}`);
