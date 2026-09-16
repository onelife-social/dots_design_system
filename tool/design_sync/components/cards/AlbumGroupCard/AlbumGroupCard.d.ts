import * as React from 'react';

/** Dart enum AlbumGroupCardVariant */
export type AlbumGroupCardVariant = 'small' | 'large';
export interface AlbumGroupCardProps {
    /** Background photo URL (Dart imageProvider). Without it a gradient placeholder is painted */
    imageSrc?: string;
    /** Title centered at the bottom (required in Dart) */
    title: string;
    /** Variant — Dart enum AlbumGroupCardVariant (default 'small') */
    variant?: AlbumGroupCardVariant;
    /** Icon of the top-left CardTag (Dart tagIconData), e.g. 'ic-prime-1' */
    tagIcon?: string;
    /** Blocked group: centered lock and no tag */
    isBlocked?: boolean;
    /** Height of the bottom fade (Dart edgeSize; default 60 small / 110 large) */
    edgeSize?: number;
    /** Blur sigma (Dart blurSigma) — approximated in CSS, no direct effect */
    blurSigma?: number;
    /** Side in px (the card is 1:1; Dart clamps 135–160 small / 288–340 large). Default 148 / 288 */
    size?: number;
    /** Tap on the card (Dart onTap) */
    onClick?: () => void;
    className?: string;
}
export declare function AlbumGroupCard(props: AlbumGroupCardProps): import("react").JSX.Element;
