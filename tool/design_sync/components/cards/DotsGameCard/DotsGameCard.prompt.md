DotsGameCard from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsGameCard` (bundle loaded from the root `_ds_bundle.js`). Card de un juego comprado, 340 de ancho y squircle52 como AlbumGroupCard large; tres estados (`processing` / `error` / `active`) que cambian el BadgeLabel y convierten el botón en una fila de progreso.

## Props

| Prop | Tipo | Notas |
| --- | --- | --- |
| `status` | `'processing' \| 'error' \| 'active'` | Obligatorio. Elige la variante del badge y el bloque de acción |
| `badgeText` | `string` | Obligatorio — `PREPARANDO` / `NO DISPONIBLE` / `ACTIVO` |
| `title` | `string` | Obligatorio. Mackinac 23/500, centrado |
| `description` | `string` | Obligatorio. Inter 14/400 `textTertiary`, centrado |
| `actionText` | `string` | Obligatorio. Texto del botón, o la etiqueta de progreso en `processing` |
| `imageSrc` | `string` | Artwork en caja 138×100, `object-fit: contain` |
| `image` | `ReactNode` | Alternativa a `imageSrc` (espejo del slot `image` de Dart) |
| `onActionClick` | `() => void` | `onActionTap`. **Se ignora en `processing`** |
| `progressIndicator` | `ReactNode` | Solo `processing`. Sin él, anillo de 16px de placeholder |

Badge por estado: `processing` → `secondary`, `error` → `warningMaterial`,
`active` → `greenMaterial`. Acción: `DotsMainButton` size `large`, `expand: false`.

Medidas del Dart: padding 20, gap entre bloques 18, gap de contenido 10, padding
horizontal del contenido 16, artwork 138×100, fila de progreso de alto 44 con gap 8.
Sombra: la `defaultShadow` de Figma (`0 5 blur 10 #00000014`), que NO es el token
`theme.styles.defaultShadow` — el Dart sigue al diseño hasta que converjan.

## Examples

```jsx
const { DotsGameCard } = window.DotsDesignSystem_9e41da;

<DotsGameCard
  status="active"
  imageSrc="./mision-secreta.webp"
  badgeText="ACTIVO"
  title="La Misión Secreta"
  description="Retos sorpresa para cada invitado durante toda la celebración"
  actionText="Ir al panel"
  onActionClick={goToPanel}
/>
```

```jsx
<DotsGameCard
  status="processing"
  imageSrc="./mision-secreta.webp"
  badgeText="PREPARANDO"
  title="La Misión Secreta"
  description="Estamos terminando de preparar vuestro acceso. En unos segundos podréis configurarlo"
  actionText="Preparando tu acceso…"
/>
```

## Dart mapping

`DotsGameCard` en `lib/src/components/cards/game_card/game_card.dart`.
`onActionTap`→`onActionClick`, el slot `image` (Widget) → `imageSrc` (URL) o `image` (nodo).
El ancho sale de `kAlbumLargeCardSize` (340). En Dart `progressIndicator` lo pasa
siempre el host porque el paquete no trae spinner indeterminado (`SpinnerRound` es
determinado y pinta en blanco); en web se rellena con un anillo neutro si falta.
