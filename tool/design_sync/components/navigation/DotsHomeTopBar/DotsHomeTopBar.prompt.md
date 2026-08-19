DotsHomeTopBar from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsHomeTopBar` (bundle loaded from the root `_ds_bundle.js`). Home screen top bar (106px = 50 status + 56 content): profile avatar left, small centered title (labelDefaultBold, textTertiary) and up to two right icons — in the real home `DotsIconButton` with `ic-heart` and `ic-chat`; variants onlyStatusBar / title / widget plus blur or gradient background.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `variant` | `'onlyStatusBar' \| 'title' \| 'widget'` | auto | Constructor Dart. Auto: `title`→title, `child`→widget, si no onlyStatusBar. |
| `title` | `string` | — | Título centrado (labelDefaultBold 13/600, textTertiary). |
| `onTitleClick` | `() => void` | — | Tap en el título — Dart `DotsHomeTopBarMainSection.onTitleTap`. |
| `child` | `ReactNode` | — | Contenido central custom (variant widget). |
| `imgProfile` | `ReactNode` | — | Avatar izquierdo, ml 16 (en el home DotsProfilePhoto 32×32). |
| `rightIcon` | `ReactNode` | — | Primer icono derecho. En el home: `<DotsIconButton icon="ic-heart" size="large" variant="noBackground" tag="2" color="var(--text-tertiary)" />`. |
| `secondRightIcon` | `ReactNode` | — | Segundo icono derecho (home: `ic-chat`); este slot lleva el margen final de 16px. |
| `backgroundBlur` | `boolean` | `false` | Fondo `bgContainerPrimary` + blur 50 (para flotar sobre fotos/scroll). |
| `showGradient` | `boolean` | `false` | Fondo con máscara a transparente hacia abajo + blur 18 (ShaderMask Dart). |
| `children` | `ReactNode` | — | Widgets extra bajo el contenido (Dart `children`), p.ej. un `FolderCarrousel`. |
| `className` | `string` | — | Clases extra sobre `.ds-home-top-bar`. |

## Examples

```jsx
const { DotsHomeTopBar, DotsIconButton, FolderCarrousel } = window.DotsDesignSystem_9e41da;

// Barra del home real: avatar + corazón y chat con badges
<DotsHomeTopBar
  title="Dots. Memories"
  imgProfile={<img className="avatar32" src={user.photo} />}
  rightIcon={<DotsIconButton icon="ic-heart" size="large" variant="noBackground" tag="2" color="var(--text-tertiary)" />}
  secondRightIcon={<DotsIconButton icon="ic-chat" size="large" variant="noBackground" tag="5" color="var(--text-tertiary)" />}
/>

// Flotando sobre contenido con blur, con carrusel de carpetas debajo
<DotsHomeTopBar title="Hoy, 18 de agosto" backgroundBlur>
  <FolderCarrousel items={folders} />
</DotsHomeTopBar>
```

## Dart mapping

| Web | Dart (`lib/src/components/navigation/home_top_bar.dart` + `home_top_bar_main_section.dart`) |
| --- | --- |
| `DotsHomeTopBar` | `DotsHomeTopBar` (StatelessWidget, PreferredSizeWidget) |
| `variant` | Constructores `.onlyStatusBar` / `.title` / `.widget` |
| Sección central + fila | `DotsHomeTopBarMainSection` (centro absoluto; fila imgProfile / rightIcon / secondRightIcon) |
| `onTitleClick` | `DotsHomeTopBarMainSection.onTitleTap` (no expuesto por el wrapper Dart; aquí sí) |
| `backgroundBlur` | `BackdropFilter(blur 50)` + `bgContainerPrimary` |
| `showGradient` | `ShaderMask(bgContainerPrimary→transparent, dstIn)` + `BackdropFilter(blur 18)` |
| `children` | `children` (columna bajo `TopBarContent`) |
| Alturas | `kTopBarNormalHeight = 50` / `kTopBarBigHeight = 106` |
