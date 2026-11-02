DotsMapPin from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsMapPin` (bundle loaded from the root `_ds_bundle.js`). The Dots map marker (Figma Chronicle `MapPin`): a `bgStrong` drop with a `friends008` → `labelDestructive` gradient circle and the pin glyph, over a soft ground shadow. Fixed 46 × 55 px; the tip of the drop is the point on the map.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `ariaLabel` | `string` | — | Nombre accesible (p. ej. el del lugar). Sin él el marcador es decorativo (`aria-hidden`). |
| `className` | `string` | — | Clases extra sobre el `<svg class="ds-map-pin">`. |
| `style` | `CSSProperties` | — | Estilo en línea (p. ej. el `translateY` del ancla). |

Estáticos: `DotsMapPin.size` = `{ width: 46, height: 55 }` y `DotsMapPin.anchor` = `{ x: 23, y: 51.5421 }`.

## Ancla

La punta está centrada en horizontal y **3,46 px por encima del borde inferior** de la caja (debajo queda la sombra del suelo): `DotsMapPin.anchor`, medido desde la esquina superior izquierda.

- Mapas que anclan el centro inferior de la caja (Google Maps `AdvancedMarkerElement`, Mapbox `anchor: 'bottom'`): baja el marcador 3,46 px (`transform: translateY(3.46px)`) para que la punta caiga en la coordenada.
- Mapas con ancla en píxeles (Leaflet `iconAnchor`): usa `[23, 51.54]`.

## Colores

- Gota y glifo: `bgStrong` (blanco en claro, `#3E3E3E` en oscuro).
- Círculo: `friends008` → `labelDestructive` de arriba abajo, igual en los dos temas.
- Sombra del suelo: `shadowPrimary`, con desenfoque 3. Sombra de la gota: y 1, desenfoque 5, negro 10 %.

Claro y oscuro salen de los tokens: envuelve en `data-theme="dark"` para modo oscuro.

## Examples

```jsx
const { DotsMapPin } = window.DotsDesignSystem_9e41da;

// Marcador decorativo sobre un mapa (la punta en la coordenada)
<DotsMapPin style={{ transform: 'translateY(3.46px)' }} />

// Con nombre para lectores de pantalla
<DotsMapPin ariaLabel="Finca El Olivar" />
```

## Dart mapping

- Widget: `DotsMapPin` (`lib/src/components/map_pin/dots_map_pin.dart`).
- Props: `semanticsLabel` → `ariaLabel`. Estáticos `DotsMapPin.size` (`Size`) y `DotsMapPin.anchor` (`Offset`) → `DotsMapPin.size` / `DotsMapPin.anchor` (y las exportaciones `dotsMapPinSize` / `dotsMapPinAnchor`).
- Dart lo pinta con un `CustomPainter` con los mismos trazos; web, con un SVG en línea con ids únicos por instancia.
