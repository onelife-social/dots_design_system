DotsDivider from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsDivider` (bundle loaded from the root `_ds_bundle.js`). Horizontal 2px embossed divider (1px labelSecondary over 1px bgStrong at 60% opacity), full-width by default.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `width` | `number \| string` | `100%` | Ancho del divisor (Dart `double.infinity`) |

Notas:
- Sin props de color: los tonos salen de los tokens (`--label-secondary` / `--bg-strong`), light/dark automático con `data-theme="dark"`.

## Examples

```jsx
const { DotsDivider } = window.DotsDesignSystem_9e41da;

// Separador entre secciones
<section>…</section>
<DotsDivider />
<section>…</section>

// Ancho fijo
<DotsDivider width={160} />
```

## Dart mapping

- Widget: `DotsDivider` (`lib/src/components/divider/dots_divider.dart`).
- Props: `width` 1:1.
- Estilo: `Opacity(0.60)` + `DotsBorderRadius.r1000` + dos Containers de 1px con `theme.colors.labelSecondary` y `theme.colors.bgStrong` → `.ds-divider` con tokens.
