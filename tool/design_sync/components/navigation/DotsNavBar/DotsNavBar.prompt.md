DotsNavBar from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsNavBar` (bundle loaded from the root `_ds_bundle.js`). Floating blurred 3-item bottom nav bar with an animated selection pill and optional numeric badge; default items are the real app tabs Crear/Inicio/Galería.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `items` | `{ icon: string; label: string; badge?: number }[]` | Crear (`ic-add`), Inicio (`ic-home`), Galería (`ic-gallery`) | Los 3 items de la barra. `icon` es el nombre real del icono del DS (`DotsIcon`). `badge` es el `pendingNumber` (se muestra máx. `99`). |
| `selectedIndex` | `number` | `0` | Ítem activo; la píldora se desliza hasta él (200ms ease). |
| `onSelect` | `(index: number) => void` | — | Se llama al pulsar un ítem (Dart `DotsNavBarItem.onTap`). |
| `className` | `string` | — | Clases extra sobre `.ds-nav-bar`. |

La barra flota sobre el contenido: colócala centrada abajo (p.ej. `position:absolute; bottom:28px; left:50%; transform:translateX(-50%)`). El blur (`backdrop-filter`) solo se aprecia sobre contenido/foto.

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
| Píldora `.ds-nav-bar__pill` | `AnimatedPositioned` 200ms + `bgFloatingActive` (sin token CSS: `#00000026` / dark `#C8C8C81A`) |
| Contenedor | r36, blur 10, `bgContainerSecondary @0.7`, borde 0.70 `borderButton` |
