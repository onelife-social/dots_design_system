// PageControl — port de lib/src/components/dot_book/page_control.dart (+ page_control_theme.dart)
// (Dart = fuente de verdad)
__ds.PageControl = (function () {
  'use strict';

  // getPageControlTheme (page_control_theme.dart)
  var THEMES = {
    main: {
      dotSize: 8,
      dotSpacing: 8,
      activeColor: 'var(--label-primary)',
      dotColor: 'var(--label-secondary)',
      activeBackgroundColor: null,
    },
    background: {
      dotSize: 6,
      dotSpacing: 12,
      activeColor: 'var(--label-active)',
      dotColor: 'var(--label-secondary)',
      activeBackgroundColor: 'var(--bg-active)',
    },
  };

  // _getBorderRadius (Dart): píldora continua del primer dot al activo
  function cellRadius(i, activeIndex, radius) {
    var r = radius + 'px';
    if (i === 0) {
      if (i === activeIndex) return r;
      return r + ' 0 0 ' + r;
    }
    if (i === activeIndex) return '0 ' + r + ' ' + r + ' 0';
    return '0';
  }

  function PageControl(props) {
    var variant = props.variant === 'background' ? 'background' : 'main';
    var t = THEMES[variant];
    var count = props.count || 0;
    // Clamp de activeIndex como el constructor Dart
    var activeIndex = props.activeIndex == null ? 0 : props.activeIndex;
    activeIndex = count <= 0 || activeIndex < 0 ? 0 : Math.min(activeIndex, count - 1);

    var dotColor = props.dotColor || t.dotColor;
    var activeColor = props.activeColor || t.activeColor;
    var isBg = variant === 'background';

    var dots = [];
    for (var i = 0; i < count; i++) {
      // background: activos todos hasta activeIndex; main: solo el activo
      var isActive = isBg ? i <= activeIndex : i === activeIndex;
      var cellStyle = isBg
        ? { padding: t.dotSpacing / 2 + 'px' }
        : { padding: '0 ' + t.dotSpacing / 2 + 'px' };
      if (isBg && isActive) {
        cellStyle.background = t.activeBackgroundColor;
        cellStyle.borderRadius = cellRadius(i, activeIndex, (t.dotSize + t.dotSpacing) / 2);
      }
      dots.push(
        h(
          'span',
          { key: i, className: 'ds-page-control__cell', style: cellStyle },
          h('span', {
            className: 'ds-page-control__dot',
            style: {
              width: t.dotSize + 'px',
              height: t.dotSize + 'px',
              background: isActive ? activeColor : dotColor,
            },
          })
        )
      );
    }

    return h(
      'span',
      {
        className:
          'ds-page-control ds-page-control--' + variant +
          (props.className ? ' ' + props.className : ''),
        // count <= 0: reserva la altura del dot (+ spacing en background), como el SizedBox Dart
        style:
          count <= 0
            ? { height: t.dotSize + (isBg ? t.dotSpacing : 0) + 'px' }
            : undefined,
        role: 'tablist',
      },
      dots
    );
  }
  return PageControl;
})();
