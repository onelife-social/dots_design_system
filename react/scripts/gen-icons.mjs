// Adds to src/components/DotsIcon/icons.ts every DotsIconData entry (lib/src/components/icons/dots_icon_data_enum.dart)
// it still lacks, read from assets/icons/<group>/<name>.svg. Existing entries are left as they are. Run: npm run gen:icons
// Conversion: width/height dropped from <svg>, ids suffixed with -<name> so several icons can share a page, and in
// monochrome icons (one colour outside <defs>, not a gradient) every fill/stroke becomes currentColor.
import { existsSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const PKG_DIR = dirname(dirname(fileURLToPath(import.meta.url))); // react/
const ROOT = dirname(PKG_DIR);
const ICONS_TS = join(PKG_DIR, 'src', 'components', 'DotsIcon', 'icons.ts');
const ENUM = join(ROOT, 'lib', 'src', 'components', 'icons', 'dots_icon_data_enum.dart');

const ts = readFileSync(ICONS_TS, 'utf8');
const have = new Set([...ts.matchAll(/^ {2}"([^"]+)": /gm)].map((m) => m[1]));

const dart = readFileSync(ENUM, 'utf8');
const folderOf = Object.fromEntries([...dart.matchAll(/^\s+(\w+)\('(\w+)'\),?$/gm)].map((m) => [m[1], m[2]]));
const entries = [...dart.matchAll(/^\s+\w+\('([^']+)\.svg',\s*DotsIconGroup\.(\w+)\)/gm)].map((m) => ({
  name: m[1],
  folder: folderOf[m[2]],
}));

function convert(name, svg) {
  let s = svg.replace(/\r?\n/g, '').trim();
  s = s.replace(/^<svg([^>]*?)\s+width="[^"]*"\s+height="[^"]*"/, '<svg$1');
  s = s.replace(/id="([^"]+)"/g, `id="$1-${name}"`).replace(/url\(#([^)]+)\)/g, `url(#$1-${name})`);
  const outsideDefs = s.replace(/<defs>[\s\S]*?<\/defs>/g, '');
  const colors = new Set([...outsideDefs.matchAll(/(?:fill|stroke)="([^"]+)"/g)].map((m) => m[1]).filter((c) => c !== 'none'));
  const monochrome = colors.size === 1 && !colors.values().next().value.startsWith('url(');
  if (monochrome) s = s.replace(/(fill|stroke)="([^"]+)"/g, (m, attr, value) => (value === 'none' ? m : `${attr}="currentColor"`));
  return s;
}

const added = [];
for (const { name, folder } of entries) {
  if (have.has(name)) continue;
  const file = join(ROOT, 'assets', 'icons', folder, `${name}.svg`);
  if (!existsSync(file)) {
    console.warn(`! ${name}: no ${folder}/${name}.svg`);
    continue;
  }
  added.push(`  ${JSON.stringify(name)}: ${JSON.stringify(convert(name, readFileSync(file, 'utf8')))},`);
  have.add(name);
}

if (added.length) writeFileSync(ICONS_TS, ts.replace(/\n\} as const;/, `\n${added.join('\n')}\n} as const;`));
console.log(added.length ? `+ ${added.length} icons: ${added.map((l) => l.match(/"([^"]+)"/)[1]).join(', ')}` : 'icons.ts is up to date');
