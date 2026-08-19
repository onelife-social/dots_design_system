DotsTextFieldPhone from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsTextFieldPhone` (bundle loaded from the root `_ds_bundle.js`). Phone number field: a DotsTextField (44px pill) with a leading country selector — flag + `(dialCode)` + chevron-down + vertical divider — tel keyboard, error/disabled/background-less states; controlled (`value`) or uncontrolled (`defaultValue`).

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `countryCode` | `{ dialCode, flagEmoji }` | required | E.g. `{ dialCode: '+34', flagEmoji: '🇪🇸' }`. |
| `onCountryTap` | `() => void` | required | Click on the country selector — open your country picker. |
| `value` / `defaultValue` | `string` | — | Controlled / uncontrolled value. |
| `hintText` | `string` | — | Placeholder, textQuarternary. |
| `addHintTextColorError` | `boolean` | `false` | Hint turns labelDestructive when `isError` and not focused. |
| `onChanged` / `onSubmitted` / `onFocusLost` | `(text) => void` | — | Keystroke / Enter / blur. |
| `maxTextLength` | `number` | — | Max input length. |
| `isError` | `boolean` | `false` | Error state. |
| `errorText` | `string` | — | Red helper line below (only when `background`). |
| `enabled` | `boolean` | `true` | Disables input and country selector. |
| `background` | `boolean` | `true` | Pill background; `false` + `showUnderline` gives the underline style. |
| `showUnderline` | `boolean` | `false` | 0.5px bottom border when `background` is `false`. |
| `autoFocus` | `boolean` | `false` | Focus on mount. |

Uses `keyboardType: 'phone'` (`type=tel`, numeric keypad on mobile). Flutter's `digitsOnly` formatter has no automatic web equivalent — enforce digits in `onChanged` if needed (controlled mode).

## Examples

```jsx
const { DotsTextFieldPhone } = window.DotsDesignSystem_9e41da;

// Signup phone input
<DotsTextFieldPhone
  countryCode={{ dialCode: '+34', flagEmoji: '🇪🇸' }}
  onCountryTap={openCountryPicker}
  hintText="Número de teléfono"
  onChanged={setPhone}
/>

// Controlled, digits only, with validation
<DotsTextFieldPhone
  countryCode={country}
  onCountryTap={openCountryPicker}
  value={phone}
  onChanged={(t) => setPhone(t.replace(/\D/g, ''))}
  isError={phone.length < 9}
  errorText="El número no es válido"
/>
```

## Dart mapping

- Widget: `DotsTextFieldPhone` (`lib/src/components/text_fields/dots_textfield_phone.dart`); delegates to `DotsTextField` with `leading`, exactly like Dart.
- `PhoneCountryCode` → `countryCode` object; `onCountryTap` unchanged.
- Leading: flag (Dart hardcodes `Colors.black`), ` (dialCode)` in textSecondary, `DotsIconData.chevronDown` → `ic-chevron-down` at 14px, 0.5px divider (labelSecondary at 0.3 opacity).
- `keyboardType: TextInputType.phone` + `FilteringTextInputFormatter.digitsOnly` → `type=tel`/`inputMode=tel` (filter not enforced on web); `textStyle` override not ported.
