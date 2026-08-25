ProductCard from dots_design_system. Use via `window.DotsDesignSystem_9e41da.ProductCard` (bundle loaded from the root `_ds_bundle.js`). Media card cuadrada con título, subtítulo y precio sobre el fondo, con blur + degradado inferior para que el blanco se lea; badge, PageControl y botón de acción opcionales.

## Props

| Prop | Tipo | Notas |
| --- | --- | --- |
| `title` | `string` | Único obligatorio |
| `imageSrc` | `string` | Foto de fondo; sin ella, degradado placeholder |
| `subtitle` | `string` | Segunda línea |
| `caption` | `string` | Tercera línea, normalmente el precio |
| `captionPrevious` | `string` | Tachado tras `caption` (precio anterior) |
| `badge` | `ReactNode` | Esquina superior derecha |
| `pageCount` / `activePage` | `number` | `0` oculta el PageControl |
| `actionIcon` | `string` | Icono DotsIcon, por defecto `ic-arrow-right` |
| `aspectRatio` | `number` | Por defecto `1` (cuadrada) |
| `onClick` / `onActionClick` | `() => void` | Sin `onActionClick` no hay botón |

Medidas del diseño: squircle 32, banda de scrim 160, padding 20 (el texto lleva
4 extra a la izquierda), ritmo vertical 6/6, puntos centrados a 122 del fondo,
botón de 36 en estilo surface.

## Examples

```jsx
const { ProductCard, BadgeLabel } = window.DotsDesignSystem_9e41da;

<ProductCard
  title="La Misión Secreta"
  subtitle="Retos sorpresa para cada invitado"
  caption="Desde 29,99 €"
  imageSrc="./gd-foto-retos.webp"
  pageCount={3}
  activePage={0}
  onClick={seeMore}
  onActionClick={seeMore}
/>
```

```jsx
<ProductCard
  title="Pack Boda"
  subtitle="Los dos juegos, en un solo pedido"
  caption="49,90 €"
  captionPrevious="antes 59,89 €"
  aspectRatio={358 / 264}
  badge={<BadgeLabel content="17% OFF" size="small" />}
  onActionClick={seePack}
/>
```

## Dart mapping

`ProductCard` en `lib/src/components/cards/product_card/product_card.dart`.
`onClick`→`onTap`, `onActionClick`→`onActionTap`, `imageSrc`→ el slot
`background` (en Dart admite cualquier widget: `PageView`, degradado…).
El botón usa `DotsIconButtonStyle.floating`, que en Figma se llama "Surface".
