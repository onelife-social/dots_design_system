DotsBottomEdgeBlur from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsBottomEdgeBlur` (bundle loaded from the root `_ds_bundle.js`). Envuelve contenido y le añade una banda inferior de desenfoque progresivo (de nítido a borroso) para fundirlo con el pie de una card en vez de cortarlo en seco.

## Props

| Prop | Tipo | Notas |
| --- | --- | --- |
| `children` | `ReactNode` | Contenido sobre el que se pinta la banda (Dart: `child`) |
| `edgeSize` | `number` | Obligatorio. Alto de la banda. `0` → no pinta nada |
| `sigma` | `number` | Fuerza del desenfoque abajo. Por defecto `12`; `0` → no pinta nada |
| `className` | `string` | |

El degradado de la máscara replica el smoothstep del Dart (opacidades
0 / .11 / .35 / .65 / .89 / 1 repartidas por la banda).

## Examples

```jsx
const { DotsBottomEdgeBlur } = window.DotsDesignSystem_9e41da;

// Fundido al pie de una rejilla de fotos dentro de una card
<DotsBottomEdgeBlur edgeSize={80}>
  <PhotoGrid />
</DotsBottomEdgeBlur>
```

```jsx
// Banda más alta y más suave para un bloque de texto
<DotsBottomEdgeBlur edgeSize={120} sigma={16}>
  <p>…</p>
</DotsBottomEdgeBlur>
```

## Dart mapping

`DotsBottomEdgeBlur` en `lib/src/components/containers/dots_bottom_edge_blur.dart`.
Sustituye al antiguo `soft_edge_blur` en las cards de grupo y en `ProductCard`.

Diferencia de implementación: el Dart pinta una **copia borrosa del hijo** con
`ImageFiltered` + `ShaderMask` porque los `BackdropFilter` de Flutter muestrean en
espacio de pantalla y producen shimmer con Impeller al hacer scroll. En web
`backdrop-filter` no tiene ese problema, así que el port usa una banda con
`backdrop-filter` + `mask-image`: mismo resultado visual sin duplicar el DOM.
Por eso **no existe la prop `blurChild`**, que en Dart solo sirve para evitar
duplicar hijos con estado.
