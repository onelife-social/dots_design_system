DotsSpinner from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsSpinner` (bundle loaded from the root `_ds_bundle.js`). Circular progress spinner (track + white arc, optional centered percentage) with a web-only `indeterminate` spinning mode.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `progress` | `number` | `0` | Progreso 0..1. El arco transiciona suavemente (`stroke-dasharray` 300ms). |
| `size` | `number` | `43` | Lado en px. |
| `strokeWidth` | `number` | `4` | Grosor del trazo. |
| `showPercentage` | `boolean` | `true` | Muestra `NN%` centrado (11/600, siempre blanco). |
| `indeterminate` | `boolean` | `false` | Extensión web: arco fijo (25%) girando en bucle; ignora `progress` y oculta el %. |
| `className` | `string` | — | Clases extra sobre `.ds-spinner`. |

Colores fijos por diseño: track `bgBtnImage`, arco y texto `labelAlwaysWhite` — pensado para vivir sobre foto/overlay (idéntico en light y dark salvo el track).

## Examples

```jsx
const { DotsSpinner } = window.DotsDesignSystem_9e41da;

// Subida de fotos al 65%
<DotsSpinner progress={0.65} />

// Sin porcentaje, más grande
<DotsSpinner progress={0.4} size={60} strokeWidth={6} showPercentage={false} />

// Carga sin progreso conocido
<DotsSpinner indeterminate />
```

## Dart mapping

| Web | Dart (`lib/src/components/spinner/spinner_round.dart`) |
| --- | --- |
| `DotsSpinner` | `SpinnerRound` (+ `CircularProgressPainter`) |
| `progress` / `size` / `strokeWidth` / `showPercentage` | mismos nombres |
| Arco desde arriba | `startAngle = 270°` |
| Track / arco / texto | `bgBtnImage` / `labelAlwaysWhite` / `labelSmallMedium` blanco |
| `indeterminate` | — (extensión web, sin equivalente Dart) |
