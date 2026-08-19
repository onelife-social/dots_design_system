MilestoneCard from dots_design_system. Use via `window.DotsDesignSystem_9e41da.MilestoneCard` (bundle loaded from the root `_ds_bundle.js`). 3:4 milestone photo card — big (width > 150, r32) or small (r24) — with 3px white border, gradient-blur title area, optional milestone badge, edit button and up to 3 content badges (video / description / audio).

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `width` | `number` | — (requerido) | Ancho px. `> 150` ⇒ big (squircle 32); si no small (squircle 24). Aspect 3:4. |
| `src` | `string` (URL) | — | Foto de fondo (cover). Sin `src` se pinta un placeholder degradado (rol de `defaultImage`). |
| `title` | `string` | — | Título centrado (bodyLargeMedium, labelAlwaysWhite) sobre blur degradado de 108px (sigma 15 + tinte negro 35%). |
| `date` | `string` | — | Fecha bajo el título (bodyDefaultRegular, labelAlwaysWhite). |
| `limitTitle` | `boolean` | `false` | Título a 1 línea con ellipsis. |
| `onClick` | `() => void` | — | Dart `onTap`. |
| `showBadge` | `boolean` | `false` | Badge real `badge-milestone-1.svg` (data URI, 45×45) arriba a la derecha (top 5, right 5). |
| `showEdit` | `boolean` | `false` | Botón editar: `DotsIconButton` `ic-pencil` sobre `bgBtnImage`, abajo a la derecha (16,16). |
| `onClickEdit` | `() => void` | — | Dart `onTapEdit` (no propaga al onClick de la tarjeta). |
| `badgeTypes` | `('video' \| 'description' \| 'audio')[]` | `[]` | Grupo BadgeIconGroup 63×70 abajo-izquierda (16,16): círculos blancos con icono coloreado — video `ic-video` #4FAEF8 (child010), audio `ic-mic` #F43C51 (couple001), description `ic-pages` #F7954A (friends005). Máx. 3. |
| `onBadgesClick` | `() => void` | — | Dart `onBadgesTap`. |
| `isSelected` | `boolean` | `false` | Solo añade la clase `is-selected` (en Flutter posiciona el scroll de MilestonesList). |
| `className` | `string` | — | Clases extra sobre `.ds-milestone-card`. |

## Examples

```jsx
const { MilestoneCard } = window.DotsDesignSystem_9e41da;

// Tarjeta grande completa
<MilestoneCard
  width={170}
  src="https://…/foto.webp"
  title="Primeros pasos"
  date="12 mar 2026"
  showBadge
  showEdit
  onClickEdit={editar}
  badgeTypes={['video', 'description', 'audio']}
  onBadgesClick={verContenido}
/>

// Miniatura sin título
<MilestoneCard width={120} src="https://…/foto.webp" onClick={abrir} />
```

## Dart mapping

| Web | Dart (`lib/src/components/milestones/milestone_card.dart`) |
| --- | --- |
| `MilestoneCard` | `MilestoneCard` |
| `src` / placeholder sin src | `imageProvider` / `defaultImage` (loadingBuilder) |
| `onClick` / `onClickEdit` / `onBadgesClick` | `onTap` / `onTapEdit` / `onBadgesTap` |
| blur superior (108px, negro 35%) | `_CardWithBlur` → `DotsLinearGradientBlur(sigma 15)` |
| badge 45×45 top/right 5 | `_CardBadge` → `badge-milestone-1.svg.vec` |
| grupo badges 63×70 | `_MilestoneBadges` → `BadgeIconGroup` + `BadgeIcon` (medium 36/20, small 28/16) |
| `badgeTypes` valores | enum `MilestoneBadgeType` (milestone_badge_type.dart) — colores child010/couple001/friends005 sin token CSS (hex documentado) |
| Omitidos | `errorBuilder`, `VisibilityDetector`/`forceWithoutBlur` (optimización móvil) |
