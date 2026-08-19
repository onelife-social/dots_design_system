UsersList from dots_design_system. Use via `window.DotsDesignSystem_9e41da.UsersList` (bundle loaded from the root `_ds_bundle.js`). Members list container (r26, secondary-on-bg background, thin dividers) that maps each member's `memberType` to a row variant, plus trailing add-participant / add-friend rows; `UsersList.Item` exposes the single row with variants `main · label · textfield · button · pending · join · waiting · basic · existingAlias · pendingMember`.

## Props

### UsersList

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `members` | `UsersListMember[]` | — (requerido) | `{id, name, details?, src?, alias?, memberType}`. El índice 0 se pinta siempre como creador. Vacío → null. |
| `creatorLabel` / `adminLabel` | `string` | — (requeridos) | Trailing label verde (labelActive). |
| `memberOnClick` | `(id) => void` | — | Tap de fila / botón de cierre (Dart `memberOnTap`). |
| `textfieldLabel` | `string` | `''` | Placeholder de los textfield de alias. |
| `textOnChange` | `(id, value) => void` | — | Cambios en textfields (Dart `textOnChanged`). |
| `addParticipantLabel` + `addParticipantOnClick` | — | — | Fila botón con `ic-add`. Ambos requeridos para mostrarse. |
| `showAddFriendButton` + `addFriendLabel` + `addFriendOnClick` | — | `false` | Fila botón con `ic-user`. |
| `canModifyMembers` | `boolean` | `false` | `member` → fila `join` (chevron 22) en vez de `basic`. |
| `autofocusOnEmpty` | `boolean` | `true` | Autofocus en textfield vacío. |

Mapeo `memberType` → variante: creator/admin → `label` · friend → `main` (con DotsCloseButton) · alias → `textfield` · member → `join`/`basic` · existingAlias → `existingAlias`.

### UsersList.Item

`variant` (requerido) + `id`, `name`, `details`, `src`, `alias`, `label`, `icon`, `textValue`, `textOnChange`, `iconSize`, `onClick`, y para `pendingMember`: `buttonLabel1`/`onButton1Click` (DotsMainButton small main) y `buttonLabel2`/`onButton2Click` (small secondary). `waiting`/`pendingMember` usan UserInfo large (avatar 40); el resto small (26). Trailing por variante: main/textfield → DotsCloseButton extraSmall · pending → `ic-clock-filled` 16 · join → `ic-chevron-right` 14 · label → texto labelActive.

## Examples

```jsx
const { UsersList } = window.DotsDesignSystem_9e41da;

<UsersList
  members={[
    { id: '1', name: 'Jose', memberType: 'creator' },
    { id: '2', name: 'María', memberType: 'admin' },
    { id: '3', name: 'Carlos', memberType: 'friend', src: 'https://…/c.jpg' },
    { id: '4', name: '', memberType: 'alias' },
  ]}
  creatorLabel="Creador" adminLabel="Admin"
  textfieldLabel="Nombre del participante"
  memberOnClick={(id) => removeMember(id)}
  textOnChange={(id, v) => renameAlias(id, v)}
  addParticipantLabel="Añadir participante" addParticipantOnClick={() => addAlias()}
/>

// Fila suelta de solicitud pendiente
<UsersList.Item variant="pendingMember" id="d1" name="Diego Martín" details="@diegom"
  buttonLabel1="Aceptar" buttonLabel2="Rechazar"
  onButton1Click={accept} onButton2Click={reject} />
```

## Dart mapping

| Web | Dart (`lib/src/components/users_list/`) |
| --- | --- |
| `UsersList` | `UsersList` (`users_list.dart`) — contenedor r26 `bgContainerSecondaryOnBackground`, divisores `labelSecondary` 0.2 |
| `UsersList.Item` | `UsersItemList` (`users_item_list.dart`), `variant` = enum `UserItemListVariant` (factories `.main/.label/.textfield/.button/.pending/.join/.waiting/.basic/.existingAlias/.pendingMember`) |
| member `{name, details, src, alias}` | `MemberInfo.userInfoData` (`UserInfoData`) · `memberType` = enum `MemberType` |
| `memberOnClick` / `textOnChange` | `memberOnTap` / `textOnChanged` |
| `addParticipantOnClick` / `addFriendOnClick` | `addParticipantOnTap` / `addFriendOnTap` (iconos `DotsIconData.add` / `DotsIconData.user`) |
| Omitido | animación BounceIn (`applyBounceIn`) y `TextEditingController`/`FocusNode` (web: input no controlado + `autofocusOnEmpty`) |
