DotsTextField from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsTextField` (bundle loaded from the root `_ds_bundle.js`). 44px pill text input (52px with `container="big"`, text from 14 to 20px with `textSize`) with optional icon, clear-on-focus button, error state, and a background-less underline mode; controlled (`value`) or uncontrolled (`defaultValue`).

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
| `container` | `'defaultContainer' \| 'big'` | `'defaultContainer'` | Height: 44px or 52px (Figma textField Container Default / Big). |
| `textSize` | `'bodyDefault' \| 'bodyLarge' \| 'titleH6' \| 'titleH5'` | `'bodyDefault'` | Input and placeholder type: bodyDefaultMedium 14/500, bodyLargeMedium 16/500, titleH6 18/600, titleH5 20/700. |
| `keyboardType` | `'text' \| 'number' \| 'phone' \| 'emailAddress' \| 'url'` | `'text'` | Maps to input type/inputMode. |
| `textCapitalization` | `'none' \| 'words' \| 'sentences' \| 'characters'` | `'none'` | Maps to `autocapitalize`. |
| `autoFocus` | `boolean` | `false` | Focus on mount. |
| `ariaLabel` | `string` | — | Accessible name of the input, read instead of the hint. Pass it translated. |
| `autoCorrect` | `boolean` | browser default | `false` turns keyboard autocorrection off (e.g. names). |
| `spellCheck` | `boolean` | browser default | `false` removes the red spell-check underline. |
| `autoComplete` | `string` | browser default | Autofill token, e.g. `'off'` or `'street-address'`. |
| `enterKeyHint` | `'enter' \| 'done' \| 'go' \| 'next' \| 'previous' \| 'search' \| 'send'` | — | Label of the keyboard's Enter key. |
| `clearAriaLabel` | `string` | — | Accessible name of the clear button. No English fallback: pass it translated. |

The clear button (DotsCloseButton extraSmall, `inverted` with background / `softContrast` without) appears automatically when the field is enabled, focused and non-empty. Its circle is 16px and it takes taps over 44 × 44px. With `alignCenter` the text keeps its place when it appears.

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

// 52px with 16px text (search a place): «Buscar» key, no autofill
<DotsTextField container="big" textSize="bodyLarge" icon="ic-search" hintText="Escribe un lugar" maxTextLength={60}
  ariaLabel="Lugar" enterKeyHint="search" autoComplete="off" clearAriaLabel="Borrar el texto" />

// 52px with a centred title (the couple's names): no autocorrect or spell-check underline
<DotsTextField container="big" textSize="titleH6" alignCenter hintText="Mark & Anna" maxTextLength={30}
  ariaLabel="Los novios" autoCorrect={false} spellCheck={false} clearAriaLabel="Borrar el texto" />
```

## Dart mapping

- Widget: `DotsTextField` (`lib/src/components/text_fields/dots_textfield.dart`).
- `TextEditingController` → `value`/`defaultValue` + `onChanged`; `FocusNode` → internal focus state + `autoFocus`.
- `iconData: DotsIconData` → `icon` (real asset name); `onTap` clear → built-in clear button (DotsCloseButton extraSmall inverted/softContrast).
- `semanticsLabel` → `ariaLabel`; `clearSemanticsLabel` → `clearAriaLabel`.
- `autocorrect` → `autoCorrect`; `enableSuggestions` → `spellCheck` (Flutter draws no spell-check underline by default); `autofillHints` → `autoComplete` (`null` = `'off'`); `textInputAction` → `enterKeyHint`.
- `keyboardType: TextInputType` → `keyboardType` string; `textCapitalization` → `autocapitalize`; `inputFormatters` has no web equivalent (omitted).
- `container: DotsTextFieldContainer` and `textSize: DotsTextFieldTextSize` → same names as strings; Dart `textStyle` (free style over `textSize`) is not ported.
