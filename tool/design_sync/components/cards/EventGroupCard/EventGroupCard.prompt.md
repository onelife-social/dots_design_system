EventGroupCard from dots_design_system. Use via `window.DotsDesignSystem_9e41da.EventGroupCard` (bundle loaded from the root `_ds_bundle.js`). Square group/event card with photo background in 3 variants (small 148px with bottom title, active/passed 288px with top title, secondary text or button, and a blurred bottom action menu), optional CardTag icon and blocked state.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `variant` | `'small' \| 'active' \| 'passed'` | `'small'` | Variante visual (enum Dart `EventGroupCardVariant`) |
| `imageSrc` | `string` | — | URL de la foto de fondo; sin ella se pinta placeholder degradado |
| `title` | `string` | `''` | small: abajo centrado (labelDefaultMedium) · active/passed: arriba (bodyLargeBold) |
| `secondaryText` | `string` | `''` | active: "· texto" bajo el título · passed: label del DotsMainButton secondary small |
| `tagIcon` | `string` | — | Icono del CardTag Ø28 arriba-izquierda, p.ej. `'ic-prime-1'` |
| `actions` | `{icon, text, onClick?}[]` | `[]` | Menú inferior con blur50 (solo active/passed); icono 20 + texto labelSmallRegular |
| `isBlocked` | `boolean` | `false` | Candado `ic-lock` 32 centrado; oculta el tag |
| `edgeSize` | `number` | `60 / 110` | Altura del difuminado inferior |
| `size` | `number` | `148 / 288` | Lado en px (1:1; Dart acota 135–160 small, 288–340 resto) |
| `onClick` | `() => void` | — | Tap en la tarjeta (Dart `onTap`) |
| `onSecondaryClick` | `() => void` | — | Tap en secundario (Dart `onSecondaryTap`) |

## Examples

```jsx
const { EventGroupCard } = window.DotsDesignSystem_9e41da;

// Carrusel del home: evento activo con menú de acciones
<EventGroupCard
  variant="active"
  title="Boda de Ana y Leo"
  secondaryText="34 participantes"
  imageSrc={photoUrl}
  actions={[
    { icon: 'ic-camera', text: 'Fotos', onClick: openPhotos },
    { icon: 'ic-user-add--outlined', text: 'Invitar', onClick: invite },
    { icon: 'ic-share', text: 'Compartir', onClick: share },
  ]}
  onClick={openEvent}
/>

// Miniatura small con tag premium
<EventGroupCard variant="small" title="Cumple de Marta" tagIcon="ic-prime-1" imageSrc={url} />

// Evento pasado (botón "Ver evento" con ic-exit-fullscreen)
<EventGroupCard variant="passed" title="Verano 2024" secondaryText="Ver evento" onSecondaryClick={open} />
```

## Dart mapping

- Widget: `EventGroupCard` (`lib/src/components/cards/group_cards/event_group_card.dart`).
- Props: `imageProvider`→`imageSrc`, `tagIconData`→`tagIcon` (nombre de asset), `onTap`→`onClick`, `onSecondaryTap`→`onSecondaryClick`, `actions: List<GroupEventCardModel>`→`actions[{icon,text,onClick}]`; resto 1:1 (`title`, `secondaryText`, `isBlocked`, `edgeSize`). `onError` (carga de imagen) no se porta.
- Enum: `EventGroupCardVariant` (small/active/passed) — mismos nombres.
- Aproximaciones: squircle32/52 → border-radius; SoftEdgeBlur → overlay con backdrop-blur + máscara; ShaderMask del CardTag → color sólido `#7188F5`. Menú vacío no se pinta (Dart deja la píldora vacía).
