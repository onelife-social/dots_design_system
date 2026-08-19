DotsSegmentedControl from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsSegmentedControl` (bundle loaded from the root `_ds_bundle.js`). Two-option segmented pill with types `text` (variants `main`/`camera`, optional right badge), `icon` (two 24 px DotsIcons with sliding pill) and `single` (one always-selected option); controlled (`selectedOption` + `onTapOption`) or uncontrolled (`defaultSelectedOption`).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `type` | `'text' \| 'icon' \| 'single'` | `'text'` | Widget Dart: `text` → SegmentedControl, `icon` → SegmentedControlIcon, `single` → SegmentedControlSingle. |
| `variant` | `'main' \| 'camera'` | `'main'` | Solo `text`. `camera`: fondo bgChip oscuro, labels blancos, seleccionado amarillo (class005). |
| `leftOptionName` / `rightOptionName` | `string` | — | Etiquetas (type `text`). |
| `rightOptionTag` | `string` | — | Badge rojo en la esquina superior derecha (type `text`). |
| `leftOptionIcon` / `rightOptionIcon` | `string` | — | Nombres de icono DotsIcon, p. ej. `'ic-camera'`, `'ic-gallery'` (type `icon`). |
| `buttonName` / `buttonTag` | `string` | — | Etiqueta y badge (type `single`). |
| `selectedOption` | `'left' \| 'right'` | — | Opción activa (modo controlado). |
| `defaultSelectedOption` | `'left' \| 'right'` | `'left'` | Opción inicial (modo no controlado). |
| `onTapOption` | `(option) => void` | — | Se invoca con la opción pulsada (también si ya estaba activa, como en Dart). |
| `selectedColor` | `string` (color CSS) | `var(--bg-secondary-btn)` | Fondo del segmento seleccionado (`text`/`single`). |
| `backgroundColor` | `string` (color CSS) | según type/variant | Fondo del contenedor (`text`/`single`). |

## Examples

```jsx
// Texto, no controlado
<DotsSegmentedControl leftOptionName="Fotos" rightOptionName="Vídeos"
  defaultSelectedOption="left" onTapOption={(o) => console.log(o)} />

// Texto controlado con badge y variante cámara
const [opt, setOpt] = React.useState('right');
<DotsSegmentedControl leftOptionName="Foto" rightOptionName="Vídeo" variant="camera"
  rightOptionTag="3" selectedOption={opt} onTapOption={setOpt} />

// Iconos y opción única
<DotsSegmentedControl type="icon" leftOptionIcon="ic-camera" rightOptionIcon="ic-gallery" />
<DotsSegmentedControl type="single" buttonName="Todos" buttonTag="5" />
```

## Dart mapping

- Widgets: `SegmentedControl`, `SegmentedControlIcon`, `SegmentedControlSingle` (`lib/src/components/segmented_control/`), unificados bajo la prop `type`.
- Enums: `SegmentedControlOption.left/right` → `'left' | 'right'`; `SegmentedControlVariant.main/camera` → `variant`.
- `onTapOption(SegmentedControlOption)` → `onTapOption('left' | 'right')`; `defaultSelectedOption` es extensión web (modo no controlado).
- Medidas Dart: contenedor h36 (icon: 108×48), itemPadding 4, textPadding 0 15, radio r1000, blur bgBlur 50; pill seleccionada h28 (icon: 48×40, animación 200 ms easeInOutCubic).
- Colores sin token CSS (hex documentado en el .css): `bgChip` #30303099, `class005` #F4BD24, `bgFloatingActive` #00000026/#C8C8C81A. El badge es el `BadgeTag` Dart (minH 18, r22, `labelDestructive`).
