DotsSelectorRadioButton from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsSelectorRadioButton` (bundle loaded from the root `_ds_bundle.js`). Selectable radio cards — DotsSelectorRadioButton (title + 2 icon detail rows), plus `DotsSelectorRadioButtonLabel` (BadgeLabel free/acquired/premium/premiumPlus + serif title) and `DotsSettingItemRadioBtn` (radio + leading/trailing labels), all exposed on the same namespace.

## Props

`DotsSelectorRadioButton`:

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `isSelected` | `boolean` | — | Selección controlada; el grupo lo gestiona el padre. |
| `title` | `string` | — | Título (bodyDefaultBold). |
| `icon1` / `icon2` | `string` | `'ic-clock-filled'` / `'ic-calendar'` | Iconos de las filas de detalle. |
| `icon1Size` / `icon2Size` | `number` | `16` | Tamaño de esos iconos. |
| `details1` / `details2` | `string` | — | Textos de detalle (labelDefaultRegular, textTertiary). |
| `onClick` | `() => void` | — | Dart `onTap`. |

`DotsSelectorRadioButtonLabel`: `isSelected`, `title` (serif title02H6), `tagText` (BadgeLabel), `details1`, `details2`, `isSelectable` (false oculta el radio y desactiva el click), `variant: 'free' | 'acquired' | 'premium' | 'premiumPlus'`, `onClick`.

`DotsSettingItemRadioBtn`: `isSelected`, `leadingLabel`, `trailingLabel?`, `onClick`.

## Examples

```jsx
const [plan, setPlan] = React.useState('a');
<DotsSelectorRadioButton isSelected={plan === 'a'} onClick={() => setPlan('a')}
  title="Álbum de verano" details1="Hace 2 semanas" details2="12 mar 2026" />

<DotsSelectorRadioButtonLabel isSelected isSelectable variant="premium" tagText="PREMIUM"
  title="Plan Premium" details1="Recuerdos ilimitados" details2="99€/año" onClick={pick} />

<DotsSettingItemRadioBtn isSelected leadingLabel="Calidad alta" trailingLabel="Recomendado" onClick={pick} />
```

## Dart mapping

- Widgets: `DotsSelectorRadioButton`, `DotsSelectorRadioButtonLabel`, `DotsSettingItemRadioBtn` (`lib/src/components/selectors/`); enum `SelectorRadioButtonLabelVariant` (`selector_radio_button_enums.dart`).
- Tarjeta: `bgContainerSecondary`, r24, padding 16, margin 1.5; seleccionada → borde 1.5 `labelHighlight` strokeAlignOutside con r26 (aquí `box-shadow` de 1.5px).
- `icon1`/`icon2` (DotsIconData) → nombres de DotsIcon (`ic-clock-filled`, `ic-calendar`); radio derecho = `DotsRadioButton` del bundle (24, en el setting item 22).
- Label: `getBadgeLabelVariant` → BadgeLabel `main`/`green`/`premium`/`premiumPlus`; título title02H6, details1 bodyDefaultMedium, details2 labelDefaultRegular.
- `onTap` → `onClick`. La selección es controlada (`isSelected`), igual que en Dart.
