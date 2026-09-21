import * as React from 'react';

import { type ReactElement } from 'react';
import { type MilestoneCardProps } from '../../memories/MilestoneCard/MilestoneCard';
/**
 * string ⇒ BadgeMilestone ghost · object ⇒ MilestoneCard props · or an already built element.
 * A built element is laid out as a badge (17px) when its type is `BadgeMilestone` and as a card
 * (326px) otherwise. The list's fixed card width (244.5px, aspect 3:4) is authoritative: a
 * `MilestoneCardProps.width` is ignored so every card stays aligned on the path.
 */
export type MilestonesListItem = string | MilestoneCardProps | ReactElement;
export interface MilestonesListProps {
    /** Items in vertical order — Dart `list` (List<String | MilestoneCard>) */
    list: MilestonesListItem[];
    /** Seed of the path (20–34 gaps between cards and x-pattern alternation) — Dart `seed` (default 1) */
    seed?: number;
    /** Fixed width in px; when omitted the container is measured and observed (ResizeObserver; centerX = width/2) */
    width?: number;
    className?: string;
}
export declare function MilestonesList(props: MilestonesListProps): import("react").JSX.Element;
