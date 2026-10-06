DotsSpinner from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsSpinner` (bundle loaded from the root `_ds_bundle.js`). Circular progress spinner (track + arc, optional centered percentage) with a web-only `indeterminate` spinning mode. Two color sets via `tone`: `onPhoto` (white, over photos) and `accent` (blue, over light backgrounds).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `progress` | `number` | `0` | Progreso 0..1. El arco transiciona suavemente (`stroke-dasharray` 300ms). |
| `size` | `number` | `43` | Lado en px. |
| `strokeWidth` | `number` | `4` | Grosor del trazo. |
| `showPercentage` | `boolean` | `true` | Muestra `NN%` centrado (11/600). |
| `tone` | `'onPhoto' \| 'accent'` | `'onPhoto'` | Juego de colores. `onPhoto` sobre foto/overlay; `accent` sobre fondos claros. |
| `indeterminate` | `boolean` | `false` | Extensión web: arco girando en bucle; ignora `progress` y oculta el %. Con `tone="accent"` el arco es de 270° con la cola en degradado. |
| `className` | `string` | — | Clases extra sobre `.ds-spinner`. |

Colores por `tone`:

| `tone` | Track | Arco (sólido) | % |
| --- | --- | --- | --- |
| `onPhoto` | `bgBtnImage` | `labelAlwaysWhite` | `labelAlwaysWhite` |
| `accent` | `bgContainerSecondaryOnBackground` | `labelHighlight` | `textSecondary` |

Usa `accent` siempre que el spinner vaya sobre un fondo claro (`bgBase`): `onPhoto` es blanco y ahí no se ve.
Para pantallas de espera sin progreso medible (p. ej. "creando tu boda") usa `indeterminate` + `tone="accent"` a 28px.

## Examples

```jsx
const { DotsSpinner } = window.DotsDesignSystem_9e41da;

// Subida de fotos al 65%
<DotsSpinner progress={0.65} />

// Sin porcentaje, más grande
<DotsSpinner progress={0.4} size={60} strokeWidth={6} showPercentage={false} />

// Carga sin progreso conocido
<DotsSpinner indeterminate />

// Pantalla de espera sobre fondo claro (Weddings · wedding_creating)
<DotsSpinner indeterminate tone="accent" size={28} strokeWidth={3} />

// Progreso sobre fondo claro, pequeño y sin %
<DotsSpinner progress={0.25} tone="accent" size={17} strokeWidth={2.27} showPercentage={false} />
```

## Dart mapping

| Web | Dart (`lib/src/components/spinner/spinner_round.dart`) |
| --- | --- |
| `DotsSpinner` | `SpinnerRound` (+ `CircularProgressPainter`) |
| `progress` / `size` / `strokeWidth` / `showPercentage` | mismos nombres |
| Arco desde arriba | `startAngle = 270°` |
| `tone` | `tone` (`SpinnerRoundTone.onPhoto` / `.accent`) |
| Track / arco / texto | según `tone` (tabla de arriba) · texto `labelSmallMedium` |
| `indeterminate` | — (extensión web, sin equivalente Dart; el degradado de `accent` tampoco existe en Dart) |
