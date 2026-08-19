DotsCountdown from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsCountdown` (bundle loaded from the root `_ds_bundle.js`). Blurred photo-overlay card with three variants: `recap` (live/static countdown with lock icon), `small` and `big` (time elapsed since an event).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `variant` | `'recap' \| 'small' \| 'big'` | `'recap'` | `recap` = CountdownRecap; `small`/`big` = enum Dart `CountdownEventFinishedVariant`. |
| `title` | `string` | — | Título (recap y big). |
| `targetDate` | `Date \| string \| number` | — | Solo recap. Con ella cuenta atrás real con tick de 1s; al llegar a 0 muestra `description`. |
| `days` / `hours` / `minutes` / `seconds` | `number` | `0` | Solo recap. Valores fijos para diseño estático (se ignoran si hay `targetDate`). Se pintan con `padLeft(2, '0')`. |
| `finished` | `boolean` | `false` | Solo recap estático: fuerza el estado terminado. |
| `description` | `string` | — | Texto del estado terminado (recap). |
| `isDotbook` | `boolean` | `false` | Recap con fondo `textDisabled` en vez de `bgContainerSecondaryOnBackground`. |
| `daysLabel` / `hoursLabel` / `minutesLabel` / `secondsLabel` | `string` | — | Etiquetas bajo cada cifra (recap). |
| `years` / `months` / `days` | `string` | — | Small/big: cifras de tiempo transcurrido. |
| `yearsLabel` / `monthsLabel` / `daysLabel` | `string` | — | Small/big: etiquetas. |
| `conjunctionText` | `string` | — | Small: conjunción entre meses y días («y»). |
| `icon` | `string` | `'ic-wedding-rings'` | Small: nombre de DotsIcon. |
| `className` | `string` | — | Clases extra sobre `.ds-countdown`. |

Diseñado para vivir SOBRE FOTO: fondo translúcido + `blur(20)` + sombra, texto siempre `labelAlwaysWhite`. Recap: 192px de ancho, r24, borde blanco al 30%, candado `ic-lock` 20. Small: fila de 36px de alto con icono 16. Big: 169px con título y fila años/meses/días.

## Examples

```jsx
const { DotsCountdown } = window.DotsDesignSystem_9e41da;

// Cuenta atrás estática (diseño)
<DotsCountdown title="Recap del verano" days={2} hours={14} minutes={36} seconds={8}
  daysLabel="días" hoursLabel="hrs" minutesLabel="min" secondsLabel="seg" />

// Cuenta atrás real + estado terminado
<DotsCountdown title="Recap del verano" targetDate={Date.now() + 3600e3}
  description="Ya casi está listo, vuelve pronto"
  daysLabel="días" hoursLabel="hrs" minutesLabel="min" secondsLabel="seg" />

// Tiempo desde el evento
<DotsCountdown variant="small" years="2" yearsLabel="años" months="3" monthsLabel="meses"
  conjunctionText="y" days="12" daysLabel="días" />
<DotsCountdown variant="big" title="Juntos desde hace" years="2" yearsLabel="años"
  months="3" monthsLabel="meses" days="12" daysLabel="días" conjunctionText="y" />
```

## Dart mapping

| Web | Dart (`lib/src/components/countdown/`) |
| --- | --- |
| `variant: 'recap'` | `CountdownRecap` (countdown_recap.dart) |
| `variant: 'small' \| 'big'` | `CountdownEventFinished` + `CountdownEventFinishedVariant.small/.big` |
| `targetDate` | `countdownDate` (Timer.periodic 1s) |
| `days`/`hours`/`minutes`/`seconds` fijos | — (extensión web para diseño estático) |
| `finished` | estado interno `_isCountdownFinished` |
| `icon` | `icon` (`DotsIconData.weddingRings` por defecto) |
| Candado recap | `DotsIconData.lock` → `ic-lock` |
| Tarjeta | r24 + `blur20` + `toastShadow` + `bgContainerSecondaryOnBackground` (`textDisabled` si `isDotbook`) |
| Tipos | título `labelDefaultBold`, cifras `titleH4`, etiquetas `labelSmallMedium` (70 % en recap), descripción `labelDefaultRegular` 70 % |
