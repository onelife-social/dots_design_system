// Builds the Claude Design bundle in ../tool/design_sync from this package.
//
//   _ds_bundle.js   = header (@ds-bundle format 4) + TSX components (esbuild, IIFE,
//                     React taken from window) + legacy components (_src/<Name>/<Name>.impl.js)
//   _ds_bundle.css  = component styles (TSX ones first, then legacy)
//   foundations/tokens.css + assets/fonts = copied from src/ (single source)
//   styles.css, .jsx stubs, .d.ts of ported components, _ds_needs_recompile sentinel
//
// Replaces the former tool/design_sync/_src/build.mjs. Run: npm run build:bundle
import { build } from 'esbuild';
import { execSync } from 'node:child_process';
import { createHash } from 'node:crypto';
import {
  cpSync, existsSync, mkdirSync, readFileSync, readdirSync, rmSync, statSync, writeFileSync,
} from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const PKG_DIR = dirname(dirname(fileURLToPath(import.meta.url))); // react/
const REPO = dirname(PKG_DIR);
const DS = join(REPO, 'tool', 'design_sync');
const LEGACY_SRC = join(DS, '_src');
const COMP_ROOT = join(DS, 'components');
const BUILD_DIR = join(PKG_DIR, '.build');
const NAMESPACE = 'DotsDesignSystem_9e41da';
const PKG = JSON.parse(readFileSync(join(PKG_DIR, 'package.json'), 'utf8'));

const dirs = (p) => readdirSync(p).filter((n) => statSync(join(p, n)).isDirectory());
const iconFirst = (a, b) => (a === 'DotsIcon' ? -1 : b === 'DotsIcon' ? 1 : a.localeCompare(b));

// ── which components come from where ────────────────────────────────────────
const ported = dirs(join(PKG_DIR, 'src', 'components')).sort(iconFirst);
const legacy = dirs(LEGACY_SRC)
  .filter((n) => existsSync(join(LEGACY_SRC, n, `${n}.impl.js`)))
  .sort(iconFirst);
const clash = ported.filter((n) => legacy.includes(n));
if (clash.length) {
  console.error(`✗ ported AND legacy at the same time (delete _src/<Name>): ${clash.join(', ')}`);
  process.exit(1);
}
const names = [...ported, ...legacy];

// ── components/<group>/<Name> card dir of each ──────────────────────────────
const groupOf = {};
for (const g of dirs(COMP_ROOT)) for (const n of dirs(join(COMP_ROOT, g))) groupOf[n] = g;
const missing = names.filter((n) => !groupOf[n]);
if (missing.length) {
  console.error(`✗ no components/<group>/<Name> card dir for: ${missing.join(', ')}`);
  process.exit(1);
}

// ── TSX components → IIFE that assigns into window[NAMESPACE] ───────────────
rmSync(BUILD_DIR, { recursive: true, force: true });
mkdirSync(BUILD_DIR, { recursive: true });
const windowReact = {
  name: 'window-react',
  setup(b) {
    b.onResolve({ filter: /^react(\/jsx-runtime)?$/ }, (a) => ({ path: a.path, namespace: 'window-react' }));
    b.onLoad({ filter: /.*/, namespace: 'window-react' }, () => ({
      contents: 'module.exports = window.React;',
      loader: 'js',
    }));
  },
};
const portedOut = join(BUILD_DIR, 'ported.js');
await build({
  entryPoints: [join(PKG_DIR, 'src', 'bundle.ts')],
  bundle: true,
  format: 'iife',
  target: 'es2020',
  outfile: portedOut,
  // The package tsconfig uses react-jsx (automatic runtime) for apps; the Claude Design
  // bundle must use the classic transform because only window.React exists there.
  tsconfigRaw: { compilerOptions: { jsx: 'react', jsxFactory: 'React.createElement', jsxFragmentFactory: 'React.Fragment' } },
  jsx: 'transform',
  jsxFactory: 'React.createElement',
  jsxFragment: 'React.Fragment',
  inject: [join(PKG_DIR, 'scripts', 'react-shim.js')],
  plugins: [windowReact],
  legalComments: 'none',
  logLevel: 'error',
});

