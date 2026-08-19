DotsTextField from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsTextField` (bundle loaded from the root `_ds_bundle.js`). 44px pill text input with optional icon, clear-on-focus button, error state, and a background-less underline mode; controlled (`value`) or uncontrolled (`defaultValue`).

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `value` | `string` | — | Controlled value. If set, pair with `onChanged`. |
| `defaultValue` | `string` | `''` | Initial value in uncontrolled mode. |
| `icon` | `string` | — | Dots icon asset name, e.g. `'ic-search'`. Rendered at 20px, textTertiary. |
| `leading` | `ReactNode` | — | Optional leading node (e.g. country selector). |
| `hintText` | `string` | — | Placeholder, textQuarternary. |
| `addHintTextColorError` | `boolean` | `false` | Hint turns labelDestructive when `isError` and not focused. |
| `onChanged` | `(text) => void` | — | Fires on every keystroke and on clear. |
| `onSubmitted` | `(text) => void` | — | Fires on Enter. |
| `onFocusLost` | `(text) => void` | — | Fires on blur. |
| `maxTextLength` | `number` | — | Max input length. |
| `isError` | `boolean` | `false` | Error state. |
| `errorText` | `string` | — | Red helper line below the field (only when `background`). |
| `enabled` | `boolean` | `true` | Disabled fields show textDisabled and never show the clear button. |
| `background` | `boolean` | `true` | Pill background bgContainerSecondaryOnBackground. When `false`, input text turns red on error. |
| `showUnderline` | `boolean` | `false` | 0.5px bottom border, only when `background` is `false`. |
| `alignCenter` | `boolean` | `false` | Centers input text and error text. |
| `keyboardType` | `'text' \| 'number' \| 'phone' \| 'emailAddress' \| 'url'` | `'text'` | Maps to input type/inputMode. |
| `textCapitalization` | `'none' \| 'words' \| 'sentences' \| 'characters'` | `'none'` | Maps to `autocapitalize`. |
| `autoFocus` | `boolean` | `false` | Focus on mount. |

The clear button (DotsCloseButton extraSmall, `inverted` with background / `softContrast` without) appears automatically when the field is enabled, focused and non-empty.

## Examples

```jsx
const { DotsTextField } = window.DotsDesignSystem_9e41da;

// Search field (uncontrolled)
<DotsTextField icon="ic-search" hintText="Buscar recuerdo" onChanged={setQuery} />

// Controlled with validation error
<DotsTextField
  value={name}
  onChanged={setName}
  isError={name.length < 3}
  errorText="Introduce al menos 3 caracteres"
/>

// Background-less with underline (settings row style)
<DotsTextField background={false} showUnderline hintText="Añade un título" />
```

## Dart mapping

- Widget: `DotsTextField` (`lib/src/components/text_fields/dots_textfield.dart`).
- `TextEditingController` → `value`/`defaultValue` + `onChanged`; `FocusNode` → internal focus state + `autoFocus`.
- `iconData: DotsIconData` → `icon` (real asset name); `onTap` clear → built-in clear button (DotsCloseButton extraSmall inverted/softContrast).
- `keyboardType: TextInputType` → `keyboardType` string; `textCapitalization` → `autocapitalize`; `inputFormatters` has no web equivalent (omitted).
