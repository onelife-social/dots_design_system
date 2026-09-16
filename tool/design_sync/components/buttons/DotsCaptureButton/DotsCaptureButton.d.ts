import * as React from 'react';

/** Dart enum DotsCaptureButtonType */
export type DotsCaptureButtonType = 'photo' | 'video';
/** Dart enum DotsCaptureButtonState */
export type DotsCaptureButtonState = 'active' | 'recording';
export interface DotsCaptureButtonProps {
    /** Capture type — Dart enum DotsCaptureButtonType (default 'photo') */
    type: DotsCaptureButtonType;
    /**
     * State — Dart enum DotsCaptureButtonState. When given the component is
     * controlled; when omitted it manages the recording state itself on click.
     */
    state?: DotsCaptureButtonState;
    /** Max recording seconds (ring progress; video only) — Dart `maxTimeRecording` (default 60) */
    maxTimeRecording?: number;
    /** Photo shot (photo only) — Dart `onTakePicture` */
    onTakePicture?: () => void;
    /** Recording start (video only) — Dart `onStartRecording` */
    onStartRecording?: () => void;
    /** Recording end (click or max time) — Dart `onStopRecording` */
    onStopRecording?: () => void;
}
export declare function DotsCaptureButton(props: DotsCaptureButtonProps): import("react").JSX.Element;
