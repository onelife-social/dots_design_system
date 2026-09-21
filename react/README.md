# @dots/design-system (React)

React + TypeScript implementation of the Dots. Memories design system. The
Dart package at the repo root is the Flutter implementation; both share the
same tokens (`src/foundations/tokens.css`, today generated from the Dart theme).

- `src/components/<Name>/` — one dir per component: `<Name>.tsx` + `<Name>.css`
  (styles only via `var(--…)` tokens). Export it from `src/index.ts` and add
  its CSS to `src/styles.css`.
- `src/foundations/tokens.css`, `src/assets/fonts/` — tokens and brand fonts.
- `npm run build` — typechecks and rebuilds `../tool/design_sync` (the bundle
  Claude Design consumes, mixing these TSX components with the legacy ones in
  `../tool/design_sync/_src`). Sync that directory with DesignSync afterwards.

Consumed by apps as a git dependency pointing at the package source
(`exports` → `src/`), so the app's bundler compiles the TSX. Import the styles
once: `import '@dots/design-system/styles.css'`.
