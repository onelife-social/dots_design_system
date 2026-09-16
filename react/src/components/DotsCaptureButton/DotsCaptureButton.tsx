// DotsCaptureButton — port of lib/src/components/buttons/capture_button/ (Dart = source of truth).
import { useEffect, useRef, useState, type ReactNode } from 'react';

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

const DIAMETER = 80; // _kCaptureButtonDiameter
const INNER = 68; // _kCaptureButtonInnerDiameter
const INNER_RECORDING = 60; // _kCaptureButtonInnerDiameterRecording (photo + recording)
const STROKE = 6; // _kCaptureButtonRingStroke
const RADIUS = (DIAMETER - STROKE) / 2; // 37 — arc inset by stroke/2, like the CustomPainter
const CIRC = 2 * Math.PI * RADIUS;

export function DotsCaptureButton(props: DotsCaptureButtonProps) {
  const type: DotsCaptureButtonType = props.type === 'video' ? 'video' : 'photo';
  const controlled = props.state !== undefined && props.state !== null;
  const [internalRecording, setInternalRecording] = useState(false);
  const recording = controlled ? props.state === 'recording' : internalRecording;
  const [progress, setProgress] = useState(0);
  const maxTime = props.maxTimeRecording && props.maxTimeRecording > 0 ? props.maxTimeRecording : 60; // Dart: default 60
  const stopCbRef = useRef<(() => void) | undefined>(undefined);
  stopCbRef.current = props.onStopRecording;
  const animating = type === 'video' && recording;

  // Progress timer (Timer.periodic 50 ms in Dart); on reaching 1 → onStopRecording
  useEffect(() => {
    if (!animating) {
      setProgress(0);
      return undefined;
    }
    const start = Date.now();
    const id = setInterval(() => {
      const raw = Math.min((Date.now() - start) / (maxTime * 1000), 1);
      setProgress(raw);
      if (raw >= 1) {
        clearInterval(id);
        setInternalRecording(false);
        stopCbRef.current?.();
      }
    }, 50);
    return () => {
      clearInterval(id);
    };
  }, [animating, maxTime]);

  function handleClick() {
    if (type === 'photo') {
      props.onTakePicture?.();
      return;
    }
    if (recording) {
      if (!controlled) setInternalRecording(false);
      props.onStopRecording?.();
    } else {
      if (!controlled) setInternalRecording(true);
      props.onStartRecording?.();
    }
  }

  let children: ReactNode;
  if (type === 'photo' || !recording) {
    // _ActiveButton — inner Ø68 (photo·recording: Ø60); photo white, video labelDestructive
    const inner = type === 'photo' && recording ? INNER_RECORDING : INNER;
    children = <span className={`ds-capture__inner ds-capture__inner--${type}`} style={{ width: `${inner}px`, height: `${inner}px` }} />;
  } else {
    // _RecordingButton — white progress arc (round cap) + stop 32 r8 destructive
    children = (
      <>
        <svg className="ds-capture__ring" viewBox="0 0 80 80" aria-hidden>
          <circle
            cx={40}
            cy={40}
            r={RADIUS}
            fill="none"
            stroke="var(--label-always-white)"
            strokeWidth={STROKE}
            strokeLinecap="round"
            strokeDasharray={`${progress * CIRC} ${CIRC}`}
          />
        </svg>
        <span className="ds-capture__stop" />
      </>
    );
  }

  return (
    <button
      type="button"
      className="ds-capture"
      aria-label={type === 'photo' ? 'Tomar foto' : recording ? 'Detener grabación' : 'Grabar vídeo'}
      onClick={handleClick}
    >
      {children}
    </button>
  );
}
