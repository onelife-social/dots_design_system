DotsMenu from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsMenu` (bundle loaded from the root `_ds_bundle.js`). 250px contextual menu with a header item, dividers, selected/destructive states and nested navigation through subItems; `DotsMenu.SettingsList` renders the grouped settings rows (icon or toggle).

## Props

### DotsMenu

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `mainItem` | `ItemModel` | — | Required. Header row; tapping it navigates back when inside a submenu. |
| `subitems` | `ItemModel[]` | — | Required. First-level rows. |
| `defaultSelectedItemId` | `string \| number` | — | Opens the menu already navigated to the level containing this id. |

`ItemModel`: `{ id, label, details?, icon?: string (trailing 16px), selected?: boolean (check 14px labelHighlight), isDelete?: boolean (labelDestructive), subItems?: ItemModel[], addDivider?: boolean, onClick? }`. Tapping an item with `subItems` navigates into it (chevron-right marks those rows); more than 7 subitems scroll at 336px max height.

### DotsMenu.SettingsList

| Prop | Type | Default | Notes |
| --- | --- | --- | --- |
| `title` | `string` | — | Uppercased label above the group, textTertiary. |
| `description` | `string` | — | Helper text below the group. |
| `items` | `SettingsItem[]` | — | Required. `{ variant: 'icon' \| 'toggle', label, startIcon?, endIcon?, toggleValue?, onToggleTap?, onClick?, textColor?, textAlignment? }`. |
| `textPadding` | `number` | `15` | Horizontal padding of title/description. |

## Examples

```jsx
const { DotsMenu } = window.DotsDesignSystem_9e41da;

<DotsMenu
  mainItem={{ id: 'root', label: 'Opciones del dot' }}
  subitems={[
    { id: 'all', label: 'Todos los recuerdos', selected: true },
    { id: 'edit', label: 'Editar título', details: 'Cambia el nombre visible', icon: 'ic-edit' },
    { id: 'sort', label: 'Ordenar por', addDivider: true,
      subItems: [{ id: 'date', label: 'Fecha' }, { id: 'name', label: 'Nombre' }] },
    { id: 'del', label: 'Eliminar dot', isDelete: true, icon: 'ic-trash' },
  ]}
/>

<DotsMenu.SettingsList
  title="Notificaciones"
  description="Puedes cambiar esto más tarde en Ajustes."
  items={[
    { variant: 'icon', label: 'Recordatorios diarios', startIcon: 'ic-bell', endIcon: 'ic-chevron-right' },
    { variant: 'toggle', label: 'Actividad de amigos', startIcon: 'ic-user', toggleValue: true },
  ]}
/>
```

## Dart mapping

- Widgets: `DotsMenu` + `DotsMenuItemModel` (`lib/src/components/menu/dots_menu.dart`, `dots_menu_item_model.dart`); `SettingsList`/`SettingsItem` (`settings_list.dart`, `settings_item.dart`, enum `SettingsItemVariant`).
- `onTap` → `onClick`; `icon: DotsIconData` → asset name; el AnimatedSwitcher de 700ms de la navegación anidada se omite (cambio instantáneo).
- Toggle embebido (DotsToggle 44.42×27): off usa fillSecondary sin token (`#78788029` / dark `#78788052`), documentado en el CSS.
