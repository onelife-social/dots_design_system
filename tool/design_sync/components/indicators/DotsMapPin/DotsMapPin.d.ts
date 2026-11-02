import * as React from 'react';

import { type CSSProperties } from 'react';
export interface DotsMapPinProps {
    /** Accessible name (e.g. the venue's name) — Dart `semanticsLabel`. Without it the marker is decorative */
    ariaLabel?: string;
    /** Extra CSS class */
    className?: string;
    /** Inline style (e.g. `transform: translateY(3.46px)` to put the tip on a bottom-centre anchor) */
    style?: CSSProperties;
}
/** Box of the marker — Dart `DotsMapPin.size` */
export declare const dotsMapPinSize: {
    readonly width: 46;
    readonly height: 55;
};
/** Where the marker points, from the top-left of its box: centred, 3.46 px above the bottom edge — Dart `DotsMapPin.anchor` */
export declare const dotsMapPinAnchor: {
    readonly x: 23;
    readonly y: 51.5421;
};
export declare function DotsMapPin(props: DotsMapPinProps): import("react").JSX.Element;
export declare namespace DotsMapPin {
    var size: {
        readonly width: 46;
        readonly height: 55;
    };
    var anchor: {
        readonly x: 23;
        readonly y: 51.5421;
    };
}
