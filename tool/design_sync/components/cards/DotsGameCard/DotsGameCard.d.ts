import * as React from 'react';

import type { ReactNode } from 'react';
/** Dart enum DotsGameCardStatus — provisioning state of the game the card represents */
export type DotsGameCardStatus = 'processing' | 'error' | 'active';
export interface DotsGameCardProps {
    /** Which of the three variants to render — Dart enum DotsGameCardStatus. Picks the badge variant and the action block */
    status: DotsGameCardStatus;
    /** Game artwork URL, drawn inside a 138×100 box without cropping (BoxFit.contain). Without it, or if it fails to load, a gradient placeholder is painted */
    imageSrc?: string;
    /** Own node instead of `imageSrc` — mirror of the Dart `image` slot (Widget). Takes precedence when truthy */
    image?: ReactNode;
    /** Alt text of the `imageSrc` image (default '': decorative, the title names the game) */
    imageAlt?: string;
    /** Badge copy — `PREPARANDO` / `NO DISPONIBLE` / `ACTIVO`. The variant is chosen by `status` — Dart `badgeText` */
    badgeText: string;
    /** Mackinac 23/500, centered — Dart `title` */
    title: string;
    /** Inter 14/400 textTertiary, centered — Dart `description` */
    description: string;
    /** Button copy, or the progress label while `status` is 'processing' — Dart `actionText` */
    actionText: string;
    /** Dart `onActionTap`. IGNORED while `status` is 'processing': that variant reports progress and takes no tap */
    onActionClick?: () => void;
    /**
     * Leading indicator of the 'processing' row — Dart `progressIndicator`. The package ships no
     * indeterminate spinner (DotsSpinner is determinate), so the host passes its own. Omitted → a 16px
     * ring is painted as design placeholder; `null` → no indicator at all.
     */
    progressIndicator?: ReactNode;
    className?: string;
}
export declare function DotsGameCard(props: DotsGameCardProps): import("react").JSX.Element;
