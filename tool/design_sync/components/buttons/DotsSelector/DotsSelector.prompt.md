DotsSelector from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsSelector` (bundle loaded from the root `_ds_bundle.js`). Circular photo-overlay selector: off = 70% white ring; on = labelHighlight pill with a check (`variant: 'check'`) or a number (`variant: 'num'`); sizes small (22) / medium (24); controlled (`isSelected` + `onChanged`) or uncontrolled (`defaultSelected`).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `variant` | `'check' \| 'num'` | `'check'` | Check o número dentro de la píldora al seleccionar. |
| `size` | `'small' \| 'medium'` | `'medium'` | Altura 22 / 24 px. |
| `isSelected` | `boolean` | — | Estado seleccionado (modo controlado). |
| `defaultSelected` | `boolean` | `false` | Estado inicial en modo no controlado (click alterna). |
| `onChanged` | `(isSelected: boolean) => void` | — | Se invoca con el nuevo estado al pulsar. |
| `number` | `number` | `1` | Número mostrado (solo `variant: 'num'` y seleccionado). |

## Examples

```jsx
// Selección de fotos (controlado)
<DotsSelector isSelected={selected.has(photo.id)} onChanged={() => toggle(photo.id)} />

// Orden de selección con número
<DotsSelector variant="num" isSelected number={3} />

// No controlado
<DotsSelector defaultSelected={false} />
```

Colócalo superpuesto a una imagen (está diseñado para fotos: el estado off es un aro blanco al 70%).

## Dart mapping

- Widget: `DotsSelector` (`lib/src/components/buttons/dots_selector.dart`), factories `DotsSelector.check` / `DotsSelector.num`.
- `variant` → `DotsSelectorVariant.check/num`; `size` → `DotsSelectorSize.small/medium` (height 22/24); `isSelected` → `isSelected`; `number` → `number`.
- Seleccionado: píldora `labelHighlight`, minWidth = height, padding horizontal 5, radio = height; check = `DotsIcon(DotsIconData.check, 14, labelAlwaysWhite)` → `ic-check`; número = bodyDefaultMedium 14 blanco.
- No seleccionado: círculo con borde 2 `labelAlwaysWhite.dotsWithOpacity(0.7)` (#FFFFFFB3, sin token — igual en light y dark).
- `defaultSelected` y `onChanged` no existen en Dart (el widget es solo visual); son extensiones web para el canvas.
