DotsTextFieldDate from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsTextFieldDate` (bundle loaded from the root `_ds_bundle.js`). 44px pill read-only date field: optional icon + label on the left, `date` (and optional `time`) rendered as rounded chips on the right; the whole field is clickable (opens a picker) and supports error state and a background-less mode.

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `icon` | `string` | — | Dots icon asset name, e.g. `'ic-calendar'`. 20px, textSecondary. |
| `label` | `string` | — | Left text (bodyDefaultRegular, textPrimary). |
| `date` | `string` | required | First chip (bgSecondaryBtn, r24, min-width 56, bodyDefaultMedium). |
| `time` | `string` | — | Second chip, 4px after the date chip. |
| `onClick` | `() => void` | required | Fired on click/Enter/Space — open your date/time picker here. |
| `isError` | `boolean` | `false` | Chip text turns labelDestructive. |
| `errorText` | `string` | — | Red helper line below (only shown when `background` is true). |
| `background` | `boolean` | `true` | Pill background bgContainerSecondaryOnBackground. |

Not an editable input — values are display strings; format them yourself (e.g. `'12 mar'`, `'18:30'`).

## Examples

```jsx
const { DotsTextFieldDate } = window.DotsDesignSystem_9e41da;

// Date + time row that opens a picker
<DotsTextFieldDate icon="ic-calendar" label="Fecha" date="12 mar" time="18:30"
  onClick={openDatePicker} />

// Invalid date
<DotsTextFieldDate label="Fecha" date="31 feb" isError
  errorText="La fecha no es válida" onClick={openDatePicker} />

// Inside a container that already has a background
<DotsTextFieldDate icon="ic-calendar" label="Fecha" date="12 mar" background={false}
  onClick={openDatePicker} />
```

## Dart mapping

- Widget: `DotsTextFieldDate` (`lib/src/components/text_fields/dots_textfield_date.dart`).
- `onTap` → `onClick`; `iconData: DotsIconData` → `icon` (real asset name).
- Chips = Dart `buildTextWidget` (bgSecondaryBtn, `DotsBorderRadius.r24`, padding 10×4, minWidth 56).
- `errorText` only renders when `background && isError`, same as Dart.
