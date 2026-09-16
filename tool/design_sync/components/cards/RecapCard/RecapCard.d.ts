import * as React from 'react';

/** Dart enum RecapCardVariant (onlyTitle = active without title/badge/button) */
export type RecapCardVariant = 'active' | 'blocked' | 'generated' | 'onlyTitle';
/** Dart enum RecapCardLockedVariant */
export type RecapCardLockedVariant = 'countdown' | 'locked' | 'soon';
export interface RecapCardProps {
    /** true → renders RecapCardLocked (7:8, countdown); false/omitted → RecapCard (4:5) */
    locked?: boolean;
    /** Variant without locked — Dart enum RecapCardVariant (default 'active') */
    variant?: RecapCardVariant;
    /** Variant with locked — Dart enum RecapCardLockedVariant (default 'countdown') */
    lockedVariant?: RecapCardLockedVariant;
    /** Width in px (Dart width; required in Dart). Default 220 */
    width?: number;
    /** Background photo URL (Dart imageProvider). Without it a gradient placeholder is painted */
    imageSrc?: string;
    /** URL of the overlaid text image (Dart textImageProvider, only without locked) */
    textImageSrc?: string;
    /** Title (without locked: top row with ic-clock--timer · locked: countdown title) */
    title?: string;
    /** Text of the premium large BadgeLabel (without locked, not in blocked) */
    badgeText?: string;
    /** Label of the bottom DotsMainButton (active/blocked; locked: locked variant) */
    buttonText?: string;
    /** Album name (generated variant) */
    albumName?: string;
    /** Author (generated variant), e.g. "Creado por Ana" */
    createdBy?: string;
    /** Countdown description when there is no countdown running (locked/soon or countdown finished) */
    description?: string;
    /** Unlock date (ISO/Date) — live countdown (lockedVariant countdown) */
    countdownDate?: string | number | Date;
    /** Countdown labels */
    daysLabel?: string;
    hoursLabel?: string;
    minutesLabel?: string;
    secondsLabel?: string;
    /** Blur the background image (Dart blurImageProvider, locked only; blocked always blurs it) */
    blurImage?: boolean;
    /** Tap on the card / main button without locked (Dart onTap) */
    onClick?: () => void;
    /**
     * Accessible name of the card action (`onClick`, without locked). Defaults to `title`; set it
     * when the card has no title to read (onlyTitle variant, or no `title`)
     */
    ariaLabel?: string;
    /** Tap on the info/share/lock button (Dart onInfoTap) */
    onInfoClick?: () => void;
    /** Tap on the bottom button with locked (Dart onButtonTap) */
    onButtonClick?: () => void;
    className?: string;
}
export declare function RecapCard(props: RecapCardProps): import("react").JSX.Element;
