DotsIcon from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsIcon` (bundle loaded from the root `_ds_bundle.js`). Renders any of the 228 real design-system SVG icons by name (monochrome icons inherit color via currentColor; multicolor/gradient icons keep their own colors).

## Props

| Prop | Type | Default | Description |
| --- | --- | --- | --- |
| `name` | `string` | — | Icon name = asset filename without `.svg` (e.g. `'ic-heart'`). Unknown names render a dashed placeholder (no error). Full catalog at runtime: `DotsIcon.names`. |
| `size` | `number` | `24` | Square side in px. |
| `color` | `string` | `'currentColor'` | Any CSS color for monochrome icons (multicolor icons ignore it). |
| `className` | `string` | — | Extra class on the wrapper span. |

## Examples

```jsx
const { DotsIcon } = window.DotsDesignSystem_9e41da;

// Default 24px, inherits text color
<DotsIcon name="ic-heart" />

// Sized and colored with a design token
<DotsIcon name="ic-trash" size={20} color="var(--label-destructive)" />

// Inside a button (icon inherits the button's color)
<button style={{ color: 'var(--label-highlight)' }}>
  <DotsIcon name="ic-add" size={16} /> Añadir
</button>
```

Multicolor icons (rendered as-is, `color` has no effect): `ic-loading`, `ic-slot`, `ic-dedicatory`, `ic-premium-circle`.

## Catalog (228 icons, grouped by source folder in assets/icons/)

### system (43)

`ic-alert-circle`, `ic-bell`, `ic-check`, `ic-check-circle`, `ic-check-circle-outline`, `ic-check-thick`, `ic-connection-off`, `ic-connection-on`, `ic-cross`, `ic-cross-circle`, `ic-dark-mode`, `ic-filter`, `ic-flag`, `ic-globe`, `ic-grid`, `ic-grid-outline`, `ic-hand`, `ic-hand-tap`, `ic-help-circle`, `ic-help-circle-outline`, `ic-home`, `ic-info`, `ic-info-circle`, `ic-lightbulb`, `ic-lightbulb-2`, `ic-lightbulb-on`, `ic-loading`, `ic-notification`, `ic-notification--outlined`, `ic-notification-off`, `ic-notification-on`, `ic-options`, `ic-pencil--line`, `ic-pencil-glitter`, `ic-radio--off`, `ic-radio--on`, `ic-search`, `ic-selector`, `ic-settings`, `ic-shield`, `ic-slot`, `ic-spinner`, `ic-web`

### arrow (22)

`ic-arrow-diagonal-up`, `ic-arrow-down`, `ic-arrow-left`, `ic-arrow-right`, `ic-arrow-right-filled`, `ic-arrow-right-v2`, `ic-arrow-up`, `ic-chevron-down`, `ic-chevron-left`, `ic-chevron-right`, `ic-chevron-up`, `ic-circle-path`, `ic-download`, `ic-download-circle`, `ic-download-circle-crossed`, `ic-exit-fullscreen`, `ic-fullscreen`, `ic-redo`, `ic-refresh`, `ic-sort`, `ic-upload`, `ic-upload-circle`

### home (1)

`ic-add-field`

### album (64)

`ic-art`, `ic-baby-stroller`, `ic-balloons`, `ic-bird`, `ic-book-2`, `ic-bookClosed`, `ic-business`, `ic-calendar`, `ic-calendar--check`, `ic-calendar--partial`, `ic-camera--gallery`, `ic-car`, `ic-cat`, `ic-child`, `ic-christmas-tree`, `ic-clock--alert`, `ic-clock--notification`, `ic-clock--timer`, `ic-clock-filled`, `ic-clock-outline`, `ic-couple`, `ic-dog`, `ic-earth`, `ic-family`, `ic-fire`, `ic-fish`, `ic-fitness`, `ic-flower`, `ic-friends`, `ic-glitter`, `ic-graduation`, `ic-group`, `ic-heart`, `ic-hiking`, `ic-house`, `ic-laptop`, `ic-lecturer`, `ic-library`, `ic-lizard`, `ic-location-pin`, `ic-map`, `ic-medal`, `ic-moon`, `ic-mountains`, `ic-music`, `ic-pacifier`, `ic-painting`, `ic-pan`, `ic-party`, `ic-paw`, `ic-photo-frame`, `ic-puzzle`, `ic-restaurant`, `ic-ship`, `ic-signpost`, `ic-sport--basket`, `ic-star`, `ic-teddy`, `ic-thunderbolt`, `ic-toast`, `ic-two-heart`, `ic-user`, `ic-volleyball`, `ic-wedding-rings`

### media (35)

`ic-ai`, `ic-album`, `ic-archive`, `ic-book-open`, `ic-book-open--filled`, `ic-bookmark-fill`, `ic-camera`, `ic-camera--frame`, `ic-cloud`, `ic-cloud-check`, `ic-cloud-fail`, `ic-cloud-v2`, `ic-dedicatory`, `ic-gallery`, `ic-gallery--refresh`, `ic-infinity`, `ic-mic`, `ic-pages`, `ic-pic`, `ic-pic--add`, `ic-pic--add-fill`, `ic-pic--download`, `ic-pic--heart`, `ic-pic--slashed`, `ic-pic--upload`, `ic-pics`, `ic-planner`, `ic-play`, `ic-play-arrow`, `ic-play-circle`, `ic-square-arrow-down-on-square-fill `, `ic-template`, `ic-video`, `ic-video--off`, `ic-visualization`

### social (18)

`ic-chat`, `ic-chat-lock`, `ic-ellipsis-message`, `ic-emoji-love`, `ic-imessage`, `ic-link`, `ic-qr`, `ic-qr-scan-v1`, `ic-send`, `ic-share`, `ic-share-alt`, `ic-user--filled`, `ic-user-add--filled`, `ic-user-add--outlined`, `ic-user-block`, `ic-user-remove--filled`, `ic-user-remove--outlined`, `ic-whatsapp`

### editing_tools (25)

`ic-add`, `ic-add-circle`, `ic-add-circle-outline`, `ic-copy`, `ic-crop`, `ic-draw`, `ic-draw-no`, `ic-edit`, `ic-edit-notebook`, `ic-eye`, `ic-eye--off`, `ic-lines`, `ic-list`, `ic-lock`, `ic-pencil`, `ic-plus-magnifyingglass`, `ic-print`, `ic-remove`, `ic-rest`, `ic-rotate-left`, `ic-rotate-right`, `ic-star--off`, `ic-text`, `ic-trash`, `ic-trash-open`

### premium (20)

`ic-cart`, `ic-cart-badge-questionmark`, `ic-creditcard`, `ic-creditcard-alert`, `ic-diamond`, `ic-gift`, `ic-level`, `ic-level-2`, `ic-level-3`, `ic-level-4`, `ic-level-5`, `ic-level-5-square`, `ic-premium-circle`, `ic-prime-1`, `ic-prime-2`, `ic-tag`, `ic-truck`, `ic-truck-badge-clock`, `ic-volume`, `ic-volume--off`

## Dart mapping

Assets: `assets/icons/<folder>/<name>.svg` in the dots_design_system package, consumed in Flutter via `SvgPicture.asset`/`VectorGraphic` with `ColorFilter` for tinting. `name` here equals the asset filename without extension; `color` mirrors the Flutter `ColorFilter` tint; `size` mirrors the widget's width/height.
