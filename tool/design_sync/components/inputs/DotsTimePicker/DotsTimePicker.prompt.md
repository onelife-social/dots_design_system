DotsTimePicker from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsTimePicker` (bundle loaded from the root `_ds_bundle.js`). Inline 24 h time wheel: an hours column (00–23) and a minutes column (00–59) under a highlight band, both looping like the iOS wheel. The row under the band is the value; tapping a row or scrolling and letting go picks it. Web-only component (the Flutter app uses CupertinoDatePicker in time mode, styled the same way).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `value` | `string` (`HH:mm`) | `''` | Hora elegida (controlada). Vacía: la rueda enseña la hora del dispositivo sin avisar con `onChange`. |
| `onChange` | `(time: string) => void` | — | Nueva hora `HH:mm` al soltar una columna, tocar una fila o usar las flechas. |
| `minuteInterval` | `number` | `1` | Paso de los minutos (divisor de 60). |
| `hoursLabel` / `minutesLabel` | `string` | `'Hours'` / `'Minutes'` | Nombres accesibles de las columnas. |
| `className` | `string` | — | Clases extra sobre `.ds-time-picker`. |

La rueda no trae hoja ni botones. Para pedir una hora desde un campo (como la app con `CupertinoDatePickerPopupStyle`), ábrela dentro de un `DotsActionSheet` `standard` sobre un velo, sin botones: tocar el velo la cierra y la hora ya está puesta. El borrado de la hora va fuera.

## Examples

```jsx
const { DotsTimePicker, DotsActionSheet } = window.DotsDesignSystem_9e41da;
<DotsTimePicker value="18:30" onChange={(time) => setTime(time)} />
<DotsActionSheet title="Hora de la ceremonia">
  <DotsTimePicker value={time} onChange={setTime} hoursLabel="Horas" minutesLabel="Minutos" />
</DotsActionSheet>
```
