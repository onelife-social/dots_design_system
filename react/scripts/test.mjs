// Runs test/*.test.jsx with node's test runner. esbuild bundles each file with the TSX it imports into
// .build/test; react and react-dom stay external and resolve from node_modules. Run: npm test
import { build } from 'esbuild';
import { spawnSync } from 'node:child_process';
import { readdirSync, rmSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const PKG_DIR = dirname(dirname(fileURLToPath(import.meta.url))); // react/
const TEST_DIR = join(PKG_DIR, 'test');
const OUT_DIR = join(PKG_DIR, '.build', 'test');

const entries = readdirSync(TEST_DIR).filter((n) => n.endsWith('.test.jsx'));
rmSync(OUT_DIR, { recursive: true, force: true });
await build({
  entryPoints: entries.map((n) => join(TEST_DIR, n)),
  outdir: OUT_DIR,
  outExtension: { '.js': '.mjs' },
  bundle: true,
  platform: 'node',
  format: 'esm',
  jsx: 'automatic',
  packages: 'external',
  logLevel: 'warning',
});

const outputs = readdirSync(OUT_DIR).map((n) => join(OUT_DIR, n));
const run = spawnSync(process.execPath, ['--test', ...outputs], { stdio: 'inherit' });
process.exit(run.status ?? 1);
