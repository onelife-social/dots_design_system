// DotsTopBar — port de lib/src/components/navigation/top_bar.dart (Dart = fuente de verdad)
__ds.DotsTopBar = (function () {
  'use strict';
  var NORMAL_H = 50; // kTopBarNormalHeight (lib/src/core/constants.dart)
  var BIG_H = 106; // kTopBarBigHeight

  // DotsIconButton(chevronLeft, medium, solid|noBackground) — fallback si no está en el bundle
  function backButton(props) {
    var IconButton = __ds.DotsIconButton;
    if (IconButton) {
      return h(IconButton, {
        icon: 'ic-chevron-left',
        size: 'medium',
        variant: props.showCircleBackButton ? 'solid' : 'noBackground',
        onClick: props.onBack,
      });
    }
    return h(
      'button',
      {
        type: 'button',
        className:
          'ds-top-bar__back-fallback' + (props.showCircleBackButton ? ' is-solid' : ''),
        onClick: props.onBack,
        'aria-label': 'Atrás',
      },
      __ds.DotsIcon ? h(__ds.DotsIcon, { name: 'ic-chevron-left', size: 20 }) : '‹'
    );
  }

  // DotsMainButton(main, small, expand:false) — fallback si no está en el bundle
  function ctaButton(props) {
    var MainButton = __ds.DotsMainButton;
    var enabled = props.ctaEnabled !== false;
    if (MainButton) {
      return h(MainButton, {
        label: props.ctaLabel,
        variant: 'main',
        size: 'small',
        expand: false,
        enabled: enabled,
        onClick: props.onCtaClick,
      });
    }
    return h(
      'button',
      {
        type: 'button',
        className: 'ds-top-bar__cta-fallback',
        disabled: !enabled,
        onClick: props.onCtaClick,
      },
      props.ctaLabel
    );
  }

  function DotsTopBar(props) {
    // Espejo de los constructores Dart: onlyStatusBar / title / widget / cta
    var variant =
      props.variant ||
      (props.children != null
        ? 'widget'
        : props.ctaLabel != null
          ? 'cta'
          : props.title != null || props.imageTitle != null
            ? 'title'
            : 'onlyStatusBar');
    var hideWidgets = variant === 'onlyStatusBar'; // _hideWidgets
    var bigStatusBar = hideWidgets ? false : props.bigStatusBar !== false;
    var height = bigStatusBar ? BIG_H : NORMAL_H;

    var style = { height: height + 'px' };
    // color ?? (hideBackground ? transparent : bgContainerPrimary) — el default va en CSS
    if (props.color) style.background = props.color;
    else if (props.hideBackground) style.background = 'transparent';

    var center;
    if (variant === 'widget') {
      center = props.children;
    } else {
      center = h(
        'span',
        { className: 'ds-top-bar__title-wrap' },
        h(
          'span',
          { className: 'ds-top-bar__title' },
          props.imageTitle
            ? h('img', {
                className: 'ds-top-bar__img-title',
                src: props.imageTitle,
                alt: '',
              })
            : null,
          props.title || ''
        ),
        props.subtitle != null
          ? h('span', { className: 'ds-top-bar__subtitle' }, props.subtitle)
          : null
      );
    }

    return h(
      'div',
      {
        className:
          'ds-top-bar' +
          (props.showBottomBorder ? ' ds-top-bar--bordered' : '') +
          (props.className ? ' ' + props.className : ''),
        style: style,
      },
      // SizedBox(50) del status bar — se pinta cuando _hideWidgets != bigStatusBar
      hideWidgets !== bigStatusBar
        ? h('span', { className: 'ds-top-bar__status', 'aria-hidden': true })
        : null,
      !hideWidgets
        ? h(
            'div',
            { className: 'ds-top-bar__content' },
            h('div', { className: 'ds-top-bar__center' }, center),
            h(
              'div',
              { className: 'ds-top-bar__row' },
              props.onBack
                ? h('span', { className: 'ds-top-bar__slot ds-top-bar__slot--left' }, backButton(props))
                : null,
              props.leftIcon && !props.onBack
                ? h('span', { className: 'ds-top-bar__slot ds-top-bar__slot--left' }, props.leftIcon)
                : null,
              h('span', { className: 'ds-top-bar__spacer' }),
              props.rightIcon
                ? h('span', { className: 'ds-top-bar__slot ds-top-bar__slot--right' }, props.rightIcon)
                : null,
              // Dart exige también onCtaTap; aquí basta ctaLabel (onClick opcional para diseño)
              props.ctaLabel != null
                ? h('span', { className: 'ds-top-bar__slot ds-top-bar__slot--right' }, ctaButton(props))
                : null
            )
          )
        : null
    );
  }
  return DotsTopBar;
})();
