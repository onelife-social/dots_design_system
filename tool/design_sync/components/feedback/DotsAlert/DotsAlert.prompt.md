DotsAlert from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsAlert` (bundle loaded from the root `_ds_bundle.js`). 320px modal dialog card with a highlighted icon chip, title/message and per-variant actions: `noButtons`, `oneButton`, `twoHorizontalButtons(Destructive)`, `twoVerticalButtons(Destructive/NoActive)`, `input`, `selector`.

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `variant` | see below | `'noButtons'` | Dart enum `DotsAlertVariant`. |
| `icon` | `string` | — | DotsIcon name for the 48px highlight chip (bgHighlight + labelHighlight). |
| `iconImage` | `string` | — | Image URL replacing the chip (48×48 cover; falls back to the chip on error). |
| `title` | `string` | — | bodyLargeBold (16/700) textPrimary. |
| `message` | `string` | — | bodyDefaultRegular (14/400); hidden for `input`. |
| `mainButtonText` / `onMainButtonClick` | `string` / `() => void` | — | Main action. |
| `secondaryButtonText` / `onSecondaryButtonClick` | `string` / `() => void` | — | Secondary action. |
| `inputHint` / `onInputChanged` | `string` / `(v: string) => void` | — | Only `variant: 'input'` (44px pill search field). |
| `selectorItems` | `{ label, image?, onClick? }[]` | — | Only `variant: 'selector'` (40px thumb + label list). |
| `showCloseButton` | `boolean` | `false` | Top-right DotsCloseButton (medium, softContrast) firing `onClose`. |
| `onClose` | `() => void` | — | Close callback (X button, and tap outside with `showScrim`). |
| `showBlurBackground` | `boolean` | `true` | Backdrop blur 50 behind the card. |
| `showScrim` | `boolean` | `false` | Wraps the card in a fixed 50% black scrim, centered; outside tap closes unless `enableCloseOnTapOutside: false`. |
| `enableCloseOnTapOutside` | `boolean` | `true` | Only relevant with `showScrim`. |

Actions per variant: `oneButton` → main · `twoHorizontalButtons` → secondary + main row · `twoHorizontalButtonsDestructive` → secondary + destructive row · `twoVerticalButtons` → main over ghost · `twoVerticalButtonsDestructive` → destructive over ghost · `twoVerticalButtonsNoActive` → two secondary stacked · `input`/`selector` → secondary + main row.

## Examples

```jsx
const { DotsAlert } = window.DotsDesignSystem_9e41da;

// Confirmation
<DotsAlert variant="oneButton" icon="ic-check-circle" title="Copia creada"
  message="Tu recuerdo se guardó correctamente." mainButtonText="Entendido" onMainButtonClick={close} />

// Destructive, as a real modal with scrim
<DotsAlert variant="twoHorizontalButtonsDestructive" icon="ic-trash" showScrim
  title="¿Eliminar recuerdo?" message="Esta acción no se puede deshacer."
  mainButtonText="Eliminar" onMainButtonClick={remove}
  secondaryButtonText="Cancelar" onSecondaryButtonClick={close} onClose={close} />

// Selector
<DotsAlert variant="selector" icon="ic-alert-circle" title="Elige un álbum"
  message="El recuerdo se añadirá al álbum elegido."
  selectorItems={[{ label: 'Verano 2025', onClick: pick }]}
  mainButtonText="Añadir" secondaryButtonText="Cancelar" />
```

## Dart mapping

- Widget: `DotsAlert` (`lib/src/components/alerts/dots_alert.dart`); enum `DotsAlertVariant` (`dots_alert_enums.dart`).
- The Dart named factories (`DotsAlert.noButtons`, `.oneButton`, …, `.input`, `.selector`) map 1:1 to the `variant` prop.
- `iconData` → `icon` (icon name string); `iconImage` (ImageProvider) → `iconImage` (URL); `mainButtonOnTap` → `onMainButtonClick`; `secondaryButtonOnTap` → `onSecondaryButtonClick`; `selectorItemList` (`List<DotsListItemModel>`) → `selectorItems` (`onTap` → `onClick`).
- Deviation: in Dart the widget always paints a full-screen Stack with a 50% black scrim; the web port renders the bare card and offers the scrim via `showScrim` for composability.
- Buttons are real `DotsMainButton`s (large, adaptPaddingForText); the X is a real `DotsCloseButton`; the input is a real `DotsTextFieldButton`; the selector rows approximate `DotsListsItem.main` (not ported yet).
- Card: bgContainerSecondary, radius 32, border 1.4 borderAlert, padding 16; `bgAlert` color-dodge approximated with backdrop blur 50.
