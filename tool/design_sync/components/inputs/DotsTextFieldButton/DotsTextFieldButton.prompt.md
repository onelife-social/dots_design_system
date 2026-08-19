DotsTextFieldButton from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsTextFieldButton` (bundle loaded from the root `_ds_bundle.js`). 44px pill text input with a clear button (DotsCloseButton) while focused and non-empty, optional 16px `suffixIcon`, optional trailing text button with divider (`endButtonText`), and error state with `* ` asterisk; controlled (`value`) or uncontrolled (`defaultValue`).

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `value` / `defaultValue` | `string` | — | Controlled / uncontrolled value. |
| `icon` | `string` | — | Leading Dots icon (20px, textTertiary; labelDestructive on error). |
| `iconButton` | `string` | `'ic-cross'` | Icon of the clear button. |
| `onButtonClick` | `() => void` | clears the field | Clear-button click override. |
| `buttonVariant` | `'softContrast' \| 'highContrast' \| 'onBackground' \| 'inverted'` | `'inverted'` | DotsCloseButton variant. |
| `buttonSize` | `'large' \| 'medium' \| 'small' \| 'extraSmall'` | `'extraSmall'` | DotsCloseButton size. |
| `hintText` | `string` | `''` | Placeholder (textTertiary; labelDestructive on error). |
| `maxTextLength` | `number` | — | Max input length. |
| `textCapitalization` | `'none' \| 'words' \| 'sentences' \| 'characters'` | `'none'` | Maps to `autocapitalize`. |
| `onChanged` / `onSubmitted` | `(text) => void` | — | Keystroke / Enter. |
| `isError` | `boolean` | `false` | Error state. |
| `errorText` | `string` | — | Red helper line below (padding 24, top gap 8). |
| `alignCenter` | `boolean` | `false` | Centers input text. |
| `background` | `boolean` | `true` | Pill background bgContainerSecondaryOnBackground. |
| `endButtonText` | `string` | — | Trailing text button, preceded by a 0.5px divider. |
| `endButtonTextColor` | `string` (CSS color) | labelHighlight | Trailing button color. |
| `onEndButtonClick` | `() => void` | — | Trailing button click. |
| `suffixIcon` | `string` | — | 16px icon after the text (e.g. `'ic-check'`); replaces the clear button. |
| `suffixIconColor` | `string` (CSS color) | labelHighlight | Suffix icon color. |
| `enabled` | `boolean` | `true` | Disabled state (textDisabled). |
| `applyErrorColor` | `boolean` | `true` | Input text turns labelDestructive on error. |
| `applyErrorAsterisk` | `boolean` | `true` | Prefixes errorText with `* `. |
| `autoFocus` | `boolean` | `false` | Focus on mount. |

## Examples

```jsx
const { DotsTextFieldButton } = window.DotsDesignSystem_9e41da;

// Email with a "verify" action
<DotsTextFieldButton icon="ic-send" value={email} onChanged={setEmail}
  endButtonText="Verificar" onEndButtonClick={verifyEmail} />

// Validated username
<DotsTextFieldButton value={user} onChanged={setUser}
  suffixIcon={isValid ? 'ic-check' : undefined}
  isError={!isValid} errorText="El nombre de usuario no es válido" />

// Simple clearable field
<DotsTextFieldButton hintText="Escribe un mensaje" onChanged={setMsg} />
```

## Dart mapping

- Widget: `DotsTextFieldButton` (`lib/src/components/text_fields/dots_textfield_button.dart`).
- `iconData` → `icon`; `iconDataButton` → `iconButton`; `onTapBtn` → `onButtonClick`; `onEndButtonTap` → `onEndButtonClick` (real asset names, e.g. `DotsIconData.cross` → `'ic-cross'`).
- Clear button = real `DotsCloseButton` port (`buttonVariant`/`buttonSize` mirror `DotsCloseButtonVariant`/`DotsCloseButtonSize`), shown while focused and non-empty; `suffixIcon` takes priority, same as Dart.
- `endButtonTextColor`/`suffixIconColor` (Dart `Color`) → CSS color strings.
