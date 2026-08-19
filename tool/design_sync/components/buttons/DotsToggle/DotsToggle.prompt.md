DotsToggle from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsToggle` (bundle loaded from the root `_ds_bundle.js`). iOS-style switch (44.42×27, animated white knob) with on/off and optional disabled state; controlled (`isSelected` + `onChanged`) or uncontrolled (`defaultSelected`).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `isSelected` | `boolean` | — | Estado seleccionado (modo controlado). Si se pasa, el componente no gestiona estado interno. |
| `defaultSelected` | `boolean` | `false` | Estado inicial en modo no controlado. |
| `onChanged` | `(isSelected: boolean) => void` | — | Se invoca con el nuevo valor al pulsar. |
| `disabled` | `boolean` | `false` | Deshabilita el toggle (opacidad 0.4, sin interacción). Extensión web. |

## Examples

```jsx
// No controlado
<DotsToggle defaultSelected onChanged={(v) => console.log(v)} />

// Controlado
const [on, setOn] = React.useState(false);
<DotsToggle isSelected={on} onChanged={setOn} />

// Deshabilitado
<DotsToggle isSelected disabled />
```

## Dart mapping

- Widget: `DotsToggle` (`lib/src/components/buttons/dots_toggle.dart`).
- `isSelected` → `isSelected`; `onChanged` → `onChanged(bool)` (recibe el valor invertido, como en Dart).
- `defaultSelected` y `disabled` no existen en Dart (extensiones web para el canvas).
- Colores: on `labelHighlight`, off `fillSecondary` (sin token CSS, hex documentado), knob `labelAlwaysWhite` con las 3 sombras literales del Dart.
