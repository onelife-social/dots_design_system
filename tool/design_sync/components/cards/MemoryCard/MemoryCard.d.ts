import * as React from 'react';

/** Dart enum MemoryCardVariant */
export type MemoryCardVariant = 'memory' | 'recap';
export interface MemoryCardProps {
    /** Photo URL (Dart image: Widget). Without it a gradient placeholder is painted */
    imageSrc?: string;
    /** Group name under the card */
    groupName: string;
    /** Border variant — Dart enum MemoryCardVariant (default 'memory') */
    variant?: MemoryCardVariant;
    /** Tap on the card (Dart onTap) */
    onClick?: () => void;
    className?: string;
}
export declare function MemoryCard(props: MemoryCardProps): import("react").JSX.Element;
