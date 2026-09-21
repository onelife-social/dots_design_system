// DotsTopBar — port of lib/src/components/navigation/top_bar.dart (Dart = source of truth).
// Variants mirror the Dart constructors: onlyStatusBar / title / widget / cta.
import type { ReactNode } from 'react';
import { DotsIconButton } from '../DotsIconButton/DotsIconButton';
import { DotsMainButton } from '../DotsMainButton/DotsMainButton';
import { DotsProfilePhoto } from '../DotsProfilePhoto/DotsProfilePhoto';

export type DotsTopBarVariant = 'onlyStatusBar' | 'title' | 'widget' | 'cta';

export interface DotsTopBarProps {
  /** Dart constructor; inferred from the props when omitted */
  variant?: DotsTopBarVariant;
  /** Centered title — titleH6 (Dart `title`) */
  title?: string;
  /** Under the title — labelSmallRegular (Dart `subtitle`) */
  subtitle?: string;
  /** 20×20 DotsProfilePhoto before the title — Dart `imageTitle` */
  imageTitle?: string;
  /** Center content of the `widget` variant — Dart `child` */
  children?: ReactNode;
  /** Leading widget when there is no back button — Dart `leftIcon` */
  leftIcon?: ReactNode;
  /** Trailing widget (a DotsIconButton in Dart) — Dart `rightIcon` */
  rightIcon?: ReactNode;
  /** Shows the back button (DotsIconButton chevronLeft medium) — Dart `onTapBack` */
  onBack?: () => void;
  /** Transparent instead of bgContainerPrimary — Dart `hideBackground` */
  hideBackground?: boolean;
  /** Reserve the 50px status-bar strip above the content (default true) — Dart `bigStatusBar` */
  bigStatusBar?: boolean;
  /** Back button `solid` instead of `noBackground` — Dart `showCircleBackButton` */
  showCircleBackButton?: boolean;
  /** Explicit background color — Dart `color` */
  color?: string;
  /** 1px black @20% bottom border — Dart `showBottomBorder` */
  showBottomBorder?: boolean;
  /** `cta` variant: DotsMainButton main/small at the trailing edge — Dart `ctaLabel` */
  ctaLabel?: string;
  /** Dart `onCtaTap` */
  onCtaClick?: () => void;
  /** Dart `ctaEnabled` */
  ctaEnabled?: boolean;
  className?: string;
}

export function DotsTopBar(props: DotsTopBarProps) {
  const variant: DotsTopBarVariant =
    props.variant ??
    (props.children != null ? 'widget' : props.ctaLabel != null ? 'cta' : props.title != null || props.imageTitle != null ? 'title' : 'onlyStatusBar');
  const hideWidgets = variant === 'onlyStatusBar'; // Dart `_hideWidgets`
  const bigStatusBar = hideWidgets ? false : props.bigStatusBar !== false;

  const style: Record<string, string> = {};
  // Dart: color ?? (hideBackground ? transparent : bgContainerPrimary) — the default lives in CSS
  if (props.color) style.background = props.color;
  else if (props.hideBackground) style.background = 'transparent';

  const center =
    variant === 'widget' ? (
      props.children
    ) : (
      <span className="ds-top-bar__title-wrap">
        <span className="ds-top-bar__title">
          {props.imageTitle ? <DotsProfilePhoto src={props.imageTitle} width={20} height={20} /> : null}
          {props.title ?? ''}
        </span>
        {props.subtitle != null ? <span className="ds-top-bar__subtitle">{props.subtitle}</span> : null}
      </span>
    );

  return (
    <div
      className={`ds-top-bar ds-top-bar--${bigStatusBar ? 'big' : 'normal'}${props.showBottomBorder ? ' ds-top-bar--bordered' : ''}${props.className ? ` ${props.className}` : ''}`}
      style={style}
    >
      {/* Dart: SizedBox(50) painted when _hideWidgets != bigStatusBar */}
      {hideWidgets !== bigStatusBar ? <span className="ds-top-bar__status" aria-hidden="true" /> : null}
      {!hideWidgets ? (
        <div className="ds-top-bar__content">
          <div className="ds-top-bar__center">{center}</div>
          <div className="ds-top-bar__row">
            {props.onBack ? (
              <span className="ds-top-bar__slot ds-top-bar__slot--left">
                <DotsIconButton icon="ic-chevron-left" size="medium" variant={props.showCircleBackButton ? 'solid' : 'noBackground'} onClick={props.onBack} />
              </span>
            ) : null}
            {props.leftIcon && !props.onBack ? <span className="ds-top-bar__slot ds-top-bar__slot--left">{props.leftIcon}</span> : null}
            <span className="ds-top-bar__spacer" />
            {props.rightIcon ? <span className="ds-top-bar__slot ds-top-bar__slot--right">{props.rightIcon}</span> : null}
            {props.ctaLabel != null ? (
              <span className="ds-top-bar__slot ds-top-bar__slot--right">
                <DotsMainButton label={props.ctaLabel} variant="main" size="small" expand={false} enabled={props.ctaEnabled !== false} onClick={props.onCtaClick} />
              </span>
            ) : null}
          </div>
        </div>
      ) : null}
    </div>
  );
}
