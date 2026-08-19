// DotsHomeTopBar — port de lib/src/components/navigation/home_top_bar.dart
// + home_top_bar_main_section.dart (Dart = fuente de verdad)
__ds.DotsHomeTopBar = (function () {
  'use strict';
  var NORMAL_H = 50; // kTopBarNormalHeight (lib/src/core/constants.dart)
  var BIG_H = 106; // kTopBarBigHeight

  function DotsHomeTopBar(props) {
    // Espejo de los constructores Dart: onlyStatusBar / title / widget
    var variant =
      props.variant ||
      (props.title != null ? 'title' : props.child != null ? 'widget' : 'onlyStatusBar');
    var big = variant !== 'onlyStatusBar'; // _bigStatusBar

    // Capa de fondo: showGradient > backgroundBlur > transparente
    var bgCls = props.showGradient
      ? ' ds-home-top-bar__bg--gradient'
      : props.backgroundBlur
        ? ' ds-home-top-bar__bg--blur'
        : '';

    // Centro — child ?? título (labelDefaultBold, textTertiary, tappable)
    var center = null;
    if (props.child != null) {
      center = props.child;
    } else if (variant === 'title' && props.title != null) {
      center = h(
        'button',
        {
          type: 'button',
          className: 'ds-home-top-bar__title',
          onClick: props.onTitleClick,
          style: props.onTitleClick ? undefined : { cursor: 'default' },
        },
        props.title
      );
    }

    // DotsHomeTopBarMainSection — centro + fila imgProfile / rightIcon / secondRightIcon
    var main = big
      ? h(
          'div',
          { className: 'ds-home-top-bar__main' },
          h('div', { className: 'ds-home-top-bar__center' }, center),
          h(
            'div',
            { className: 'ds-home-top-bar__row' },
            props.imgProfile
              ? h('span', { className: 'ds-home-top-bar__profile' }, props.imgProfile)
              : null,
            h('span', { className: 'ds-home-top-bar__spacer' }),
            props.rightIcon
              ? h('span', { className: 'ds-home-top-bar__slot' }, props.rightIcon)
              : null,
            props.secondRightIcon
              ? h(
                  'span',
                  { className: 'ds-home-top-bar__slot ds-home-top-bar__slot--second' },
                  props.secondRightIcon
                )
              : null
          )
        )
      : null;

    return h(
      'div',
      {
        className:
          'ds-home-top-bar' +
          (big ? '' : ' ds-home-top-bar--normal') +
          (props.className ? ' ' + props.className : ''),
        style: { minHeight: (big ? BIG_H : NORMAL_H) + 'px' },
      },
      h('span', { className: 'ds-home-top-bar__bg' + bgCls, 'aria-hidden': true }),
      h(
        'div',
        { className: 'ds-home-top-bar__col' },
        h(
          'div',
          { className: 'ds-home-top-bar__content' },
          h('span', { className: 'ds-home-top-bar__status', 'aria-hidden': true }),
          main
        ),
        // Dart `children` — widgets extra bajo el contenido (React children)
        props.children
      )
    );
  }
  return DotsHomeTopBar;
})();
