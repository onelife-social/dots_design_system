FolderCarrousel from dots_design_system. Use via `window.DotsDesignSystem_9e41da.FolderCarrousel` (bundle loaded from the root `_ds_bundle.js`). Horizontally scrollable row of BtnFolder pills (home folder filter: e.g. Buscar / Todos / Familia…), with selected state, optional edit badges and extra custom nodes.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `items` | `FolderCarrouselItem[]` | `[]` | Carpetas; cada una se renderiza como `BtnFolder` — Dart `buttonsData` (`BtnFolderData`). |
| `items[].icon` | `string` | — | Nombre real del icono DS (`DotsIcon`), p.ej. `'ic-family'`. |
| `items[].text` | `string` | — | Texto de la píldora (truncado a 20 chars por BtnFolder). |
| `items[].onClick` | `() => void` | — | Tap del item — Dart `onTap`. Si falta se usa `onSelect(i)`. |
| `items[].onLongPress` | `() => void` | — | Long-press — Dart `onPressed`. |
| `items[].isSelected` | `boolean` | `false` | Píldora seleccionada (bgStrong + sombra, icono en `iconSelectedColor`). |
| `items[].iconSelectedColor` | `string` (CSS) | `'#3E9ACB'` | Color del icono al seleccionar (requerido en Dart; default = azul del home). |
| `items[].isNonExpandable` | `boolean` | `false` | Solo icono 44×44 (p.ej. botón `+`). |
| `items[].isEditable` | `boolean` | `false` | Muestra badge lápiz cuando `showEditIcon`. |
| `showEditIcon` | `boolean` | `false` | Activa los badges de edición — Dart `showEditIcon` (required). |
| `onSelect` | `(index: number) => void` | — | Conveniencia web: click en el item `i` sin `onClick` propio. |
| `children` | `ReactNode` | — | Nodos extra al final de la fila — Dart `customWidgets` (`DefaultFolderWidget`). |
| `className` | `string` | — | Clases extra sobre `.ds-folder-carrousel`. |

Fila con padding lateral 16 y scroll horizontal sin barra; el espaciado entre píldoras (4px por lado) lo pone el propio `BtnFolder`.

## Examples

```jsx
const { FolderCarrousel, BtnFolder } = window.DotsDesignSystem_9e41da;

// Fila del home: Todos seleccionado, carpetas editables
<FolderCarrousel
  items={[
    { icon: 'ic-search', text: 'Buscar' },
    { icon: 'ic-grid', text: 'Todos', isSelected: true },
    { icon: 'ic-family', text: 'Familia', isEditable: true },
    { icon: 'ic-baby-stroller', text: 'Bebé', isEditable: true },
    { icon: 'ic-edit', text: 'Editar' },
  ]}
  showEditIcon={false}
  onSelect={(i) => setFolder(i)}
/>

// Con un botón extra no expandible al final
<FolderCarrousel items={folders}>
  <BtnFolder icon="ic-add" isNonExpandable iconSelectedColor="#3E9ACB" onClick={addFolder} />
</FolderCarrousel>
```

## Dart mapping

| Web | Dart (`lib/src/components/carrousels/folder_carrousel.dart`) |
| --- | --- |
| `FolderCarrousel` | `FolderCarrousel` (StatelessWidget) |
| `items` | `buttonsData: List<BtnFolderData>` (`icon`/`text`/`onTap`/`onPressed`/`isSelected`/`iconSelectedColor`/`isEditable`) |
| `showEditIcon` | `showEditIcon` (required en Dart) |
| `children` | `customWidgets: List<DefaultFolderWidget>` (aquí siempre al final; Dart permite índice) |
| `onSelect` | — (conveniencia web; en Dart cada `BtnFolderData` lleva su `onTap`) |
| Contenedor | `SingleChildScrollView(horizontal, padding H16)` + `Row` |
