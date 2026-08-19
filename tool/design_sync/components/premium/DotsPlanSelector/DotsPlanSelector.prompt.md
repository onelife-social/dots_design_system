DotsPlanSelector from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsPlanSelector` (bundle loaded from the root `_ds_bundle.js`). Plan picker card (variants `basic`, `premium`, `premiumPlus`) that shows the plan's branded webp background when `selected`, neutral container when not, and dimmed text when disabled.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `title` | `string` | — (requerido) | Título del plan, centrado (bodyDefaultBold 14/700). |
| `description` | `string` | — | Línea secundaria bajo el título (labelSmallRegular 11/400). Omitida si vacía. |
| `variant` | `'basic' \| 'premium' \| 'premiumPlus'` | — (requerido) | Decide el fondo webp usado al estar seleccionado (bg_basic / bg_premium / bg_premium_plus, incrustados como data URI). |
| `selected` | `boolean` | — (requerido) | Seleccionado + enabled ⇒ fondo webp y texto labelAlwaysWhite. Sin seleccionar ⇒ bgContainerSecondaryOnBackground + textPrimary. |
| `enabled` | `boolean` | `true` | `false` ⇒ texto textQuarternary, sin fondo de imagen y sin onClick. |
| `onClick` | `() => void` | — | Dart `onTap`. Solo dispara si `enabled`. |
| `className` | `string` | — | Clases extra sobre `.ds-plan-selector`. |

El alto es fijo a 80px (en Flutter es 9.5–11.1% del alto de pantalla). Ocupa el 100% del ancho disponible: colócalo en un contenedor flex con `gap: 8px` para el trío de planes.

## Examples

```jsx
const { DotsPlanSelector } = window.DotsDesignSystem_9e41da;

// Trío típico del paywall
<div style={{ display: 'flex', gap: 8 }}>
  <DotsPlanSelector title="Básico" description="Gratis" variant="basic" selected={false} onClick={pickBasic} />
  <DotsPlanSelector title="Premium" description="4,99 €/mes" variant="premium" selected onClick={pickPremium} />
  <DotsPlanSelector title="Premium+" description="9,99 €/mes" variant="premiumPlus" selected={false} onClick={pickPlus} />
</div>

// No disponible
<DotsPlanSelector title="Premium+" description="No disponible" variant="premiumPlus" selected={false} enabled={false} />
```

## Dart mapping

| Web | Dart (`lib/src/components/premium/dots_plan_selector.dart`) |
| --- | --- |
| `DotsPlanSelector` | `DotsPlanSelector` |
| `variant: 'basic' \| 'premium' \| 'premiumPlus'` | enum `DotsPlanSelectorVariant` |
| `title` / `description` / `selected` / `enabled` | mismos nombres |
| `onClick` | `onTap` |
| Fondos webp data URI | `ImagesPaths.bgBasic` / `bgPremium` / `bgPremiumPlus` (assets/images/*.webp) |
| radio 16, padding 4, alto 80px | `DotsBorderRadius.r16`, `EdgeInsets.all(4)`, `screenHeight × getByRatio(0.095, 0.111)` |
