AlbumGroupCard from dots_design_system. Use via `window.DotsDesignSystem_9e41da.AlbumGroupCard` (bundle loaded from the root `_ds_bundle.js`). Square album card with photo background, blurred bottom fade and centered title, in 2 variants (small 148px squircle32 / large 288px squircle52), with optional CardTag icon and blocked state.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `title` | `string` (requerido) | — | Título centrado abajo (small: bodyDefaultMedium 14 · large: bodyLargeMedium 16) |
| `imageSrc` | `string` | — | URL de la foto de fondo; sin ella se pinta placeholder degradado |
| `variant` | `'small' \| 'large'` | `'small'` | Variante visual (enum Dart `AlbumGroupCardVariant`) |
| `tagIcon` | `string` | — | Icono del CardTag Ø28 arriba-izquierda, p.ej. `'ic-prime-1'` |
| `isBlocked` | `boolean` | `false` | Candado `ic-lock` 32 centrado; oculta el tag |
| `edgeSize` | `number` | `60 / 110` | Altura del difuminado inferior |
| `blurSigma` | `number` | `12` | Sigma del SoftEdgeBlur (aproximado en CSS) |
| `size` | `number` | `148 / 288` | Lado en px (1:1; Dart acota 135–160 small, 288–340 large) |
| `onClick` | `() => void` | — | Tap en la tarjeta (Dart `onTap`) |

## Examples

```jsx
const { AlbumGroupCard } = window.DotsDesignSystem_9e41da;

// Grid del home: pares de álbumes small con tag premium
<AlbumGroupCard variant="small" title="Álbum del abuelo" tagIcon="ic-prime-1" imageSrc={url} onClick={open} />

// Álbum destacado grande
<AlbumGroupCard variant="large" title="Verano en familia" imageSrc={url} />

// Álbum bloqueado (candado, sin tag)
<AlbumGroupCard variant="small" title="Bloqueado" isBlocked />
```

## Dart mapping

- Widget: `AlbumGroupCard` (`lib/src/components/cards/group_cards/album_group_card.dart`).
- Props: `imageProvider`→`imageSrc`, `tagIconData`→`tagIcon` (nombre de asset), `onTap`→`onClick`; resto 1:1 (`title`, `variant`, `isBlocked`, `edgeSize`, `blurSigma`). `onError` no se porta.
- Enum: `AlbumGroupCardVariant` (small/large) — mismos nombres.
- Aproximaciones: squircle32/52 → border-radius; SoftEdgeBlur → overlay con backdrop-blur + máscara; ShaderMask del CardTag → color sólido `#7188F5`.
