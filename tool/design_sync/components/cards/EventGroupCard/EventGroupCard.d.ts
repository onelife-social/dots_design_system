import * as React from 'react';

export interface EventGroupCardAction {
    /** DotsIcon name, e.g. 'ic-camera' */
    icon: string;
    /** Text under the icon */
    text: string;
    onClick?: () => void;
}
export type EventGroupCardVariant = 'small' | 'active' | 'passed';
export interface EventGroupCardProps {
    /** Variant — Dart enum EventGroupCardVariant */
    variant?: EventGroupCardVariant;
    /** Background photo URL (Dart imageProvider). Without it a gradient placeholder is painted */
    imageSrc?: string;
    /** Title (small: bottom · active/passed: top) */
    title?: string;
    /** Secondary text (active: "· N participantes" · passed: label of the secondary button) */
    secondaryText?: string;
    /** Icon of the top-left CardTag (Dart tagIconData), e.g. 'ic-prime-1' */
    tagIcon?: string;
    /** Bottom blurred menu actions (active/passed only) — Dart GroupEventCardModel */
    actions?: EventGroupCardAction[];
    /** Blocked group: centered lock and no tag */
    isBlocked?: boolean;
    /** Height of the bottom fade (Dart edgeSize; default 60 small / 110 others) */
    edgeSize?: number;
    /** Side in px (the card is 1:1; Dart clamps 135–160 small / 288–340 others). Default 148 / 288 */
    size?: number;
    /** Tap on the card (Dart onTap) */
    onClick?: () => void;
    /** Tap on the secondary text/button (Dart onSecondaryTap) */
    onSecondaryClick?: () => void;
    className?: string;
}
export declare function EventGroupCard(props: EventGroupCardProps): import("react").JSX.Element;
