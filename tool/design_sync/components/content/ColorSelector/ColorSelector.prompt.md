ColorSelector from dots_design_system. Use via `window.DotsDesignSystem_9e41da.ColorSelector` (bundle loaded from the root `_ds_bundle.js`). Horizontally scrollable row of selectable color circles with two variants: 'options' (fixed DotsColorOption palette, white check on the selected circle) and 'selector' (arbitrary CSS colors with a labelHighlight ring and shaded dot).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `variant` | `'options' \| 'selector'` | `'options'` | 'options' = DotsColorOptionsRow · 'selector' = DotsColorSelectorRow |
| `colors` | `string[]` | paleta de 15 (options) | En 'options': nombres `DotsColorOption` (`'couple007'`, `'class005'`…). En 'selector': colores CSS (`'#E55451'`) — requerido |
| `selected` | `string` | — | Valor seleccionado (comparación por igualdad con `colors`) |
| `onColorSelected` | `(color) => void` | — | Callback al pulsar; recibe el valor de `colors` |
| `size` | `number` | `32` | Diámetro de cada círculo en px |
| `spacing` | `number` | `18` / `12` | Separación (18 en 'options', 12 en 'selector' — defaults Dart) |

Notas:
- 'options': borde negro 10% de 1.5px; seleccionado → borde negro 25% de 2px + check `ic-check-thick` blanco a `size*0.5`.
- 'selector': anillo exterior `labelHighlight` 1.5px (solo seleccionado), padding 2.5, dot con la textura real `color_shadow.webp` (data URI) y borde interior negro 25%.
- La fila scrollea horizontal con 16px de padding en los extremos (como el Row Dart).
- Los hex de `DotsColorOption` son idénticos en light y dark; `textQuarternary` usa el token.
- Paleta default 'options' (orden Dart): textQuarternary, couple007, friends002, friends010, friends005, class005, wedding002, family006, family004, child006, child002, celebration002, hobby009, hobby004, couple005.

## Examples

```jsx
const { ColorSelector } = window.DotsDesignSystem_9e41da;

// Paleta estándar de álbum (DotsColorOptionsRow)
const [color, setColor] = React.useState('friends002');
<ColorSelector selected={color} onColorSelected={setColor} />

// Subset de opciones más pequeño
<ColorSelector colors={['couple007', 'class005', 'family001']} size={24} spacing={10}
               selected={color} onColorSelected={setColor} />

// Selector de colores libres (DotsColorSelectorRow, p.ej. portada del DotBook)
<ColorSelector variant="selector"
               colors={['#E55451', '#F4BD24', '#569AF8', '#77D98A', '#B175B1']}
               selected={hex} onColorSelected={setHex} />
```

## Dart mapping

- Widgets: `DotsColorOptionsRow` + enum `DotsColorOption` (`lib/src/components/color_options/color_options.dart`) → `variant='options'`; `DotsColorSelectorRow` (`color_selector.dart`) → `variant='selector'`.
- Props: `onColorSelected` 1:1 (recibe el nombre del enum o el color CSS en lugar de `DotsColorOption`/`Color`); `selectedColor`→`selected`; `size`/`spacing` 1:1; `colors: List<Color>`→`colors: string[]`.
- Assets: `ImagesPaths.colorSelectorShadow` (`assets/images/dotbook/color_shadow.webp`) embebido como data URI en el CSS; check = icono real `ic-check-thick` (`DotsIconData.checkThick`).
- Excepción de tokens documentada: los hex de `DotsColorOption` no existen como token CSS (en Dart tampoco cambian entre temas); los bordes negros usan `Colors.black` con opacidad, no un token.
