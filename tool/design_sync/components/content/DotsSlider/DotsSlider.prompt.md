DotsSlider from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsSlider` (bundle loaded from the root `_ds_bundle.js`). Horizontal slider with side icons (default `ic-user`/`ic-group`), 9px track, 28px white thumb and optional discrete divisions with snap; pointer-event drag, controlled (`value` + `onChanged`) or uncontrolled (`defaultValue`).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `value` | `number` | — | Valor actual (modo controlado). Si se pasa sin `onChanged`, el slider se muestra estático (como en Flutter con `onChanged: null`). |
| `defaultValue` | `number` | `0` | Valor inicial en modo no controlado (extensión web). |
| `divisions` | `number \| null` | `null` | Divisiones discretas con snap y tick marks; null → continuo. |
| `max` | `number` | `1.0` | Valor máximo (mínimo fijo 0, como en Dart). |
| `onChanged` | `(value: number) => void` | — | Nuevo valor al pulsar/arrastrar (ya con snap si hay `divisions`). |
| `leftIcon` | `string` | `'ic-user'` | Icono izquierdo (asset real `ic-…`), 20px `labelSecondary`. |
| `rightIcon` | `string` | `'ic-group'` | Icono derecho, 20px `labelSecondary`. |

## Examples

```jsx
// No controlado, 4 divisiones
<DotsSlider defaultValue={0.5} divisions={4} onChanged={(v) => console.log(v)} />

// Controlado y continuo
const [v, setV] = React.useState(0.25);
<DotsSlider value={v} divisions={null} onChanged={setV} />

// Rango 0..10 con iconos custom
<DotsSlider defaultValue={3} max={10} divisions={10} leftIcon="ic-pic" rightIcon="ic-pics" />
```

## Dart mapping

- Widget: `DotsSlider` (`lib/src/components/slider/dots_slider.dart`), que envuelve `Slider` con `SliderTheme`.
- `value`/`divisions`/`max`/`onChanged`/`leftIcon`/`rightIcon` espejo directo; `defaultValue` es extensión web.
- Theme: track 9px `RoundedRectSliderTrackShape` (activo `labelHighlight`, inactivo `bgContainerSecondary`), thumb `RoundSliderThumbShape` radio 14 → 28px `labelAlwaysWhite` (sombra elevation 1 literal), ticks `labelSecondary`.
- Drag: pointer events con `setPointerCapture` sobre el track (`touch-action: none`).
