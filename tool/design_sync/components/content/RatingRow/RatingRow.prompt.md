RatingRow from dots_design_system. Use via `window.DotsDesignSystem_9e41da.RatingRow` (bundle loaded from the root `_ds_bundle.js`). Star rating row (5-star or 10-star NPS scale) using the real `ic-star` asset with detractor/neutral/promoter vertical gradients, optional end texts and compact 6+4 layout.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `starLabels` | `string[]` | — | Etiquetas sobre cada estrella. El Dart exige longitud 5 o 10. |
| `selectedIndex` | `number \| null` | `null` | Estrellas `0..selectedIndex` coloreadas; sin valor todas quedan disabled. Escala 10: ≤5 detractor, 6–7 neutral, ≥8 promoter. Escala 5: siempre neutral. |
| `leftText` / `rightText` | `string` | — | Textos bajo la fila (solo layout default), `labelSmallMedium` `textQuarternary`. |
| `onStarTap` | `(index) => void` | — | Pulsación de una estrella. |
| `compact` | `boolean` | `false` | Filas centradas de 6+4 (con 10 estrellas) en vez de una fila spaceBetween. |
| `showStarText` | `boolean` | `true` | Muestra la etiqueta sobre cada estrella. |
| `iconSize` | `number` | `28` | Tamaño del icono `ic-star` en px. |

## Examples

```jsx
// NPS de 10 con textos en los extremos
<RatingRow
  starLabels={['1','2','3','4','5','6','7','8','9','10']}
  selectedIndex={8}
  leftText="Nada probable"
  rightText="Muy probable"
  onStarTap={(i) => setScore(i)}
/>

// Escala de 5 (siempre gradiente neutral)
<RatingRow starLabels={['1','2','3','4','5']} selectedIndex={2} />

// Compacto 6+4
<RatingRow starLabels={['1','2','3','4','5','6','7','8','9','10']} selectedIndex={4} compact />
```

## Dart mapping

- Widgets: `DotsRatingStarRow` (`lib/src/components/rating/rating_row.dart`) + `DotsRatingStar`/`RatingIconVariant` (`rating_star.dart`).
- La estrella es `DotsIcon(DotsIconData.star)` → asset real `ic-star`; el `ShaderMask` del Dart se replica con `fill: url(#linearGradient)` sobre el path del SVG.
- Gradientes (colores accent del theme Dart, sin token CSS — hex documentados en el CSS): detractor `friends001→friends003` (#FAA25E→#FA5B3D), neutral `class008→friends005` (#FCD12A→#F7954A), promoter `family008→team007` (#4FC976→#01AF94); disabled `textDisabled`.
- Layout: maxWidth 342, padding horizontal 6, gap vertical 8; compact = filas de 6 y 4 con separación 5px.
