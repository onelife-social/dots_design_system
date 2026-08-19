DotsCloseButton from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsCloseButton` (bundle loaded from the root `_ds_bundle.js`). Circular close (cross) button with variants softContrast/highContrast/onBackground/inverted and sizes large/medium/small/extraSmall.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `icon` | `string` | `'ic-cross'` | Nombre real del asset de DotsIcon (`DotsIconData.cross`) |
| `size` | `'large' \| 'medium' \| 'small' \| 'extraSmall'` | `'large'` | Diámetro 44/30/24/16, icono 20/16/16/10 |
| `variant` | `'softContrast' \| 'highContrast' \| 'onBackground' \| 'inverted'` | `'softContrast'` | Contraste del fondo/icono |
| `onClick` | `() => void` | — | `onTap` de Dart |
| `color` | `string` | color del tema | Fuerza el color del icono |
| `addBlur` | `boolean` | `true` | Backdrop blur (theme.styles.bgBlur, 50) |

## Examples

```jsx
const { DotsCloseButton } = window.DotsDesignSystem_9e41da;

// Cierre estándar de modal/sheet (44px, softContrast)
<DotsCloseButton onClick={onClose} />

// Pequeño e invertido sobre thumbnail
<DotsCloseButton size="extraSmall" variant="inverted" onClick={onRemove} />
```

## Dart mapping

- Widget: `DotsCloseButton` (`lib/src/components/buttons/dots_close_button/dots_close_button.dart`)
- Enums: `DotsCloseButtonSize`, `DotsCloseButtonVariant` (`dots_close_button_enums.dart`)
- Tema: `getCloseButtonThemeByVariant` (`dots_close_button_theme.dart`)
- Mapeo de props: `onTap` → `onClick`; `icon: DotsIconData` → `icon: string` (nombre del asset svg)
