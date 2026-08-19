# Dots Design System

Design system of the Dots. Memories app, synced from the Flutter package
`dots_design_system` (the Dart code in `lib/` is the source of truth). Core
components are hand-ported to React and bundled as a single browser global —
**use the real components; do not re-create them with ad-hoc HTML/CSS.**

## Where things are

- `_ds_bundle.js` — the whole-DS bundle at the project root; loads every component
  to `window.DotsDesignSystem_9e41da`. First line is a `/* @ds-bundle: … */`
  metadata header listing the available components.
- `styles.css` — the single stylesheet entry: it `@import`s the design tokens
  (`foundations/tokens.css`, light + dark via `[data-theme="dark"]`) and the
  component styles (`_ds_bundle.css`). Link this one file.
- `components/<group>/<Name>/<Name>.prompt.md` (usage + example JSX),
  `<Name>.d.ts` (props), `<Name>.html` (variant grid card).
- `foundations/` — token/color/typography/style reference cards.
- `components/*.html` (flat files) — visual reference cards for the few pieces
  without a mountable port yet (full icon index, memory details viewer,
  notification item, generic/frame carrousels, dotbook cards and internals).
  Imitate them faithfully when no mountable component exists.
- `assets/fonts/` — real brand font files (Inter, Nunito, P22 Mackinac),
  loaded via `@font-face` in `foundations/tokens.css`.

## Loading

Add these two lines to your page once (React must be on the page first):

```html
<link rel="stylesheet" href="styles.css">
<script src="_ds_bundle.js"></script>
```

Components are then available at `window.DotsDesignSystem_9e41da.*`. Mount into
a dedicated child node (e.g. `<div id="ds-root">`), not the host page's own
React root, so the two trees don't collide:

```jsx
const { DotsMainButton, DotsNavBar, DotsIcon } = window.DotsDesignSystem_9e41da;
ReactDOM.createRoot(document.getElementById('ds-root')).render(
  <DotsMainButton label="Continuar" variant="primary" />
);
```

For a specific component, `read_file("components/<group>/<Name>/<Name>.prompt.md")`.

Icons: always `<DotsIcon name="ic-…" />` — it embeds the app's real SVG assets.
Never draw approximate icons by hand. `DotsIcon.names` lists the catalog;
the full 240-icon visual index is `components/icons.html`.

Dark mode: set `data-theme="dark"` on any ancestor — all tokens switch.

## Onboarding: montar el design system en TU cuenta de Claude

Los proyectos de claude.ai/design pertenecen a cada cuenta (con cuentas Pro no
se comparten entre devs). Este directorio es la fuente de verdad: cada dev
regenera su propio proyecto, idéntico, a partir del repo:

1. Claude Code **≥ 2.1.234** (versiones anteriores fallan con
   `Could not add design scopes to the token`) y `/login` con tu cuenta.
2. Desde la raíz del repo, pide a Claude Code:
   *"Sincroniza tool/design_sync/ a un proyecto Design System nuevo en
   claude.ai/design con DesignSync"*. Orden de subida: primero el archivo
   `_ds_needs_recompile`, luego todo el resto, y re-escribir
   `_ds_needs_recompile` al final (hace que la app recompile su manifiesto).
3. Abre https://claude.ai/design, marca el proyecto como default de tu
   organización si quieres que los diseños nuevos lo usen automáticamente.

Si dos personas comparten cuenta: el proyecto ya existe, no hay que montar
nada — pero re-sincronizad de uno en uno y siempre desde `develop` al día
(la subida no tiene bloqueo y dos syncs simultáneos pueden pisarse).

La coherencia entre las copias de cada cuenta la garantiza git, no claude.ai:
tras un `git pull` que toque `tool/design_sync/`, re-sincroniza.

## Sync notes (Claude Code / DesignSync)

Bundle rebuilt with `node tool/design_sync/_src/build.mjs` from the per-component
sources in `tool/design_sync/_src/` (staging, not uploaded). Cards carry a
first-line `<!-- @dsCard group="…" -->` marker. If Dart tokens or components
change, regenerate the affected port and re-run the build + sync.

Approximations kept from the card layer: squircles → `border-radius`
(no cornerSmoothing), blurs → `backdrop-filter`.
