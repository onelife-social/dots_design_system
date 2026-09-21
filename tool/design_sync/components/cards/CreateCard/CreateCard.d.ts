import * as React from 'react';

/** Dart enum CreateCardVariant */
export type CreateCardVariant = 'label' | 'button';
export interface CreateCardProps {
    /** Card title */
    title: string;
    /** DotsIcon 32 (label variant), e.g. 'ic-pic' */
    icon?: string;
    /** Start color of the horizontal gradient (label variant). Without it falls back to the brand green gradient */
    primaryColor?: string;
    /** End color of the gradient; default = primaryColor */
    secondaryColor?: string;
    /** Width in px (Dart width; the height is fixed at 112). Default 164 */
    width?: number;
    /** Variant — Dart enum CreateCardVariant (default 'label') */
    variant?: CreateCardVariant;
    /** Tap on the card (Dart onTap) */
    onClick?: () => void;
    className?: string;
}
export declare function CreateCard(props: CreateCardProps): import("react").JSX.Element;
