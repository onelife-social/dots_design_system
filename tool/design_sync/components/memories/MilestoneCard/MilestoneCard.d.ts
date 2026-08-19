import * as React from 'react';

/**
 * MilestoneCard — port web de MilestoneCard (Flutter). Tarjeta de hito 3:4 con
 * foto, borde blanco de 3px, título sobre blur degradado, badge de hito,
 * botón de editar y grupo de badges de contenido (vídeo / audio / descripción).
 */

/** Espejo del enum Dart MilestoneBadgeType */
export type MilestoneBadgeType = 'video' | 'description' | 'audio';

export interface MilestoneCardProps {
  /** Ancho en px — Dart `width`. > 150 ⇒ big (r32); si no small (r24). Alto = 4/3 del ancho */
  width: number;
  /** URL de la foto — Dart `imageProvider`. Sin src pinta el placeholder (defaultImage) */
  src?: string;
  /** Título centrado sobre el blur superior — Dart `title` */
  title?: string;
  /** Limita el título a 1 línea con ellipsis — Dart `limitTitle`. Default: false */
  limitTitle?: boolean;
  /** Fecha bajo el título — Dart `date` */
  date?: string;
  /** Dart `onTap` (tap en la foto/tarjeta) */
  onClick?: () => void;
  /** Muestra el badge badge-milestone-1.svg arriba a la derecha — Dart `showBadge`. Default: false */
  showBadge?: boolean;
  /** Muestra el botón de editar (DotsIconButton pencil) — Dart `showEdit`. Default: false */
  showEdit?: boolean;
  /** Dart `onTapEdit` */
  onClickEdit?: () => void;
  /** Marca de selección (en Flutter se usa para el auto-scroll de la lista) */
  isSelected?: boolean;
  /** Badges de contenido, máx. 3 — Dart `badgeTypes`. Default: [] */
  badgeTypes?: MilestoneBadgeType[];
  /** Dart `onBadgesTap` */
  onBadgesClick?: () => void;
  className?: string;
}

export declare const MilestoneCard: React.ComponentType<MilestoneCardProps> & {
  /** Catálogo icon+color por tipo (espejo de MilestoneBadgeType) */
  badgeTypes: Record<MilestoneBadgeType, { icon: string; color: string }>;
};
