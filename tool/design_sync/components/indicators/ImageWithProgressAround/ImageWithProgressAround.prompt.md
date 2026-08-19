ImageWithProgressAround from dots_design_system. Use via `window.DotsDesignSystem_9e41da.ImageWithProgressAround` (bundle loaded from the root `_ds_bundle.js`). Rounded 9:16 (or 3:4) image with a dark overlay showing the percentage and a recap-gradient progress ring drawn around the border, starting at top center and going clockwise.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `progress` | `number` | `0` | 0..1. Igual que el painter Dart, > 1 se trata como porcentaje (72 → 0.72). Transición 800ms easeInOut. |
| `width` | `number` | `150` | Ancho en px; la altura la fija el aspect ratio. |
| `src` | `string` | — | Imagen central (cover). Sin `src` pinta un placeholder de diseño (el Dart no pinta nada). |
| `alt` | `string` | `''` | Alt de la imagen. |
| `aspectRatio` | `'standard' \| 'small'` | `'standard'` | `standard` 9:16 · `small` 3:4 (equivale a `context.isSmallScreen`). |
| `progressBarWidth` | `number` | `6` | Grosor del anillo. |
| `innerPadding` | `number` | `8` | Hueco entre imagen y anillo. |
| `borderRadius` | `number` | `45` | Radio de la imagen interior; el del anillo se deriva (`borderRadius + innerPadding + stroke/2`). |
| `progressBarColors` | `string[]` | gradiente recap | Colores del anillo (SweepGradient Dart → linearGradient SVG, aproximación asumida). |
| `className` | `string` | — | Clases extra sobre `.ds-iwpa`. |

Siempre pinta overlay negro 20 % + `NN%` centrado (titleH3 26/700, blanco). Track del anillo: `bgSecondaryBtn`.

## Examples

```jsx
const { ImageWithProgressAround } = window.DotsDesignSystem_9e41da;

// Recap generándose al 72%
<ImageWithProgressAround width={150} progress={0.72} src={photoUrl} />

// Pantalla pequeña (3:4), anillo más grueso
<ImageWithProgressAround width={120} progress={0.4} aspectRatio="small"
  progressBarWidth={8} src={photoUrl} />
```

## Dart mapping

| Web | Dart (`lib/src/components/progress_bar/image_with_progress_around.dart`) |
| --- | --- |
| `ImageWithProgressAround` | `ImageWithProgressAround` (+ `_BorderProgressPainter`) |
| `src` | `imageProvider` |
| `aspectRatio 'standard'/'small'` | `kStandardAspectRatio` 9:16 / `kSmallAspectRatio` 3:4 (`context.isSmallScreen`) |
| `progress`/`width`/`progressBarWidth`/`innerPadding`/`borderRadius`/`progressBarColors` | mismos nombres |
| Radio del anillo | `borderRadius + padding + strokeWidth / 2` |
| Inicio arriba, horario, cap redondo | idéntico al painter |
| Transición 800ms easeInOut | `animationDuration`/`animationCurve` por defecto |
| Gradiente | `DotsColors.recapGradientColors` (SweepGradient → linearGradient SVG) |
| Overlay + `%` | negro 20 % + `titleH3` `labelAlwaysWhite` |
