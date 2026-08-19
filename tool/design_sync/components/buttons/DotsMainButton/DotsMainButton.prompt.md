DotsMainButton from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsMainButton` (bundle loaded from the root `_ds_bundle.js`). Pill-shaped primary button with 15 variants (main, secondary, secondaryPremium, secondaryPremiumPlus, secondaryLight, secondaryDark, destructive, disabled, disabledOpaque, ghost, premium, premiumPlus, surface, surfacePremium, surfacePremiumPlus), 4 sizes (mainAction 52 / large 44 / medium 36 / small 28), optional icon, details text and loading state.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `label` | `string` (requerido) | — | Texto del botón (Dart `content`) |
| `variant` | `'main' \| 'secondary' \| 'secondaryPremium' \| 'secondaryPremiumPlus' \| 'secondaryLight' \| 'secondaryDark' \| 'destructive' \| 'disabled' \| 'disabledOpaque' \| 'ghost' \| 'premiumPlus' \| 'premium' \| 'surface' \| 'surfacePremium' \| 'surfacePremiumPlus'` | `'main'` | Variante visual (enum Dart `DotsMainButtonVariant`) |
| `size` | `'mainAction' \| 'large' \| 'medium' \| 'small'` | `'large'` | Alturas 52/44/36/28, radio = altura (píldora) |
| `icon` | `string` | — | Nombre de icono DotsIcon, p.ej. `'ic-check'` |
| `iconSize` | `number` | `20` | Tamaño del icono en px |
| `iconPosition` | `'left' \| 'right'` | `'left'` | Posición del icono |
| `details` | `string` | — | Texto secundario al 60%; solo se muestra en `mainAction` y `large` |
| `enabled` | `boolean` | `true` | Con `false` se pinta `disabledVariant` y se ignoran clicks |
| `disabledVariant` | variant | `'disabled'` | Variante usada cuando `enabled=false` (`'disabled'` o `'disabledOpaque'`) |
| `isLoading` | `boolean` | `false` | Spinner centrado en lugar del contenido; bloquea el click |
| `onClick` | `() => void` | — | Callback de tap (Dart `onTap`) |
| `expand` | `boolean` | `true` | `width:100%`; usa `false` para ancho intrínseco |
| `shouldApplyBlur` | `boolean` | `false` | Aplica backdrop-blur (y sombra en secondaryLight/Dark y premium no-mainAction) |
| `adaptPaddingForText` | `boolean` | `false` | Padding horizontal compacto de 7px |
| `textColor` / `iconColor` / `backgroundColor` | `string` (color CSS) | — | Overrides puntuales del tema |
| `textStyle` | `React.CSSProperties` | — | Estilo inline extra del texto |
| `useThrottle` | `boolean` | `false` | Ignora taps repetidos dentro de la ventana |
| `throttleDuration` | `number` (ms) | `400` | Ventana del throttle |

Notas:
- `premium`/`premiumPlus`: con `size='mainAction'` el degradado va al FONDO; en el resto de tamaños el fondo es translúcido y el degradado va al TEXTO.
- `secondaryPremium(Plus)`/`surfacePremium(Plus)` siempre pintan el texto en degradado (se anula si pasas `textColor`).
- Light/dark automático vía tokens: envuelve en `data-theme="dark"` para modo oscuro.

## Examples

```jsx
const { DotsMainButton } = window.DotsDesignSystem_9e41da;

// CTA principal a ancho completo
<DotsMainButton label="Continuar" size="mainAction" onClick={next} />

// Botón premium con icono y detalle
<DotsMainButton
  label="Hazte premium"
  details="4,99 €/mes"
  variant="premium"
  size="mainAction"
  icon="ic-diamond"
  expand={false}
/>

// Secundario translúcido sobre imagen, con blur y estado deshabilitado
<DotsMainButton label="Editar" variant="secondaryLight" shouldApplyBlur icon="ic-edit" expand={false} />
<DotsMainButton label="Guardar" enabled={false} isLoading={saving} />
```

## Dart mapping

- Widget: `DotsMainButton` (`lib/src/components/buttons/dots_main_button/dots_main_button.dart`).
- Props: `content`→`label`, `onTap`→`onClick`, `icon: DotsIconData`→`icon: string` (nombre del asset), resto 1:1 en camelCase (`enabled`, `expand`, `shouldApplyBlur`, `isLoading`, `disabledVariant`, `useThrottle`, `throttleDuration`…). `splashColor`/`highlightColor` (efecto ink de Flutter) no se portan.
- Enums: `DotsMainButtonVariant`, `DotsMainButtonSize`, `DotsMainButtonIconPosition` — mismos nombres de valor.
- Tema: `getButtonThemeByButtonVariant` (`dots_main_button_theme.dart`) → clases CSS `ds-main-btn--<variant>` con tokens de `foundations/tokens.css`.
