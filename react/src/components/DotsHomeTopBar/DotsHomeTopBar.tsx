// DotsHomeTopBar — port of lib/src/components/navigation/home_top_bar.dart
// + home_top_bar_main_section.dart (Dart = source of truth).
import type { ReactNode } from 'react';

/** Dart constructors: onlyStatusBar / title / widget */
export type DotsHomeTopBarVariant = 'onlyStatusBar' | 'title' | 'widget';

export interface DotsHomeTopBarProps {
  /** Dart constructor; inferred when omitted: title→title, child→widget, else onlyStatusBar */
  variant?: DotsHomeTopBarVariant;
  /** Centered title — labelDefaultBold 13/600 textTertiary */
  title?: string;
  /** Tap on the title — Dart `DotsHomeTopBarMainSection.onTitleTap` */
  onTitleClick?: () => void;
  /** Custom center content (variant widget) — Dart `child` */
  child?: ReactNode;
  /** Left avatar (DotsProfilePhoto 32 in the home) — Dart `imgProfile` */
  imgProfile?: ReactNode;
  /** First right icon (DotsIconButton ic-heart, large, noBackground, tag in the home) */
  rightIcon?: ReactNode;
  /** Second right icon (DotsIconButton ic-chat in the home) — carries the trailing 16px margin */
  secondRightIcon?: ReactNode;
  /** Blur 50 + bgContainerPrimary background — Dart `backgroundBlur` */
  backgroundBlur?: boolean;
  /** Background fading to transparent (ShaderMask + blur 18) — Dart `showGradient` */
  showGradient?: boolean;
  /** Extra widgets below the content — Dart `children` */
  children?: ReactNode;
  className?: string;
}

const NORMAL_H = 50; // kTopBarNormalHeight (lib/src/core/constants.dart)
const BIG_H = 106; // kTopBarBigHeight

export function DotsHomeTopBar(props: DotsHomeTopBarProps) {
  // Mirror of the Dart constructors: onlyStatusBar / title / widget
  const variant: DotsHomeTopBarVariant = props.variant ?? (props.title != null ? 'title' : props.child != null ? 'widget' : 'onlyStatusBar');
  const big = variant !== 'onlyStatusBar'; // _bigStatusBar

  // Background layer: showGradient > backgroundBlur > transparent
  const bgCls = props.showGradient ? ' ds-home-top-bar__bg--gradient' : props.backgroundBlur ? ' ds-home-top-bar__bg--blur' : '';

  // Center — child ?? title (labelDefaultBold, textTertiary, tappable)
  let center: ReactNode = null;
  if (props.child != null) {
    center = props.child;
  } else if (variant === 'title' && props.title != null) {
    center = (
      <button type="button" className="ds-home-top-bar__title" onClick={props.onTitleClick} style={props.onTitleClick ? undefined : { cursor: 'default' }}>
        {props.title}
      </button>
    );
  }

  // DotsHomeTopBarMainSection — center + row imgProfile / rightIcon / secondRightIcon
  const main = big ? (
    <div className="ds-home-top-bar__main">
      <div className="ds-home-top-bar__center">{center}</div>
      <div className="ds-home-top-bar__row">
        {props.imgProfile ? <span className="ds-home-top-bar__profile">{props.imgProfile}</span> : null}
        <span className="ds-home-top-bar__spacer" />
        {props.rightIcon ? <span className="ds-home-top-bar__slot">{props.rightIcon}</span> : null}
        {props.secondRightIcon ? <span className="ds-home-top-bar__slot ds-home-top-bar__slot--second">{props.secondRightIcon}</span> : null}
      </div>
    </div>
  ) : null;

  return (
    <div
      className={`ds-home-top-bar${big ? '' : ' ds-home-top-bar--normal'}${props.className ? ` ${props.className}` : ''}`}
      style={{ minHeight: `${big ? BIG_H : NORMAL_H}px` }}
    >
      <span className={`ds-home-top-bar__bg${bgCls}`} aria-hidden="true" />
      <div className="ds-home-top-bar__col">
        <div className="ds-home-top-bar__content">
          <span className="ds-home-top-bar__status" aria-hidden="true" />
          {main}
        </div>
        {/* Dart `children` — extra widgets below the content (React children) */}
        {props.children}
      </div>
    </div>
  );
}
