// DotsUploadItem — port of lib/src/components/upload_items/dots_upload_item.dart
// (+ upload_item_variant.dart → prop `variant`). Dart = source of truth.
import type { SyntheticEvent } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';
import { DotsMainButton } from '../DotsMainButton/DotsMainButton';
import { DotsProgressBar } from '../DotsProgressBar/DotsProgressBar';
import { DotsSquirclePhoto } from '../DotsSquirclePhoto/DotsSquirclePhoto';

/** Dart enum UploadItemVariant */
export type DotsUploadItemVariant = 'processing' | 'success' | 'error';

export interface DotsUploadItemProps {
  /** Image URL. Without `src` (or when it fails to load) a gradient placeholder is painted. */
  src?: string;
  alt?: string;
  /** Variant — Dart enum UploadItemVariant (falls back to 'processing') */
  variant: DotsUploadItemVariant;
  /** (processing) Progress 0..1 for the bar and the percentage. */
  percentage?: number;
  /** Date shown on top (bodyDefaultMedium). */
  textDate?: string;
  /** Status text next to the icon (labelDefaultRegular). */
  processText?: string;
  /** (success) Elapsed time under the status. */
  timeElapsed?: string;
  /** (success/error) Text of the right button (DotsMainButton medium). */
  btnText?: string;
  /** (success/error) Callback of the right button (Dart btnOnTap). */
  onBtnClick?: () => void;
  /** Image load error callback (Dart onError). */
  onError?: (event: SyntheticEvent<HTMLImageElement>) => void;
  className?: string;
}

// UploadItemVariant → icon + color (same switch as the Dart)
const VARIANTS: Record<DotsUploadItemVariant, { icon: string; color: string }> = {
  processing: { icon: 'ic-spinner', color: 'var(--text-secondary)' },
  success: { icon: 'ic-check-circle', color: 'var(--label-highlight)' },
  error: { icon: 'ic-cross-circle', color: 'var(--label-destructive)' },
};

export function DotsUploadItem(props: DotsUploadItemProps) {
  const variant: DotsUploadItemVariant = VARIANTS[props.variant] ? props.variant : 'processing';
  const v = VARIANTS[variant];
  const isProcessing = variant === 'processing';
  const isSuccess = variant === 'success';
  const isError = variant === 'error';
  const percentage = props.percentage == null ? null : Math.min(1, Math.max(0, props.percentage));

  return (
    <div className={`ds-upload-item${props.className ? ` ${props.className}` : ''}`}>
      {/* Image — DotsSquircleImage(size: 64, squircle16, uploadError: variant.isError) */}
      <DotsSquirclePhoto src={props.src} alt={props.alt} onError={props.onError} size={64} borderRadius={16} uploadError={isError} />
      <div className={`ds-upload-item__body${isProcessing ? ' ds-upload-item__body--processing' : ''}`}>
        <div className="ds-upload-item__date">{props.textDate ?? ''}</div>
        {/* Status row — icon 14 (spinning while processing) + processText */}
        <span className="ds-upload-item__process">
          <span className={`ds-upload-item__process-icon${isProcessing ? ' ds-upload-item__process-icon--spin' : ''}`}>
            <DotsIcon name={v.icon} size={14} color={v.color} />
          </span>
          <span className="ds-upload-item__process-text">{props.processText ?? ''}</span>
        </span>
        {/* Progress — DotsProgressBar(percentage, parts: 1) + '64%' */}
        {isProcessing ? (
          <span className="ds-upload-item__progress">
            <span className="ds-upload-item__progress-bar">
              {/* No percentage yet → empty bar (0), matching the empty percentage label */}
              <DotsProgressBar percentage={percentage ?? 0} parts={1} />
            </span>
            <span className="ds-upload-item__progress-pct">{percentage != null ? `${Math.round(percentage * 100)}%` : ''}</span>
          </span>
        ) : null}
        {isSuccess ? <div className="ds-upload-item__elapsed">{props.timeElapsed ?? ''}</div> : null}
      </div>
      {/* Right button — success: secondary · error: main (DotsMainButton medium) */}
      {!isProcessing ? (
        <DotsMainButton label={props.btnText ?? ''} variant={isSuccess ? 'secondary' : 'main'} size="medium" expand={false} onClick={props.onBtnClick} />
      ) : null}
    </div>
  );
}
