DotsTopBar from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsTopBar` (bundle loaded from the root `_ds_bundle.js`). Screen top bar with status-bar gap, centered title/subtitle, back button, side icons and optional CTA; variants onlyStatusBar / title / widget / cta mirror the Dart constructors.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `variant` | `'onlyStatusBar' \| 'title' \| 'widget' \| 'cta'` | auto | Constructor Dart. Auto: `children`→widget, `ctaLabel`→cta, `title`→title, si no onlyStatusBar. |
| `title` | `string` | — | Título centrado (titleH6 18/600, textPrimary). |
| `subtitle` | `string` | — | Subtítulo (labelSmallRegular 11/400, textSecondary). |
| `imageTitle` | `string` (URL) | — | Imagen redonda 20×20 junto al título (Dart `imageTitle`, DotsProfilePhoto). |
| `children` | `ReactNode` | — | Contenido central custom (variant widget, Dart `child`). |
| `leftIcon` | `ReactNode` | — | Nodo a la izquierda; no combinable con `onBack` (assert Dart). |
| `rightIcon` | `ReactNode` | — | Nodo a la derecha, normalmente un `DotsIconButton`. |
| `onBack` | `() => void` | — | Muestra el botón atrás (`DotsIconButton` `ic-chevron-left`, medium) — Dart `onTapBack`. |
| `showCircleBackButton` | `boolean` | `false` | Botón atrás en círculo gris (`variant: 'solid'`). |
| `ctaLabel` | `string` | — | CTA a la derecha (`DotsMainButton` main · small, `expand:false`). |
| `onCtaClick` | `() => void` | — | Callback del CTA — Dart `onCtaTap`. |
| `ctaEnabled` | `boolean` | `true` | Deshabilita el CTA. |
| `bigStatusBar` | `boolean` | `true` | 106px (50 status + 56 contenido); `false` → 50px sin franja. onlyStatusBar es solo la franja (50px). |
| `hideBackground` | `boolean` | `false` | Fondo transparente en vez de `bgContainerPrimary`, sin desenfoque. |
| `color` | `string` (CSS) | — | Fuerza el color de fondo (ignora `hideBackground`), sin desenfoque. |
| `showBottomBorder` | `boolean` | `false` | Línea inferior 1px negro @0.2. |
| `className` | `string` | — | Clases extra sobre `.ds-top-bar`. |

La franja de la barra de estado mide 50px en el diseño. En el dispositivo mide lo que sea mayor entre `--ds-status-bar-min` (50px si no se define) y `env(safe-area-inset-top)`. La app nativa pone `--ds-status-bar-min: 0px`: así, si el web view empieza debajo de la barra de estado (Android sin edge-to-edge), no queda un hueco vacío. En los diseños no se define.

Colócala arriba de la pantalla a ancho completo. Con el fondo por defecto pinta `bgBase` al 95 % de opacidad con `backdrop-filter: blur(var(--blur-10))`: si la cabecera va en un bloque `position: sticky; top: 0`, el contenido que pasa por detrás se ve desenfocado y no se lee, también en la franja de la barra de estado. Un botón de color por detrás no mancha la barra. No hace falta darle fondo al contenedor. Con `hideBackground` o `color` no desenfoca.

## Examples

```jsx
const { DotsTopBar, DotsIconButton } = window.DotsDesignSystem_9e41da;

// Título + subtítulo, atrás y menú de opciones
<DotsTopBar
  title="Recuerdos"
  subtitle="12 dots nuevos"
  onBack={() => history.back()}
  rightIcon={<DotsIconButton icon="ic-options" size="medium" variant="solid" />}
  showBottomBorder
/>

// Pantalla de edición con CTA
<DotsTopBar variant="cta" title="Editar dot" onBack={close} ctaLabel="Guardar" onCtaClick={save} />

// Solo el hueco del status bar
<DotsTopBar variant="onlyStatusBar" />
```

## Dart mapping

| Web | Dart (`lib/src/components/navigation/top_bar.dart`) |
| --- | --- |
| `DotsTopBar` | `DotsTopBar` (StatelessWidget, PreferredSizeWidget) |
| `variant` | Constructores `.onlyStatusBar` / `.title` / `.widget` / `.cta` |
| `onBack` | `onTapBack` (pinta `DotsIconButton(DotsIconData.chevronLeft, medium, solid\|noBackground)`) |
| `children` | `child` (variant widget) |
| `imageTitle` | `imageTitle` (`ImageProvider` → URL; `DotsProfilePhoto` 20×20) |
| `ctaLabel`/`onCtaClick`/`ctaEnabled` | `ctaLabel`/`onCtaTap`/`ctaEnabled` (`DotsMainButton` main·small). Nota: Dart exige ambos; aquí basta `ctaLabel` |
| Alturas | `kTopBarNormalHeight = 50` / `kTopBarBigHeight = 106` |
| Fondo | `color ?? (hideBackground ? transparent : bgContainerPrimary)`. Solo en web, el fondo por defecto es `bgBase` al 95 % con `blur(var(--blur-10))`; Dart pinta `bgContainerPrimary` plano |
