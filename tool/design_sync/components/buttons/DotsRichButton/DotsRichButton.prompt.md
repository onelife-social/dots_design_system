DotsRichButton from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsRichButton` (bundle loaded from the root `_ds_bundle.js`). Wide blurred button (sizes large 358×75 / medium 358×60 / small 248×60) with a leading icon or image, centered content + details, and a trailing text (with red dot) or chevron.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `size` | `'large' \| 'medium' \| 'small'` | `'medium'` | large 358×75 r100 · medium 358×60 r32 · small 248×60 r32. En un contenedor de ancho definido más estrecho, el ancho se ajusta a él (`max-width: 100%`); un padre que se ajusta al contenido (flex item centrado, `inline-flex`, `absolute` sin ancho) necesita `align-self: stretch` o `width: 100%`. |
| `textSize` | `'large' \| 'medium'` | `'medium'` | bodyLargeMedium (16/500) o bodyDefaultMedium (14/500). |
| `icon` | `string` | — | Nombre DotsIcon leading, 24 px (ej. `'ic-pics'`). |
| `iconColor` | `string` | `var(--text-secondary)` | Color CSS del icono leading. |
| `image` | `string` | — | URL de imagen leading 32 × 32 (tiene prioridad sobre `icon`). |
| `content` | `string` | — | Texto principal (requerido). |
| `details` | `string` | — | Línea secundaria (labelSmallRegular, textSecondary). |
| `trailingText` | `string` | — | Texto trailing (labelDefaultBold, textTertiary) + punto rojo sobre el content; sin él se muestra chevron `ic-chevron-right`. |
| `onClick` | `() => void` | — | Dart `onTap`. |
| `enabled` | `boolean` | `true` | Con `false` se pinta con los colores de `DotsMainButton` disabled (fondo `bgBtnDisabled`; content, details, icono y trailing en `textDisabled`; imagen al 20 % de opacidad) y se ignoran clicks. |
| `isLoading` | `boolean` | `false` | `DotsSpinner` indeterminado `tone="accent"` de 24 px centrado en lugar de leading, content y trailing; el fondo no cambia y se bloquea el click. |

## Examples

```jsx
<DotsRichButton size="large" textSize="large" icon="ic-pics"
  content="Crea tu DotBook" details="Desde 29,99 €" trailingText="Nuevo" onClick={go} />

<DotsRichButton size="medium" textSize="medium" image={coverUrl}
  content="Recap del verano" details="12 recuerdos" onClick={openRecap} />

<DotsRichButton size="small" textSize="medium" icon="ic-clock-outline" content="Historial" />

// Acceso con Apple y Google mientras se entra con Apple (Weddings · sign_in)
<DotsRichButton size="medium" image={appleLogo} content="Continuar con Apple" isLoading />
<DotsRichButton size="medium" image={googleLogo} content="Continuar con Google" enabled={false} />
```

## Dart mapping

- Widget: `DotsRichButton` (`lib/src/components/buttons/dots_rich_button/dots_rich_button.dart`).
- `size` → `DotsRichButtonSize` (width×height y radio 100/32; con `max-width: 100%` el ancho no pasa de un contenedor de ancho definido, como las restricciones de Flutter); `textSize` → `DotsRichButtonTextSize`; `onTap` → `onClick`; `image` (ImageProvider) → URL.
- Fondo `bgContainerSecondary` + `BackdropFilter blur(50)` → `backdrop-filter: blur(var(--blur-50))`.
- Leading: imagen 32 × 32 cover, o `DotsIcon(icon, 24, iconColor ?? textSecondary)`.
- Trailing: `trailingText` en labelDefaultBold `textTertiary`, o `DotsIcon(DotsIconData.chevronRight, 20, textTertiary)` → `ic-chevron-right`.
- `enabled` / `isLoading` → mismos nombres. Loading en Dart: `GradientProgressIndicator` (radio 12, stroke 3, degradado a `labelHighlight`), como el de `DotsMainButton`; en web, `DotsSpinner` indeterminado `accent`.
- Punto rojo 6 px (`Colors.red` #F44336, sin token) sobre el content cuando hay `trailingText`, como en Dart.
