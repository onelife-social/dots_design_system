BlurContainer from dots_design_system. Use via `window.DotsDesignSystem_9e41da.BlurContainer` (bundle loaded from the root `_ds_bundle.js`). Blurs its whole content (sigma 0–5); the `BlurContainer.GradientBlur` member is the DotsLinearGradientBlur port: progressive blur along a linear gradient (values/stops/start/end) with optional tint — the album-name fade used on home.

## Props

### BlurContainer

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `sigma` | `number` (requerido) | — | Blur en px, clamp 0–5 (assert Dart) |
| `children` | `ReactNode` | — | Contenido a blurear — Dart `child` |

### BlurContainer.GradientBlur

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `sigma` | `number` | `8` | Desviación del blur en px (Dart lo exige) |
| `values` | `number[]` | `[0, 1]` | Fuerza de blur por stop: 0 = nada, 1 = sigma completo |
| `stops` | `number[]` | equiespaciados | Posiciones 0–1; misma longitud que `values` |
| `start` | alignment | `'topCenter'` | `'topLeft' \| 'topCenter' \| 'topRight' \| 'centerLeft' \| 'center' \| 'centerRight' \| 'bottomLeft' \| 'bottomCenter' \| 'bottomRight'` |
| `end` | alignment | `'bottomCenter'` | Fin del gradiente |
| `tintColor` | `string` (color CSS) | transparente | Tinte sobre la zona blureada |
| `children` | `ReactNode` | — | Contenido — Dart `child` |

Notas:
- Aproximación web del shader: `filter: blur` (BlurContainer) y overlay con `backdrop-filter` + `mask-image` de gradiente (GradientBlur) — misma técnica que las tarjetas/screens ya subidas.
- Patrón del home para nombres de álbum sobre foto: `values=[0,1]`, `stops=[0.35,0.8]`, de `topCenter` a `bottomCenter`.
- El contenedor del contenido debe recortar (`overflow:hidden` + borde redondeado) para que el blur no sangre.

## Examples

```jsx
const { BlurContainer } = window.DotsDesignSystem_9e41da;

// Blur completo del contenido
<BlurContainer sigma={3}>
  <img src={photo} style={{ width: 160, borderRadius: 16 }} />
</BlurContainer>

// Fade con blur degradado al pie (nombres de álbum en home)
<BlurContainer.GradientBlur
  sigma={8}
  values={[0, 1]} stops={[0.35, 0.8]}
  start="topCenter" end="bottomCenter"
  tintColor="rgba(0,0,0,0.2)"
>
  <div className="album-cover">Verano 2024</div>
</BlurContainer.GradientBlur>
```

## Dart mapping

- Widgets: `BlurContainer` (`lib/src/components/containers/blur_container.dart`) y `DotsLinearGradientBlur` + `LinearGradientBlur` (`lib/src/components/containers/dots_linear_gradient_blur.dart`).
- Props: `child`→`children`; `linearGradientBlur: LinearGradientBlur(values, stops, start, end)` → props planas `values`/`stops`/`start`/`end` (Alignment→string); `tintColor: Color`→`tintColor: string`; `sigma` 1:1.
- No portados: `DotsLinearGradientBlur.custom` (blurTexture propia), `blurTextureDimensions` y `precache` (detalles del shader sin equivalente CSS).
