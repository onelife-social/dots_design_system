DotsCalendar from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsCalendar` (bundle loaded from the root `_ds_bundle.js`). Inline month calendar: header "Month year ⌄" that opens a month/year picker (two snap columns), prev/next arrows, today with a ring, selected day as a filled circle, past days greyed but selectable by default, days of other months muted. Web-only component (the Flutter app uses cupertino_calendar_picker themed the same way).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `value` | `string` (ISO `yyyy-mm-dd`) | `''` | Día seleccionado (controlado). Vacío = nada seleccionado. |
| `onChange` | `(iso: string) => void` | — | Día tocado. |
| `initialMonth` | `string` (`yyyy-mm`) | mes de `value` o de hoy | Mes mostrado al montar. |
| `today` | `string` (ISO) | fecha del dispositivo | Día con anillo; útil en previews. |
| `locale` | `string` | `navigator.language` | Nombres de mes y día. |
| `firstDayOfWeek` | `0 \| 1` | `1` | 1 = lunes, 0 = domingo. |
| `pastDays` | `'normal' \| 'muted' \| 'disabled'` | `'muted'` | Días anteriores a hoy: en gris pero seleccionables, bloqueados, o normales. |
| `minDate` / `maxDate` | `string` (ISO) | — | Rango seleccionable (inclusive). |
| `yearRange` | `[number, number]` | hoy −5 … +10 | Años del selector. |
| `initialPicking` | `boolean` | `false` | Arranca con el selector de mes y año abierto (previews). |
| `className` | `string` | — | Clases extra sobre `.ds-calendar`. |

Para vaciar la selección, hazlo fuera (una fila con el valor y una equis): el calendario no tiene acción de borrar.

## Examples

```jsx
const { DotsCalendar } = window.DotsDesignSystem_9e41da;
<DotsCalendar value="2026-09-26" onChange={(iso) => setDate(iso)} locale="es" />
<DotsCalendar value="" pastDays="disabled" maxDate="2027-12-31" />
```
