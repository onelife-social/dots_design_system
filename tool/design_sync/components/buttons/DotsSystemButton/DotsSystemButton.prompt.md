DotsSystemButton from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsSystemButton` (bundle loaded from the root `_ds_bundle.js`). Translucent system button (blurred bgContainerSecondaryOnBackground, radius 16, height 44) with variants active / disabled / destructive and an optional leading icon.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `label` | `string` (requerido) | — | Texto del botón (Dart `content`) |
| `variant` | `'active' \| 'disabled' \| 'destructive'` | `'active'` | Enum Dart `DotsSystemButtonVariant`. `disabled` es SOLO visual: el botón sigue emitiendo `onClick`, igual que en Dart |
| `icon` | `string` | — | Nombre de icono DotsIcon a la izquierda, p.ej. `'ic-add'` (20px) |
| `size` | `'medium'` | `'medium'` | Enum Dart `DotsSystemButtonSize` — único valor: altura 44, padding 24, gap 6 |
| `onClick` | `() => void` | — | Callback de tap (Dart `onTap`) |
| `expand` | `boolean` | `false` | `width:100%` (en Flutter el Row `mainAxisSize.max` llena al padre) |

Todas las variantes comparten el mismo fondo `--bg-container-secondary-on-bg` con blur 50; solo cambia el color de texto/icono: `active` → `--text-primary`, `disabled` → `--text-disabled`, `destructive` → `--label-destructive`. Light/dark automático vía tokens (`data-theme="dark"`).

## Examples

```jsx
const { DotsSystemButton } = window.DotsDesignSystem_9e41da;

// Acción de sistema con icono
<DotsSystemButton label="Añadir recuerdo" icon="ic-add" onClick={addMemory} />

// Destructiva
<DotsSystemButton label="Eliminar" variant="destructive" icon="ic-trash" onClick={remove} />

// Ancho completo
<DotsSystemButton label="Guardar cambios" expand onClick={save} />
```

## Dart mapping

- Widget: `DotsSystemButton` (`lib/src/components/buttons/dots_system_button/dots_system_button.dart`).
- Props: `content`→`label`, `onTap`→`onClick`, `icon: DotsIconData`→`icon: string` (nombre del asset); `size` y `variant` 1:1.
- Enums: `DotsSystemButtonVariant` (active/disabled/destructive), `DotsSystemButtonSize` (medium).
- Tema: `getSystemButtonThemeByVariant` (`dots_system_button_theme.dart`) → clases `ds-system-btn--<variant>` con tokens de `foundations/tokens.css`.
