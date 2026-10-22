DotsCheckCircle from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsCheckCircle` (bundle loaded from the root `_ds_bundle.js`). Circular multi-select check (24 px): off = 2 px `--label-secondary` ring, on = `--label-highlight` disc with a white `ic-check` of 14 px. Controlled (`isSelected` + `onChanged`) or uncontrolled (`defaultSelected`); a tap toggles. With `isSelected` and no `onChanged` it is display-only (a `<span aria-hidden>`): the clickable parent owns the toggle.

Cuándo usarlo:
- Selección múltiple sobre fondo sólido (tarjetas, filas de lista): `DotsCheckCircle`.
- Selección única: `DotsRadioButton` (mismo aro de 24 px y 2 px).
- Sobre una foto: `DotsSelector` (aro blanco al 70 %).

No dibujes el círculo a mano con un `div` y `ic-check`: usa este componente.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `isSelected` | `boolean` | — | Estado marcado (modo controlado). |
| `defaultSelected` | `boolean` | `false` | Estado inicial en modo no controlado (pulsar alterna). |
| `onChanged` | `(isSelected: boolean) => void` | — | Se invoca con el nuevo estado al pulsar. Sin él y con `isSelected`, el check es solo visual: no es un control ni recibe foco. |
| `size` | `number` | `24` | Diámetro en px. El check sigue a 14 px. |
| `disabled` | `boolean` | `false` | Deshabilita (opacidad 0.4, sin interacción). Extensión web. |
| `ariaLabel` | `string` | — | Nombre accesible de la opción (el check no tiene texto propio). No aplica al modo solo visual. |
| `ariaLabelledBy` | `string` | — | Id del elemento que nombra la opción (alternativa a `ariaLabel`). |

## Examples

```jsx
// Tarjeta seleccionable: toda la tarjeta alterna; el check solo refleja el estado (sin onChanged)
<DotsMainContainer radius={24} backgroundColor="var(--bg-container-secondary-on-bg)" padding="14px 16px" forceHeight={false} onClick={toggleAlbum}>
  <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
    <DotsCheckCircle isSelected={album} />
    <span>Álbum de fotos</span>
  </div>
</DotsMainContainer>

// Suelto, controlado
<DotsCheckCircle isSelected={on} onChanged={setOn} ariaLabel="Juegos" />
```

Dentro de una tarjeta con `onClick`, pasa solo `isSelected`: ni `onChanged` ni `defaultSelected`. Con `onChanged`, el check y la tarjeta alternan los dos y el clic se anula. Con `defaultSelected`, el check lleva su propio estado y se desincroniza de la tarjeta.

## Dart mapping

- Widget: `DotsCheckCircle` (`lib/src/components/buttons/dots_check_circle.dart`).
- `isSelected` → `isSelected`; `size` → `size` (default 24).
- Marcado: fondo `labelHighlight` + `DotsIcon(DotsIconData.check, 14, labelAlwaysWhite)` → `h(DotsIcon, { name: 'ic-check', size: 14 })`. Sin marcar: borde `labelSecondary` de 2 px.
- `defaultSelected`, `onChanged`, `disabled` y los `aria*` no existen en Dart (el widget es solo visual); son extensiones web.
