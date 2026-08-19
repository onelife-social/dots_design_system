DropdownMenu from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DropdownMenu` (bundle loaded from the root `_ds_bundle.js`). Dropdown button (small/medium, default/onBackground, active state) with its 250px rounded menu of items; without `label` it renders just the menu panel.

## Props

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `items` | `Item[]` | — | Required. See item shape below. |
| `label` | `string` | — | Button text. Omit to render only the menu panel. |
| `subtitle` | `string` | — | Inline after label, textTertiary (white in onBackground). |
| `size` | `'small' \| 'medium'` | `'small'` | small: 8/12 padding; medium: 12/16. r22 pill. |
| `variant` | `'default' \| 'onBackground'` | `'default'` | default: bgContainerSecondaryOnBackground; onBackground: dark chip + white text. |
| `isActive` | `boolean` | — | Controlled open state (active bg + chevron up + menu below). |
| `defaultActive` | `boolean` | `false` | Uncontrolled initial open state; button tap toggles. |
| `minSize` | `boolean` | `true` | `false` makes the button full-width. |
| `width` | `number` | `250` | Panel width (menu-only mode). |
| `maxHeight` / `menuMaxHeight` | `number` | — | Scrolls the panel beyond this height. |
| `menuMaxWidth` | `number` | `250` | Width of the dropped menu. |
| `onToggle` | `(active) => void` | — | After a button tap, with the next state. |
| `onClick` | `() => void` | — | Dart `DropdownList.onTap`. |

Item: `{ text, subtitle?, leading?: node, icon?: string (trailing 16px), itemColor?: cssColor, destructive?: boolean, minSize?: boolean, onClick? }`. Pressed state (bgContainerSecondary) is applied on `:active`. Also exposed as `DropdownMenu.Item`.

## Examples

```jsx
const { DropdownMenu } = window.DotsDesignSystem_9e41da;
const items = [
  { text: 'Editar recuerdo', icon: 'ic-edit', onClick: edit },
  { text: 'Compartir', subtitle: 'con familia', icon: 'ic-share', onClick: share },
  { text: 'Eliminar', icon: 'ic-trash', destructive: true, onClick: remove },
];

// Filter button with its menu (uncontrolled)
<DropdownMenu label="Mes" subtitle="marzo" items={items} />

// Open menu on a photo header (dark chip button)
<DropdownMenu label="Filtrar" variant="onBackground" isActive items={items} />

// Just the panel, positioned by the design
<DropdownMenu items={items} />
```

## Dart mapping

- Widgets: `DropdownList`, `DropdownMenu`, `DropdownItem` (`lib/src/components/dropdowns/`); enums `DropdownListVariant` (`defaultVariant`→`'default'`, `onBackgroundVariant`→`'onBackground'`) y `DropdownListSize`.
- `onTap` → `onClick`; `itemColor: Color` → CSS color string (or `destructive`); trailing `icon: DotsIconData` → asset name.
- Colores sin token: bgFloatingActive `#00000026`/dark `#C8C8C81A` (botón activo), bgChip `#30303099` (onBackground) — hardcodeados en el CSS con comentario.
- El overlay/posicionado global de Flutter se sustituye por un menú `position:absolute` bajo el botón.
