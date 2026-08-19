CreateCard from dots_design_system. Use via `window.DotsDesignSystem_9e41da.CreateCard` (bundle loaded from the root `_ds_bundle.js`). 164×112 r24 create-memory card in 2 variants (label: gradient suggestion card with a 32px icon, bottom title and a floating + button · button: neutral centered "+ create" card).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `title` | `string` (requerido) | — | label: título abajo (bodyLargeMedium, máx 2 líneas) · button: label bajo el círculo |
| `variant` | `'label' \| 'button'` | `'label'` | Variante visual (enum Dart `CreateCardVariant`) |
| `icon` | `string` | — | Icono 32 blanco arriba-izquierda (variante label), p.ej. `'ic-pic'` (requerido en Dart para label) |
| `primaryColor` | `string` (color CSS) | — | Inicio del degradado horizontal; sin él cae al degradado verde de marca (Dart no pinta fondo) |
| `secondaryColor` | `string` | `primaryColor` | Fin del degradado |
| `width` | `number` | `164` | Ancho en px (altura fija 112) |
| `onClick` | `() => void` | — | Tap en la tarjeta (Dart `onTap`) |

## Examples

```jsx
const { CreateCard } = window.DotsDesignSystem_9e41da;

// Sugerencia con degradado y botón + flotante
<CreateCard
  title="Primer viaje juntos"
  icon="ic-pic"
  primaryColor="#77D98A"
  secondaryColor="#28AB87"
  onClick={createFromPrompt}
/>

// Tarjeta neutra "crear recuerdo"
<CreateCard variant="button" title="Crear recuerdo" onClick={create} />
```

## Dart mapping

- Widget: `CreateCard` (`lib/src/components/cards/create_card/create_card.dart`).
- Props: `onTap`→`onClick`, `icon: DotsIconData`→`icon: string` (nombre de asset), `primaryColor/secondaryColor: Color`→string CSS; resto 1:1 (`title`, `width`, `variant`).
- Enum: `CreateCardVariant` (label/button) — mismos nombres.
- Detalles fieles: botón + flotante = `DotsIconButton` medium Ø28 disabled con `bgBtnImage` al 40% e icono `ic-add` 14 blanco; variante button = círculo Ø36 `bgContainerSecondaryOnBackground` con `ic-add` 16 y label `labelDefaultRegular` en `textPrimary`.
