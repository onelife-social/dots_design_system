DotsRadioButton from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsRadioButton` (bundle loaded from the root `_ds_bundle.js`). Circular radio (24 px, 2 px border) with off/on/disabled states; controlled (`isSelected` + `onChanged`) or uncontrolled (`defaultSelected`).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `isSelected` | `boolean` | — | Estado seleccionado (modo controlado). |
| `defaultSelected` | `boolean` | `false` | Estado inicial en modo no controlado (pulsar selecciona; no se des-selecciona). |
| `onChanged` | `(isSelected: boolean) => void` | — | Se invoca con `true` al pulsar. |
| `size` | `number` | `24` | Diámetro en px. |
| `disabled` | `boolean` | `false` | Deshabilita (opacidad 0.4, sin interacción). Extensión web. |

## Examples

```jsx
// Grupo controlado
const [sel, setSel] = React.useState('a');
<DotsRadioButton isSelected={sel === 'a'} onChanged={() => setSel('a')} />
<DotsRadioButton isSelected={sel === 'b'} onChanged={() => setSel('b')} />

// No controlado
<DotsRadioButton defaultSelected={false} />
```

## Dart mapping

- Widget: `DotsRadioButton` (`lib/src/components/buttons/dots_radio_button.dart`).
- `isSelected` → `isSelected`; `size` → `size` (default 24).
- Seleccionado: borde `labelHighlight` + `DotsIcon(DotsIconData.selector, 15, labelHighlight)` → `h(DotsIcon, { name: 'ic-selector', size: 15 })`. No seleccionado: borde `labelSecondary`.
- `defaultSelected`, `onChanged` y `disabled` no existen en Dart (el widget es solo visual); son extensiones web para el canvas.
