DotsNavBar from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsNavBar` (bundle loaded from the root `_ds_bundle.js`). Floating blurred bottom nav bar with an animated selection pill and optional numeric badge; default items are the real app tabs Crear/Inicio/Galería. Items are 70px wide, or as wide as their label needs when it is longer; a label never wraps.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `items` | `{ icon: string; label: string; badge?: number }[]` | Crear (`ic-add`), Inicio (`ic-home`), Galería (`ic-gallery`) | Los items de la barra (en Dart, exactamente 3). `icon` es el nombre real del icono del DS (`DotsIcon`). `badge` es el `pendingNumber` (se muestra máx. `99`). |
| `selectedIndex` | `number` | `0` | Ítem activo; la píldora se desliza hasta él y toma su ancho (200ms ease). |
| `onSelect` | `(index: number) => void` | — | Se llama al pulsar un ítem (Dart `DotsNavBarItem.onTap`). |
| `className` | `string` | — | Clases extra sobre `.ds-nav-bar`. |

La barra flota sobre el contenido: colócala centrada abajo dentro de un contenedor con márgenes laterales (p.ej. `position:absolute; bottom:28px; left:16px; right:16px; display:flex; justify-content:center; pointer-events:none`, y `pointer-events:auto` en la barra para que los lados vacíos no tapen los toques). Nunca pasa del ancho de ese contenedor:

- Si no hay sitio para 70px por ítem, los ítems estrechan hasta el ancho de su etiqueta.
- Si ni así caben, la barra ocupa todo el contenedor, los ítems bajan a 4px de margen lateral (mínimo 44px de ancho) y las etiquetas más largas acaban en «…».

El contenedor tiene que tener un ancho propio (márgenes `left`/`right`, o un `width`). Si se ajusta al contenido de la barra, como `left:50%; transform:translateX(-50%)` o un `inline-block`, la barra no tiene ancho al que ajustarse: con etiquetas largas se sale de la pantalla, o se queda en «…» aunque luego haya sitio. El blur (`backdrop-filter`) solo se aprecia sobre contenido/foto.

## Examples

```jsx
const { DotsNavBar } = window.DotsDesignSystem_9e41da;

// Tabs reales de la app, Galería con 3 pendientes
<DotsNavBar
  items={[
    { icon: 'ic-add', label: 'Crear' },
    { icon: 'ic-home', label: 'Inicio' },
    { icon: 'ic-gallery', label: 'Galería', badge: 3 },
  ]}
  selectedIndex={1}
  onSelect={(i) => setTab(i)}
/>

// Con los defaults (mismos 3 items, sin badge)
<DotsNavBar selectedIndex={0} onSelect={setTab} />
```

## Dart mapping

| Web | Dart (`lib/src/components/nav_bar/nav_bar.dart`) |
| --- | --- |
| `DotsNavBar` | `DotsNavBar` (StatelessWidget, `assert(items.length == 3)`) |
| `items[].icon` | `DotsNavBarItem.iconData` (`DotsIconData`) |
| `items[].label` | `DotsNavBarItem.label` |
| `items[].badge` | `DotsNavBarItem.pendingNumber` (cap `kMaxPendingNumber = 99`, badge `BadgeTag` destructive) |
| `selectedIndex` | `selectedIndex` |
| `onSelect(i)` | `DotsNavBarItem.onTap` |
| Ancho del ítem | 70 fijo en Dart. En web, 70 o la etiqueta + 8px por lado si es más ancha, y menos cuando el contenedor no da para 70 en todos: con 70 fijos una etiqueta de más de 54px se parte en dos líneas |
| Píldora `.ds-nav-bar__pill` | `AnimatedPositioned` 200ms (`left = i × 70`) + `bgFloatingActive` (sin token CSS: `#00000026` / dark `#C8C8C81A`). En web toma la posición y el ancho medidos del ítem |
| Contenedor | r36, blur 10, `bgContainerSecondary @0.7`, borde 0.70 `borderButton` |
