PageControl from dots_design_system. Use via `window.DotsDesignSystem_9e41da.PageControl` (bundle loaded from the root `_ds_bundle.js`). Dotbook pagination dots: `main` (8px dots, single active in labelPrimary, padding 18/12) and `background` (6px dots, all dots up to the active one in labelActive over a continuous bgActive pill).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `count` | `number` | — (requerido) | Total de puntos. `count <= 0` reserva la altura (8px main / 18px background) sin pintar. |
| `activeIndex` | `number` | `0` | Índice activo, clampado a `[0, count-1]` como el constructor Dart. |
| `variant` | `'main' \| 'background'` | `'main'` | `main`: solo el punto activo cambia de color. `background`: activos todos hasta `activeIndex`, con píldora de fondo bgActive redondeada en los extremos (radio 9). |
| `dotColor` | `string` | labelSecondary | Color de los puntos inactivos. |
| `activeColor` | `string` | labelPrimary (main) / labelActive (background) | Color del punto activo. |
| `className` | `string` | — | Clases extra sobre `.ds-page-control`. |

Ocupa el 100% del ancho con los puntos centrados (Row centrado en Flutter). Medidas por variante: main dot 8 / spacing 8 / padding 18px 12px; background dot 6 / spacing 12 / sin padding.

⚠️ **Requiere ancho acotado en Flutter**: el widget Dart usa `SizedBox(width: double.infinity)` interno, así que en contextos sin límite de ancho (`Positioned` sin right/width, etc.) hay que envolverlo en un `SizedBox`. Su ancho natural es `count × (dot + spacing) + padding horizontal` — variante main: `count × 16 + 24` (p.ej. 72px con 3 puntos). En un diseño `.dc.html`, da ese valor en el `hint-size` para que la traducción a Flutter lo aplique.

## Examples

```jsx
const { PageControl } = window.DotsDesignSystem_9e41da;

// Paginación estándar del carrusel del dotbook
<PageControl count={5} activeIndex={page} />

// Progreso acumulado (variante background)
<PageControl count={5} activeIndex={2} variant="background" />

// Colores custom
<PageControl count={5} activeIndex={2} dotColor="var(--bg-highlight)" activeColor="var(--label-highlight)" />
```

## Dart mapping

| Web | Dart (`lib/src/components/dot_book/page_control.dart` + `page_control_theme.dart`) |
| --- | --- |
| `PageControl` | `PageControl` |
| `variant: 'main' \| 'background'` | enum `PageControlVariant` |
| `count` / `activeIndex` (clamp) / `dotColor` / `activeColor` | mismos nombres |
| medidas y colores por variante | `getPageControlTheme` (`PageControlThemeData`: dotSize 8/6, dotSpacing 8/12, activeColor labelPrimary/labelActive, activeBackgroundColor bgActive, contentPadding 18·12/zero) |
| radios de la píldora (9, extremos) | `_getBorderRadius` — radio `(dotSize + dotSpacing) / 2` |
