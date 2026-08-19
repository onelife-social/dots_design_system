BtnFolder from dots_design_system. Use via `window.DotsDesignSystem_9e41da.BtnFolder` (bundle loaded from the root `_ds_bundle.js`). Home folder pill (44px tall, radius 1000) with icon + label, selected state (bgStrong + shadow + tinted icon), icon-only non-expandable mode and optional edit badge.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `icon` | `string` (requerido) | — | Nombre real del asset de DotsIcon (20px), p.ej. `'ic-family'` |
| `text` | `string` | — | Label (bodyDefaultMedium 14/500); >20 chars se trunca con `…` |
| `onClick` | `() => void` | — | `onTap` de Dart |
| `onLongPress` | `() => void` | — | `onLongPress` de Dart (~500ms) y click del badge de edición |
| `isSelected` | `boolean` | `false` | Fondo `bgStrong`, texto `textPrimary`, sombra shadowFolder, icono `iconSelectedColor` |
| `isNonExpandable` | `boolean` | `false` | Solo icono, 44×44 (icono siempre `textQuarternary`) |
| `iconSelectedColor` | `string` (requerido) | `'#3E9ACB'` si se omite | Color del icono al seleccionar — azul de las carpetas del home (sin token) |
| `showEditIcon` | `boolean` | `false` | Badge lápiz 18px arriba-derecha (requiere `isEditable`) |
| `isEditable` | `boolean` | `false` | Habilita el badge de edición |

## Examples

```jsx
const { BtnFolder } = window.DotsDesignSystem_9e41da;

// Carpeta seleccionada del home
<BtnFolder icon="ic-family" text="Familia" isSelected iconSelectedColor="#3E9ACB"
  onClick={select} onLongPress={edit} showEditIcon isEditable />

// Carpeta normal + botón añadir (no expandible)
<BtnFolder icon="ic-map" text="Viajes" iconSelectedColor="#3E9ACB" onClick={select} />
<BtnFolder icon="ic-add" isNonExpandable iconSelectedColor="#3E9ACB" onClick={addFolder} />
```

## Dart mapping

- Widget: `BtnFolder` (`lib/src/components/buttons/btn_folder/btn_folder.dart`)
- Mapeo de props: `onTap` → `onClick`, `onLongPress` → `onLongPress`; `icon: DotsIconData` → `icon: string`; `iconSelectedColor: Color` → string CSS
- Badge de edición: `DotsIconData.pencil` → `'ic-pencil'` (10px) sobre `bgChip` #30303099 (sin token)
- Sin token: shadowFolder #00000014 (sombra selected 1 4 4)
