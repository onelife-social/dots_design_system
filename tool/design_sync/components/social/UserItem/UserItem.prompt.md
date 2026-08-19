UserItem from dots_design_system. Use via `window.DotsDesignSystem_9e41da.UserItem` (bundle loaded from the root `_ds_bundle.js`). 170×45 user pill (squircle24, bgStrong, floating shadow) with avatar + name + blue addCircle icon; `UserItem.Info` is the reusable avatar+name+details piece (small avatar 26 / large avatar 40) used across the users lists.

## Props

### UserItem

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `name` | `string` | — (requerido) | Nombre del usuario. |
| `id` | `string` | — | Se pasa al `onClick` (Dart `onTap(id)`). |
| `details` / `src` / `alias` | `string` | — | Delegados a `UserItem.Info`. |
| `onClick` | `(id) => void` | — | Tap en la píldora. |

### UserItem.Info (Dart UserInfo + UserInfoData)

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `name` | `string` | — (requerido) | bodyDefaultMedium (small) / bodyLargeMedium (large), textPrimary. |
| `details` | `string` | — | labelSmallRegular / labelDefaultRegular, textQuarternary. |
| `src` | `string` | — | Avatar circular con la imagen. |
| `alias` | `string` | — | Sin `src`: círculo bgContainerSecondaryOnBackground con este texto (Nunito, textTertiary). |
| `size` | `'small' \| 'large'` | `'small'` | Enum Dart UserInfoSize — avatar 26 / 40. |

Sin `src` ni `alias` se pinta placeholder degradado con las iniciales del nombre (extensión web del asset defaultUserItem).

## Examples

```jsx
const { UserItem } = window.DotsDesignSystem_9e41da;

// Píldora de añadir usuario
<UserItem id="u1" name="Nuria" src="https://…/nuria.jpg" onClick={(id) => addUser(id)} />

// Pieza Info suelta (p. ej. dentro de una lista)
<UserItem.Info name="Sara Ruiz" details="Invitación enviada" size="large" />

// Alias sin imagen
<UserItem.Info name="Pablo" alias="P" />
```

## Dart mapping

| Web | Dart (`lib/src/components/user_items/`) |
| --- | --- |
| `UserItem` | `UserItem` (`user_item.dart`) — squircle24 + `floatingBtnShadow` + `bgStrong` + `DotsIconData.addCircle` 20 |
| `UserItem.Info` | `UserInfo` (`user_info.dart`) |
| props planos `name`/`details`/`src`/`alias` | `UserInfoData` (`user_info_data.dart`): `name`/`details`/`imageProvider`/`aliasLabelImageText` |
| `size` | enum `UserInfoSize` (small 26 / large 40) |
| `onClick(id)` | `onTap(String? id)` |
