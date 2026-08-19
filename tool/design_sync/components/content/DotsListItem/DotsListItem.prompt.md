DotsListItem from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsListItem` (bundle loaded from the root `_ds_bundle.js`). List row with 40×40 thumbnail (album image, circular user avatar, or icon tile), ellipsized label and optional trailing control; variants `main`, `selector`, `icon`, `check`, `radioButton`, `divider`.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `variant` | `'main' \| 'selector' \| 'icon' \| 'check' \| 'radioButton' \| 'divider'` | `'main'` | Variante de la fila. `selector` muestra radio vacío, `radioButton` radio marcado, `check` pill azul con check, `divider` título de sección + línea. |
| `label` | `string` | — | Texto de la fila (bodyDefaultMedium, ellipsis) o título de la sección en `divider`. |
| `imageSrc` | `string` | — | URL/data URI de la miniatura. Ignorada en `variant='icon'`; sin ella se muestra el tile de icono. |
| `picType` | `'album' \| 'user'` | `'album'` | `album` → cuadrado radius 12; `user` → círculo con fondo `bgBaseContrast`. |
| `iconName` | `string` | `'ic-user'` | Icono del tile (asset real `ic-…`) cuando aplica la variante icon. |
| `onClick` | `() => void` | — | Pulsación de toda la fila. |
| `onError` | `(e) => void` | — | Error de carga de la imagen (picType `user`). |

## Examples

```jsx
// Fila de álbum
<DotsListItem label="Álbum de verano" imageSrc={photoUrl} />

// Selección con radio marcado
<DotsListItem variant="radioButton" label="Cumpleaños de Ana" imageSrc={photoUrl} onClick={select} />

// Tile de icono + separador de sección
<DotsListItem variant="icon" label="Invitar amigos" iconName="ic-user" />
<DotsListItem variant="divider" label="Compartidos contigo" />
```

## Dart mapping

- Widget: `DotsListsItem` (`lib/src/components/dots_list_items/dots_list_items.dart`) — nombre web sin la doble "s".
- Enums: `DotsListsItemVariant` (main/selector/icon/check/radioButton/divider), `DotsListsItemPicType` (album/user).
- `image` (ImageProvider) → `imageSrc`; `iconData` (DotsIconData) → `iconName`; `onTap` → `onClick`.
- Trailing: selector/radioButton → `DotsRadioButton(size: 22)` del bundle; check → `DotsSelector.check` small (pill 22, `labelHighlight`, `ic-check` 14 blanco).
- Divider: label `labelSmallMedium` `textSecondary` + línea 1px `labelSecondary` al 50%.
