DotsIconButton from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsIconButton` (bundle loaded from the root `_ds_bundle.js`). Circular icon button with styles defaultStyle/onPhoto/floating/noBackground × states defaultState/active/disabled/destructive, sizes enormous–extraSmall, optional label (column/row) and notification tag badge. Without `onClick` the circle is display-only (a `<span aria-hidden>`): the clickable parent owns the tap, as with the pencil over a cover that is itself the button. Make that parent a `<button>` so it keeps a keyboard path. Figma's btnIcon Floating (the "surface" button over a photo, e.g. Weddings P6 «Editar») is `variant="floating"`; at 44 px, `size="large"`. In a design, pick the look with `variant`: the canvas runtime takes an x-import's `style` attribute as the CSS of its box, so `style="floating"` never reaches the component there. The app accepts both.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `icon` | `string` (requerido) | — | Nombre real del asset de DotsIcon, p.ej. `'ic-heart'`, `'ic-add'` |
| `iconSize` | `number` | iconSize del `size` | Tamaño del icono en px |
| `label` | `string` | — | Label opcional (labelDefaultRegular 13/400, máx. 2 líneas) |
| `tag` | `string` | — | Badge de notificación rojo (BadgeTag) arriba-derecha |
| `size` | `'enormous' \| 'extraLarge' \| 'large' \| 'medium' \| 'small' \| 'extraSmall'` | `'large'` | Diámetro 56/52/44/36/28/22, icono 32/32/24/20/14/14 |
| `style` | `'defaultStyle' \| 'onPhoto' \| 'floating' \| 'noBackground'` | `'defaultStyle'` | Estilo visual. En el lienzo no llega: usa `variant` |
| `state` | `'defaultState' \| 'active' \| 'disabled' \| 'destructive'` | `'defaultState'` | Estado |
| `variant` | `'solid' \| 'photo' \| 'active' \| 'noBackground' \| 'photoDisable' \| 'floating'` | `'solid'` | El look por nombre, el que llega al lienzo. `floating` = `style="floating"`. Solo aplica si style/state son los defaults |
| `direction` | `'column' \| 'row'` | `'column'` | Posición del label |
| `onClick` | `() => void` | — | `onTap` de Dart. Sin él, el círculo es solo visual: no es un control ni recibe foco. |
| `color` | `string` | color del tema | Fuerza color de icono y label |
| `backgroundColor` | `string` | fondo del tema | Fuerza fondo del círculo |
| `textTappable` | `boolean` | `false` | El label también dispara onClick |
| `shouldApplyBlur` | `boolean` | `true` | Backdrop blur (50 default/onPhoto, 10 floating) |
| `showShadow` | `boolean` | `false` | Sombra shadowFolder + 4px extra de gap con label |
| `overflow` | `'ellipsis'` | — | 1 línea con elipsis (sin definir: 2 líneas) |

## Examples

```jsx
const { DotsIconButton } = window.DotsDesignSystem_9e41da;

// Botón de acción estándar 44px
<DotsIconButton icon="ic-add" onClick={onAdd} />

// Sobre foto, con badge
<DotsIconButton icon="ic-user" style="onPhoto" tag="3" onClick={openProfile} />

// Con label debajo (column) y estado activo
<DotsIconButton icon="ic-heart" label="Favoritos" state="active" textTappable onClick={toggleFavorite} />

// Lápiz sobre una portada que ya es el botón: solo visual (sin onClick); el padre es un <button>
<button type="button" aria-label="Cambiar la portada" onClick={changeCover}
  style={{ position: 'relative', display: 'block', padding: 0, border: 0, background: 'none' }}>
  <img src={cover} alt="" />
  <span style={{ position: 'absolute', right: 11, bottom: 11, display: 'flex' }}>
    <DotsIconButton icon="ic-pencil" size="large" variant="floating" iconSize={20} />
  </span>
</button>
```

## Dart mapping

- Widget: `DotsIconButton` (`lib/src/components/buttons/dots_icon_button/dots_icon_button.dart`)
- Enums: `DotsIconButtonSize`, `DotsIconButtonStyle`, `DotsIconButtonState`, `DotsIconButtonDirection`, `DotsIconButtonVariant` (deprecado en Dart; `floating` está para que el lienzo pueda elegirlo)
- Tema: `getIconButtonThemeByStyleAndState` (`dots_icon_button_theme.dart`)
- Mapeo de props: `onTap` → `onClick`; `icon: DotsIconData` → `icon: string` (nombre del asset svg)
- El modo solo visual (sin `onClick`, `<span aria-hidden>`) es una extensión web
- Sin token: borderAlert (#FFFFFF4D/#6E6E6E4D) y shadowFolder (#00000014), hardcodeados con comentario en el CSS
