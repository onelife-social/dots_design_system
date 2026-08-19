DotsActionSheet from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsActionSheet` (bundle loaded from the root `_ds_bundle.js`). Bottom sheet (bgBaseContrast, radius 32, grabber) with variants `standard | list | input | radioButtons | settings | search | spotlight`; rendered as a static mountable sheet (position relative, no scrim) — place it anywhere and size it with its container (typical width 320–360px).

## Props

Common:

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `variant` | `'standard' \| 'list' \| 'input' \| 'radioButtons' \| 'settings' \| 'search' \| 'spotlight'` | `'standard'` | Maps 1:1 to the Dart classes (see Dart mapping). |
| `showGrabber` | `boolean` | `true` (search: `false`) | 36×4 grabber at the top. |
| `showCloseButton` | `boolean` | `false` | DotsCloseButton medium softContrast, top-right. |
| `onClose` | `() => void` | — | Close button tap. |
| `title` / `description` | `string` | — | Serif title (20px standard/radioButtons, 18px rest; settings uses Inter 20/700) + secondary line. |
| `primaryLabel` / `onPrimaryTap` / `primaryEnabled` | | — | Main button (DotsMainButton main mainAction; search: large/44px). |
| `secondaryLabel` / `onSecondaryTap` | | — | Secondary button. |
| `primaryButton` / `secondaryButton` | `ReactNode` | — | Custom nodes instead of the labels. |
| `buttonPositioning` | `'row' \| 'column'` | `'row'` | Row: secondary left, primary right, gap 15. |
| `children` | `ReactNode` | — | standard: free body block; list/search: replaces `items`. |

Per variant:

- **standard** — `topContent` (node above the title), `bottomContent` (full-width node), `stepProgress` (0..1 progress bar), `bigAspectRatio` (spacings 20/16).
- **list** — `listVariant` (`'main'`/`'ghost'`), `showBackButton`/`onBack`, `labelButtonText`/`onLabelButtonTap`/`labelButtonEnabled` (small button top-right), `searchHint`/`searchValue`/`onSearchChanged`/`searchIcon`, `selectedItems: [{id,name}]` + `onChipTap` (filter chips), `listTitle`, `items: ListItem[]`, `mainButtonIcon` (ghost footer icon, default `'ic-add'`).
- **input** — `inputVariant` (`'main'`/`'colors'`), `icon`/`iconNode`/`iconColor` (52px circle), `inputHint`/`inputValue`/`onInputChanged`/`maxTextLength` (centered pill field), `colors: string[]` + `selectedColorIndex` + `onColorSelect` (32px swatches, gap 18).
- **radioButtons** — `options: [{ id, title, titleIcon?, details?: [{icon?, label}], control?: 'radio'|'toggle', selected? }]`, `onSelect(id)`. Selected radio cards get a 1.5px labelHighlight border.
- **settings** — `image` (URL → 100px circular avatar), `buttons: [{ icon?, label, destructive?, disabled?, onTap? }]` (DotsSystemButton rows, 44px r16).
- **search** — `searchHint`/`onSearchChanged`, `items` or `children` as content, `primaryLabel` floats on a bottom fade.
- **spotlight** — `image` (URL → full-width 120px r24), `label` (13px textTertiary under the title).

`DotsActionSheet.ListItem` — `{ icon?: string, iconNode?, label, showLockIcon?, onClick? }`: 40×40 r12 icon box + bodyLargeBold text, used by list/search or standalone.

## Examples

```jsx
const { DotsActionSheet } = window.DotsDesignSystem_9e41da;

// Confirmation sheet
<DotsActionSheet
  title="Comparte este recuerdo"
  description="Invita a tu familia para que también pueda verlo."
  secondaryLabel="Ahora no" primaryLabel="Compartir"
  onPrimaryTap={share}
/>

// Picker list with search + chips
<DotsActionSheet
  variant="list" title="Añadir a un grupo" showCloseButton onClose={close}
  searchHint="Buscar grupo"
  selectedItems={[{ id: 1, name: 'Familia' }]} onChipTap={removeChip}
  listTitle="Tus grupos"
  items={[
    { icon: 'ic-family', label: 'Familia Lerma', onClick: pick },
    { icon: 'ic-pic', label: 'Viajes', showLockIcon: true },
  ]}
  primaryLabel="Añadir grupo" onPrimaryTap={confirm}
/>

// Options with radio cards and a toggle
<DotsActionSheet
  variant="radioButtons" title="Tipo de DotBook" description="Elige el acabado"
  options={[
    { id: 'hard', title: 'Tapa dura', titleIcon: 'ic-book-2', selected: true,
      details: [{ icon: 'ic-download', label: 'Impresión premium' }, { label: 'Desde 39,99 €' }] },
    { id: 'express', title: 'Envío exprés', control: 'toggle', selected: true,
      details: [{ label: 'Llega en 48 h' }] },
  ]}
  onSelect={setOption} primaryLabel="Continuar"
/>
```

## Dart mapping

- `variant` → clases Dart: `standard`→`DotsActionSheetStandard`, `list`→`DotsActionSheetList` (+`ActionSheetListVariant` main/ghost), `input`→`DotsActionSheetInput` (+`ActionSheetInputVariant`; cubiertas main y colors — text/date/user pendientes), `radioButtons`→`DotsActionSheetRadioButtons` (items `RadioCardIcons`), `settings`→`DotsActionSheetSettings` (botones `DotsSystemButton`), `search`→`DotsActionSheetSearch`, `spotlight`→`DotsActionSheetSpotlight`.
- Props Dart → web: `topWidget`→`topContent`, `bottomWidget`→`bottomContent`, `onTap*`→`on*Tap`/`onClick`, `hintInputText`/`hintText`→`searchHint`/`inputHint`, `selectedItemNames`→`selectedItems`, `onBtnChipTap`→`onChipTap`, `isMainButtonAvailable`/`enableMainButton`→`primaryEnabled`, `mainButtonText`→`primaryLabel`.
- `DotsActionSheet.ListItem` = `DotsListItem` (`dots_list_item.dart`); grabber = `Grabber` (`grabber.dart`); contenedor = `DotsActionSheetContainer` (sin scrim ni `bottomPosition`: la hoja es estática).
- Omitido: scrim negro 40% + blur, animaciones, scroll interno con fades dinámicos, `DotsEmptyStateCard` de lista vacía, variantes de input text/date/user y spotlight alert/user (cubierta la de imagen/album).