// ── _ds_bundle.js ───────────────────────────────────────────────────────────
const legacyChunks = legacy.map((n) => readFileSync(join(LEGACY_SRC, n, `${n}.impl.js`), 'utf8'));
const body = `(() => {

const __ds_ns = (window.${NAMESPACE} = window.${NAMESPACE} || {});
const __ds = __ds_ns;
(__ds_ns.__errors = __ds_ns.__errors || []);
const h = (...a) => window.React.createElement(...a);
const hooks = () => window.React;

/* ── ported (react/src, TSX) ── */
${readFileSync(portedOut, 'utf8')}

/* ── legacy (tool/design_sync/_src) ── */
${legacyChunks.join('\n\n')}

})();
`;
for (const n of names) {
  const dir = join(COMP_ROOT, groupOf[n], n);
  writeFileSync(
    join(dir, `${n}.jsx`),
    `// Re-export of ${PKG.name}@${PKG.version} ${n}. Implementation is in the root _ds_bundle.js (window.${NAMESPACE}).\n` +
      `Object.assign(window, { ${n}: window.${NAMESPACE}.${n} });\n`,
  );
}
const sourceHashes = {};
for (const n of names) {
  const base = `components/${groupOf[n]}/${n}/${n}`;
  for (const ext of ['.jsx', '.d.ts', '.prompt.md']) {
    const p = join(DS, base + ext);
    if (existsSync(p)) sourceHashes[base + ext] = createHash('sha256').update(readFileSync(p)).digest('hex').slice(0, 12);
  }
}
const meta = {
  format: 4,
  namespace: NAMESPACE,
  components: names.map((n) => ({ name: n, sourcePath: `components/${groupOf[n]}/${n}/${n}.jsx` })),
  sourceHashes,
  inlinedExternals: [],
  unexposedExports: [],
  builtBy: 'dots-design-system-react',
};
const bundleJs = join(DS, '_ds_bundle.js');
writeFileSync(bundleJs, `/* @ds-bundle: ${JSON.stringify(meta).replace(/\*\//g, '*\\/')} */\n` + body);

// ── _ds_bundle.css ──────────────────────────────────────────────────────────
const cssOf = (n) =>
  ported.includes(n) ? join(PKG_DIR, 'src', 'components', n, `${n}.css`) : join(LEGACY_SRC, n, `${n}.css`);
const css = names
  .filter((n) => existsSync(cssOf(n)))
  .map((n) => `/* ── ${n} ── */\n` + readFileSync(cssOf(n), 'utf8'))
  .join('\n');
writeFileSync(join(DS, '_ds_bundle.css'), css + '\n');

// ── tokens + fonts (single source: react/src) ───────────────────────────────
mkdirSync(join(DS, 'foundations'), { recursive: true });
cpSync(join(PKG_DIR, 'src', 'foundations', 'tokens.css'), join(DS, 'foundations', 'tokens.css'));
cpSync(join(PKG_DIR, 'src', 'assets', 'fonts'), join(DS, 'assets', 'fonts'), { recursive: true });

// ── styles.css (single style entry for designs) ─────────────────────────────
writeFileSync(
  join(DS, 'styles.css'),
  `/* Entrada única de estilos del DS — los diseños consumen SOLO esta clausura. */
@import "./foundations/tokens.css";
@import "./_ds_bundle.css";
`,
);

// ── .d.ts of ported components (from tsc) ───────────────────────────────────
const typesDir = join(BUILD_DIR, 'types');
execSync(`npx tsc -p tsconfig.json --noEmit false --emitDeclarationOnly --declaration --outDir ${typesDir}`, {
  cwd: PKG_DIR,
  stdio: 'inherit',
});
for (const n of ported) {
  const gen = join(typesDir, 'components', n, `${n}.d.ts`);
  if (!existsSync(gen)) continue;
  const txt = readFileSync(gen, 'utf8');
  if (/from '\.{1,2}\//.test(txt)) {
    console.warn(`! ${n}.d.ts keeps the hand-written card copy (generated one has relative imports)`);
    continue;
  }
  writeFileSync(join(COMP_ROOT, groupOf[n], n, `${n}.d.ts`), `import * as React from 'react';\n\n${txt}`);
}

// ── sentinel ────────────────────────────────────────────────────────────────
writeFileSync(join(DS, '_ds_needs_recompile'), '{"by":"design-sync-cli"}\n');

// ── checks ──────────────────────────────────────────────────────────────────
try {
  new Function(readFileSync(bundleJs, 'utf8'));
  console.log(`✓ _ds_bundle.js: ${(statSync(bundleJs).size / 1024).toFixed(0)} KB, syntax OK`);
} catch (e) {
  console.error(`✗ _ds_bundle.js syntax: ${e.message}`);
  process.exit(1);
}
for (const n of names) {
  const dir = join(COMP_ROOT, groupOf[n], n);
  for (const ext of ['.html', '.d.ts', '.prompt.md']) {
    if (!existsSync(join(dir, `${n}${ext}`))) console.error(`! missing ${groupOf[n]}/${n}/${n}${ext}`);
  }
  const html = existsSync(join(dir, `${n}.html`)) ? readFileSync(join(dir, `${n}.html`), 'utf8') : '';
  if (html && !/^<!--\s*@dsCard\s+group="[^"]*"[^>]*-->/.test(html.split('\n', 1)[0]))
    console.error(`! ${n}.html: first line without @dsCard`);
}
console.log(`✓ ${ported.length} ported (TSX): ${ported.join(', ')}`);
console.log(`✓ ${legacy.length} legacy (_src)`);
