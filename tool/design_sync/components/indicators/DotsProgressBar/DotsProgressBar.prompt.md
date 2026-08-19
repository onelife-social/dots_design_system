DotsProgressBar from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsProgressBar` (bundle loaded from the root `_ds_bundle.js`). Segmented linear progress bar (5px tall rounded parts, default 3) that fills left to right with an animated width transition.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `percentage` | `number` | — (requerido) | Progreso 0..1 sobre el ancho total. El relleno transiciona (300ms ease). |
| `parts` | `number` | `3` | Número de segmentos (> 0). |
| `width` | `number \| string` | `'100%'` | Ancho total (número → px). |
| `spaceBetween` | `number` | `5` | Hueco entre segmentos en px. |
| `barColor` | `string` | `var(--label-highlight)` | Color del relleno. |
| `bgColor` | `string` | `var(--label-secondary)` | Color de fondo de los segmentos. |
| `className` | `string` | — | Clases extra sobre `.ds-progress-bar`. |

También `DotsProgressBar.byStep(stepNumber, totalSteps)` devuelve el elemento con `percentage = stepNumber / totalSteps` (espejo del factory Dart) — típico para onboardings por pasos.

## Examples

```jsx
const { DotsProgressBar } = window.DotsDesignSystem_9e41da;

// Mitad del recorrido, 3 segmentos
<DotsProgressBar percentage={0.5} />

// Paso 2 de 3 (onboarding)
{DotsProgressBar.byStep(2, 3)}

// 5 segmentos, ancho fijo, colores custom
<DotsProgressBar percentage={0.7} parts={5} width={160} barColor="var(--label-active)" />
```

## Dart mapping

| Web | Dart (`lib/src/components/progress_bar/dots_progress_bar.dart`) |
| --- | --- |
| `DotsProgressBar` | `DotsProgressBar` (+ `_MultiStepProgressPainter`) |
| `percentage` / `parts` / `width` / `spaceBetween` / `barColor` / `bgColor` | mismos nombres (colores default `labelHighlight` / `labelSecondary`) |
| `byStep(n, total)` | factory `DotsProgressBar.byStep` |
| Altura 5px, radio 100px | `SizedBox(height: 5)` + `Radius.circular(100)` |
