DotsMainContainer from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsMainContainer` (bundle loaded from the root `_ds_bundle.js`). Rounded translucent base container with 4 variants (main, secondary, onBackground, tertiary), default padding 16, auto radius 24/32 by height, optional background color/image and tap handler.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `variant` | `'main' \| 'secondary' \| 'onBackground' \| 'tertiary'` | `'main'` | Fondo: main→bgContainerTertiary, secondary/onBackground→bgContainerSecondary, tertiary→bgContainerPrimary |
| `width` | `number \| string` | `100%` | Ancho (Dart: ancho de pantalla si no se indica) |
| `height` | `number \| string` | — | Alto; solo se aplica con `forceHeight` (default) |
| `padding` | `number \| string` | `16` | Padding del contenido; solo si hay `children` |
| `radius` | `number \| string` | auto | 24 si `height ≤ 100`, si no 32 (también sin height) |
| `backgroundColor` | `string` (color CSS) | — | Sobreescribe el fondo de la variante |
| `backgroundImage` | `string` | — | URL/data URI o valor CSS de background-image (cover, center) |
| `onClick` | `() => void` | — | Dart `onTap`; añade cursor pointer |
| `forceHeight` | `boolean` | `true` | Con `false` ignora `height` (alto intrínseco) |
| `children` | `ReactNode` | — | Contenido — Dart `child` |

Notas:
- Los fondos de las variantes son translúcidos: lo que haya debajo se transparenta.
- Light/dark automático vía tokens: envuelve en `data-theme="dark"` para modo oscuro.

## Examples

```jsx
const { DotsMainContainer } = window.DotsDesignSystem_9e41da;

// Tarjeta de sección estándar
<DotsMainContainer variant="secondary" forceHeight={false}>
  <h3>Ajustes</h3>
</DotsMainContainer>

// Bloque cuadrado clickable con imagen de fondo
<DotsMainContainer width={160} height={120} backgroundImage={coverUrl} onClick={open} />

// Contenedor compacto (h ≤ 100 → radio 24)
<DotsMainContainer variant="main" height={72}>contenido</DotsMainContainer>
```

## Dart mapping

- Widget: `DotsMainContainer` (`lib/src/components/containers/dots_main_container/dots_main_container.dart`).
- Props: `child`→`children`, `onTap`→`onClick`, `backgroundImage: DecorationImage`→`backgroundImage: string` (cover/center), resto 1:1 (`variant`, `width`, `height`, `padding`, `radius`, `backgroundColor`, `forceHeight`).
- Enum: `DotsMainContainerVariant` (`dots_main_container_enums.dart`) — mismos nombres de valor.
- Colores: `_getContainerBackgroundColor` → clases `ds-main-container--<variant>` con tokens `--bg-container-*`.
