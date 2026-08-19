DotsTextArea from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsTextArea` (bundle loaded from the root `_ds_bundle.js`). Multiline auto-growing text area (radius 24, bg secondary-on-background) with optional label + icon, remaining-characters counter, min/max height and error state; controlled (`value`) or uncontrolled (`defaultValue`).

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `value` | `string` | — | Controlled value. Pair with `onChanged`. |
| `defaultValue` | `string` | `''` | Initial value in uncontrolled mode. |
| `label` | `string` | — | Bold label row above the text (bodyLargeMedium, textPrimary). |
| `icon` | `string` | — | Dots icon asset name, e.g. `'ic-pencil'`. 20px, textTertiary, indents the text 28px when there is a label. |
| `hintText` | `string` | — | Placeholder, textQuarternary. |
| `onChanged` | `(text) => void` | — | Fires on every keystroke. |
| `onSubmitted` | `(text) => void` | — | Fires on Ctrl/Cmd+Enter (plain Enter inserts a newline, like Flutter multiline). |
| `maxTextLength` | `number` | — | Max length; shows the remaining-characters counter bottom-right (labelSmallRegular, textQuarternary). |
| `textCapitalization` | `'none' \| 'words' \| 'sentences' \| 'characters'` | `'none'` | Maps to `autocapitalize`. |
| `minHeight` | `number` | `maxHeight ?? 50` | Min height (px) of the rounded box. |
| `maxHeight` | `number` | — | Max height (px); content scrolls inside. |
| `isError` | `boolean` | `false` | Error state. |
| `errorText` | `string` | — | Red helper line below the box (labelDefaultRegular, labelDestructive). |
| `autoFocus` | `boolean` | `false` | Focus on mount. |

The area auto-grows with its content (Flutter `minLines: 1, maxLines: null`). Clicking anywhere in the box focuses the textarea.

## Examples

```jsx
const { DotsTextArea } = window.DotsDesignSystem_9e41da;

// Memory description with counter
<DotsTextArea label="Descripción" icon="ic-pencil" maxTextLength={140}
  hintText="Escribe una nota…" onChanged={setDescription} />

// Bounded height with internal scroll
<DotsTextArea maxHeight={96} defaultValue={longText} />

// Required field with error
<DotsTextArea hintText="Escribe una nota…" isError={!text}
  errorText="Este campo es obligatorio" value={text} onChanged={setText} />
```

## Dart mapping

- Widget: `DotsTextArea` (`lib/src/components/text_fields/dots_textarea.dart`).
- `TextEditingController`/`FocusNode` → `value`/`defaultValue` + `onChanged` / internal focus + `autoFocus`.
- `iconData: DotsIconData` → `icon` (real asset name); `maxTextLength` counter shows remaining chars, clamped ≥ 0.
- `minHeight`/`maxHeight` (int, px) mirror the Dart `BoxConstraints`; `keyboardType: multiline` → native `<textarea>`.
