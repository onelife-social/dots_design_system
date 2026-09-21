import * as React from 'react';

/** Active option — Dart enum SegmentedControlOption */
export type DotsSegmentedControlOption = 'left' | 'right';
export type DotsSegmentedControlType = 'text' | 'icon' | 'single';
export type DotsSegmentedControlVariant = 'main' | 'camera';
export interface DotsSegmentedControlProps {
    /** Dart widget: 'text' → SegmentedControl, 'icon' → SegmentedControlIcon, 'single' → SegmentedControlSingle */
    type?: DotsSegmentedControlType;
    /** Only type 'text' — Dart enum SegmentedControlVariant */
    variant?: DotsSegmentedControlVariant;
    /** type 'text': left label — Dart `leftOptionName` */
    leftOptionName?: string;
    /** type 'text': right label — Dart `rightOptionName` */
    rightOptionName?: string;
    /** type 'text': badge over the right option — Dart `rightOptionTag` */
    rightOptionTag?: string;
    /** type 'icon': DotsIcon name ('ic-…') — Dart `leftOptionIcon` */
    leftOptionIcon?: string;
    /** type 'icon': DotsIcon name ('ic-…') — Dart `rightOptionIcon` */
    rightOptionIcon?: string;
    /** type 'icon': accessible name (aria-label) of the left icon button — web extension, localizable */
    leftOptionLabel?: string;
    /** type 'icon': accessible name (aria-label) of the right icon button — web extension, localizable */
    rightOptionLabel?: string;
    /** type 'single': button label — Dart `buttonName` */
    buttonName?: string;
    /** type 'single': badge — Dart `buttonTag` */
    buttonTag?: string;
    /** Active option (controlled) — Dart `selectedOption` */
    selectedOption?: DotsSegmentedControlOption;
    /** Initial option (uncontrolled) */
    defaultSelectedOption?: DotsSegmentedControlOption;
    /**
     * Called with the tapped option — Dart `onTapOption`. Types `text` and `icon` only: the `single`
     * type is purely visual (Dart `SegmentedControlSingle` has no tap handler) and never fires it.
     */
    onTapOption?: (option: DotsSegmentedControlOption) => void;
    /** type 'text'/'single': CSS color of the selected segment — Dart `selectedColor` */
    selectedColor?: string;
    /** type 'text'/'single': CSS background color — Dart `backgroundColor` */
    backgroundColor?: string;
}
export declare function DotsSegmentedControl(props: DotsSegmentedControlProps): import("react").JSX.Element;
