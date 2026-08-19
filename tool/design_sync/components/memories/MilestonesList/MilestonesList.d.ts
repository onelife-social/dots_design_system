import * as React from 'react';
import type { MilestoneCardProps } from '../MilestoneCard/MilestoneCard';

/**
 * MilestonesList — port web de MilestonesList (Flutter). Timeline vertical de
 * hitos: línea bezier punteada que serpentea por patrones x pseudoaleatorios y
 * une badges de edad (strings) con MilestoneCards, todos centrados en su punto.
 */

/** string ⇒ BadgeMilestone ghost · objeto ⇒ props de MilestoneCard · o un elemento ya construido */
export type MilestonesListItem = string | MilestoneCardProps | React.ReactElement;

export interface MilestonesListProps {
  /** Items en orden vertical — Dart `list` (List<String | MilestoneCard>) */
  list: MilestonesListItem[];
  /** Semilla del trazado (gaps 20–34 entre cards y alternancia de patrones x) — Dart `seed`. Default: 1 */
  seed?: number;
  /** Ancho fijo en px; si se omite se mide el contenedor (centerX = ancho/2) */
  width?: number;
  className?: string;
}

export declare const MilestonesList: React.ComponentType<MilestonesListProps>;
