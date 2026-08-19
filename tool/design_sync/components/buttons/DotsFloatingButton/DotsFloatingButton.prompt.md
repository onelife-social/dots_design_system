DotsFloatingButton from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsFloatingButton` (bundle loaded from the root `_ds_bundle.js`). Floating pill button (36px tall, radius 22, blur + drop shadow) with bold white label and optional 20px icon — e.g. the "Ver mapa" button over content.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `content` | `string` (requerido) | — | Texto (labelDefaultBold 13/600, `labelAlwaysWhite`, elipsis 1 línea) |
| `icon` | `string` | — | Nombre real del asset de DotsIcon, 20px (p.ej. `'ic-map'`) |
| `onClick` | `() => void` | — | `onTap` de Dart |
| `blur` | `boolean` | `true` | BackdropFilter(10) + capa `labelAlwaysWhite` al 50% bajo `bgSecondaryBtn` |

## Examples

```jsx
const { DotsFloatingButton } = window.DotsDesignSystem_9e41da;

// Botón flotante sobre un feed/lista
<DotsFloatingButton content="Ver mapa" icon="ic-map" onClick={openMap} />

// Sin blur (sobre fondo sólido)
<DotsFloatingButton content="Nuevos recuerdos" blur={false} />
```

## Dart mapping

- Widget: `DotsFloatingButton` (`lib/src/components/buttons/dots_floating_button/dots_floating_button.dart`)
- Mapeo de props: `onTap` → `onClick`; `icon: DotsIconData?` → `icon?: string` (nombre del asset svg)
- Sombra: `--shadow-floating-btn` (0 4 15 #00000026); capa blur #FFFFFF80 sin token (labelAlwaysWhite.dotsWithOpacity(0.5))
