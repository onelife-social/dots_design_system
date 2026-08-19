DotsToast from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsToast` (bundle loaded from the root `_ds_bundle.js`). Floating blurred toast with a per-variant icon (`success`, `error`, `info`, `progress`, `connectionResumed`, `connectionLost`, `widget`); renders as a 358px row by default or a 160px centered column with `isAction: true`.

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `title` | `string` | — | Toast text, bodyDefaultMedium (14/500) textPrimary. |
| `variant` | `'success' \| 'error' \| 'info' \| 'progress' \| 'connectionResumed' \| 'connectionLost' \| 'widget'` | `'info'` | Dart enum `DotsToastVariant`. Picks icon + tint. |
| `isAction` | `boolean` | `false` | `false` → info layout (row, 358px). `true` → action layout (column, 160px). |
| `customIcon` | `string` | — | DotsIcon name overriding the variant icon. |
| `customIconColor` | `string` | — | CSS color overriding the variant tint. |
| `btnTitle` | `string` | — | Ghost DotsMainButton (medium) on the right — only rendered for `variant: 'progress'` with `isAction: false`. |
| `customWidget` | `ReactNode` | — | Replaces the icon — only for `variant: 'widget'` with `isAction: true`. |
| `onClick` | `() => void` | — | Fired on toast tap (and on the ghost button). |

Variant → icon/tint: `success` `ic-check-circle` labelHighlight · `error` `ic-cross-circle` (action: `ic-trash`) labelDestructive · `info` `ic-alert-circle` textTertiary · `progress` `ic-slot` spinning untinted · `connectionResumed` `ic-connection-on` labelHighlight · `connectionLost` `ic-connection-off` labelDestructive.

## Examples

```jsx
const { DotsToast, DotsIcon } = window.DotsDesignSystem_9e41da;

// Info toast (358px row)
<DotsToast title="Recuerdo guardado" variant="success" />

// Upload progress with cancel button
<DotsToast title="Subiendo 12 fotos…" variant="progress" btnTitle="Cancelar" onClick={cancelUpload} />

// Action toast (160px column)
<DotsToast title="Copiado" variant="success" isAction />

// Custom widget action toast
<DotsToast title="Listo" variant="widget" isAction customWidget={<DotsIcon name="ic-check" size={24} />} />
```

## Dart mapping

- Widget: `DotsToast` (`lib/src/components/toast/dots_toast.dart`); enum `DotsToastVariant` (`dots_toast_variant_enum.dart`).
- The Dart wrappers `DotsToastInfo` (`isAction: false`) and `DotsToastAction` (`isAction: true`) are unified here: use the `isAction` prop.
- `onTap` → `onClick`; `customIconData` → `customIcon` (icon name string); `customIconColor`, `btnTitle`, `customWidget`, `title`, `variant` keep their names.
- Container: bgContainerPrimary, squircle24, border 1.4 borderAlert, padding 16, toastShadow; `bgToast` color-dodge approximated with backdrop blur 50.
- Progress icon = `DotsIconData.progressSpinner` (`ic-slot.svg`), rotated 1s/turn like `_RotatingIcon`.
