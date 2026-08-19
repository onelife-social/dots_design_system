DotsInputStepper from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsInputStepper` (bundle loaded from the root `_ds_bundle.js`). 116 × 41 pill stepper with − / + buttons that disable at `minValue` / `maxValue`; controlled (`value` + `onIncrement`/`onDecrement`) or uncontrolled (`defaultValue` + `onChanged`).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `value` | `number` | — | Valor mostrado (modo controlado). |
| `defaultValue` | `number` | `minValue` | Valor inicial en modo no controlado. |
| `minValue` | `number` | `0` | Mínimo (en Dart es requerido). |
| `maxValue` | `number` | `99` | Máximo (en Dart es requerido). |
| `onIncrement` | `() => void` | — | Pulsación de +. |
| `onDecrement` | `() => void` | — | Pulsación de −. |
| `onChanged` | `(value: number) => void` | — | Nuevo valor tras cada pulsación (extensión web). |

## Examples

```jsx
// Controlado (espejo del uso Dart)
const [qty, setQty] = React.useState(3);
<DotsInputStepper value={qty} minValue={1} maxValue={10}
  onIncrement={() => setQty(qty + 1)} onDecrement={() => setQty(qty - 1)} />

// No controlado
<DotsInputStepper defaultValue={2} minValue={0} maxValue={5} onChanged={console.log} />
```

## Dart mapping

- Widget: `DotsInputStepper` (`lib/src/components/buttons/dots_input_stepper.dart`).
- `value`/`minValue`/`maxValue`/`onIncrement`/`onDecrement` son 1:1 con Dart; `defaultValue` y `onChanged` son extensiones web para el canvas.
- Contenedor: `bgContainerSecondaryOnBackground`, 116 × 41, radio 1000, padding horizontal 6.
- Botones: `DotsIconButton` small (28) sin fondo ni blur con `DotsIconData.rest`/`add` → `h(DotsIcon, { name: 'ic-rest' | 'ic-add', size: 14 })`; habilitado `textTertiary`, deshabilitado `textDisabled`.
- Valor: bodyLargeMedium (16/500) en `textPrimary`.
