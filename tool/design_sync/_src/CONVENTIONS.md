# Convenciones para portar componentes Dots a React (bundle Claude Design)

Staging: cada componente produce archivos en DOS sitios:

1. `tool/design_sync/_src/<Name>/` (staging, NO se sube):
   - `<Name>.impl.js` — implementación React (formato abajo)
   - `<Name>.css` — estilos del componente (formato abajo)
2. `tool/design_sync/components/<group>/<Name>/` (se sube):
   - `<Name>.html` — tarjeta de variantes (plantilla abajo)
   - `<Name>.d.ts` — interfaz de props
   - `<Name>.prompt.md` — doc de uso para el agente de diseño
   - (el stub `<Name>.jsx` lo genera build.mjs — NO crearlo)

Namespace global: `DotsDesignSystem_9e41da`. Grupos válidos (lowercase):
`icons`, `buttons`, `inputs`, `feedback`, `navigation`, `indicators`.

## <Name>.impl.js

Un único statement que asigna al namespace. Se concatena dentro de un IIFE
donde ya existen: `__ds` (el namespace), `h` (createElement lazy) y `hooks()`
(devuelve window.React). NO usar import/export ni JSX. NO redeclarar h/__ds.

```js
// DotsMainButton — port de lib/src/components/buttons/dots_main_button/ (Dart = fuente de verdad)
__ds.DotsMainButton = (function () {
  'use strict';
  function DotsMainButton(props) {
    const { useState } = hooks();           // hooks SOLO así, dentro del render
    const variant = props.variant || 'primary';
    return h('button', {
      className: 'ds-main-btn ds-main-btn--' + variant + (props.disabled ? ' is-disabled' : ''),
      disabled: !!props.disabled,
      onClick: props.onClick,
    }, props.icon ? h(__ds.DotsIcon, { name: props.icon, size: 20 }) : null, props.label);
  }
  return DotsMainButton;
})();
```

Reglas:
- Nombres de props en camelCase espejo de la API Dart (`variant`, `size`, `disabled`,
  `label`, `onTap`→`onClick`). Documenta el mapeo en el .prompt.md.
- Valores de variantes = los nombres reales del enum Dart (`primary`, `premium`…).
- Iconos: SIEMPRE `h(__ds.DotsIcon, { name: 'ic-…', size, color })` con el nombre
  real del asset (assets/icons/<carpeta>/<archivo>.svg → name = archivo sin .svg).
  Nunca SVG dibujado a mano. Si DotsIcon no tiene el nombre, renderiza placeholder — ok.
- Assets de imagen imprescindibles: data URI en el CSS (como en las tarjetas actuales).
- Sin dependencias externas. Solo window.React vía `h`/`hooks()`.

## <Name>.css

Clases prefijadas `ds-` + kebab único del componente (`.ds-main-btn`, `.ds-nav-bar`).
Colores/tipos/radios/blur SIEMPRE via tokens `var(--…)` de foundations/tokens.css.
Squircle → border-radius; blur → backdrop-filter (aproximaciones ya asumidas).
Light y dark salen gratis de los tokens: no hardcodear hex (excepto los ya
inexistentes como token — documenta cualquier excepción con un comentario).

## <Name>.html (tarjeta)

Primera línea EXACTA: `<!-- @dsCard group="<group>" -->`. Plantilla:

```html
<!-- @dsCard group="buttons" -->
<!doctype html>
<html><head><meta charset="utf-8">
  <link rel="stylesheet" href="../../../styles.css">
  <link rel="stylesheet" href="../../../_ds_bundle.css">
  <style>
    body{margin:0;padding:24px;background:var(--bg-base)}
    .ds-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(320px,1fr));gap:20px;align-items:start}
    .ds-cell{border:1px solid #e5e7eb;border-radius:8px;padding:12px;min-width:0;overflow:hidden;transform:translateZ(0)}
    .ds-cell>h4{margin:0 0 8px;font:600 12px system-ui;color:#6b7280;text-transform:uppercase;letter-spacing:.04em}
  </style>
</head><body>
  <div class="ds-grid" id="g"></div>
  <script src="../../../_vendor/react.js"></script>
  <script src="../../../_vendor/react-dom.js"></script>
  <script src="../../../_ds_bundle.js"></script>
  <script>
    var h = React.createElement, NS = window.DotsDesignSystem_9e41da, C = NS.DotsMainButton;
    var variants = [
      ['primary', h(C, { label: 'Continuar', variant: 'primary' })],
      ['premium', h(C, { label: 'Hazte premium', variant: 'premium' })]
      // …una celda por variante/estado relevante (incluye disabled, dark si aplica)
    ];
    var g = document.getElementById('g');
    variants.forEach(function (v) {
      var cell = document.createElement('div'); cell.className = 'ds-cell';
      var t = document.createElement('h4'); t.textContent = v[0]; cell.appendChild(t);
      var m = document.createElement('div'); cell.appendChild(m); g.appendChild(cell);
      try { ReactDOM.createRoot(m).render(v[1]); } catch (e) { m.textContent = '⚠ ' + e.message; }
    });
  </script>
</body></html>
```

Para celda en dark: envolver el mount en `<div data-theme="dark">` (crea el div
con `m.setAttribute('data-theme','dark'); m.style.background='var(--bg-base)'`).

## <Name>.d.ts

```ts
import * as React from 'react';

/**
 * DotsMainButton — port web de DotsMainButton (Flutter). Una línea de qué es.
 */
export interface DotsMainButtonProps {
  /** Texto del botón */
  label: string;
  /** Variante visual — enum Dart DotsMainButtonVariant */
  variant?: 'primary' | 'secondary' | 'premium' | 'destructive';
  disabled?: boolean;
  onClick?: () => void;
}

export declare const DotsMainButton: React.ComponentType<DotsMainButtonProps>;
```

## <Name>.prompt.md

Primera línea (OBLIGATORIA, es el índice que lee el agente de diseño):
`<Name> from dots_design_system. Use via \`window.DotsDesignSystem_9e41da.<Name>\` (bundle loaded from the root \`_ds_bundle.js\`). <resumen de una frase con las variantes>.`

Después: `## Props` (tabla), `## Examples` (2-3 ejemplos JSX reales),
`## Dart mapping` (widget/enum Dart equivalente, para trazabilidad).

## Fidelidad

La fuente de verdad es el código Dart en lib/src/. Las tarjetas HTML existentes
en tool/design_sync/components/*.html ya son ports fieles CON LOS ICONOS Y ASSETS
REALES — reutiliza su CSS/markup como base, no reinventes. Verifica cada medida,
color y radio contra el Dart.
