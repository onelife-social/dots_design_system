// ImageWithProgressAround — port de lib/src/components/progress_bar/image_with_progress_around.dart (Dart = fuente de verdad)
__ds.ImageWithProgressAround = (function () {
  'use strict';
  // DotsColors.recapGradientColors (SweepGradient del painter → aprox. linearGradient SVG)
  var RECAP_GRADIENT = [
    '#EF5FC1', '#C982F7', '#15ABF3', '#B295B6',
    '#F5784D', '#EF9C5F', '#F44E69', '#EF5FC1',
  ];
  var uid = 0;

  function ImageWithProgressAround(props) {
    var hk = hooks();
    var idRef = hk.useRef(null);
    if (idRef.current == null) idRef.current = 'ds-iwpa-grad-' + ++uid;
    var gradId = idRef.current;

    var width = props.width == null ? 150 : props.width;
    // kStandardAspectRatio 9/16 · kSmallAspectRatio 3/4 (isSmallScreen)
    var ratio = props.aspectRatio === 'small' ? 3 / 4 : 9 / 16;
    var height = Math.round(width / ratio);
    var stroke = props.progressBarWidth == null ? 6 : props.progressBarWidth;
    var pad = props.innerPadding == null ? 8 : props.innerPadding;
    var br = props.borderRadius == null ? 45 : props.borderRadius;
    // Normalización Dart: > 1 se trata como porcentaje
    var raw = props.progress || 0;
    var progress = raw > 1 ? Math.min(1, raw / 100) : Math.max(0, Math.min(1, raw));
    var colors =
      props.progressBarColors && props.progressBarColors.length
        ? props.progressBarColors
        : RECAP_GRADIENT;

    var half = stroke / 2;
    // radius del painter: borderRadius + padding + strokeWidth/2
    var rx = br + pad + half;
    var rw = width - stroke;
    var rh = height - stroke;
    rx = Math.min(rx, rw / 2, rh / 2);
    // El path del <rect> empieza en (x+rx, y); el painter Dart empieza en el centro
    // superior yendo en sentido horario → dashoffset negativo para desplazar el inicio.
    var perimeter = 2 * (rw + rh) - 8 * rx + 2 * Math.PI * rx;
    var startShift = ((rw / 2 - rx) / perimeter) * 100;

    var stops = [];
    for (var i = 0; i < colors.length; i++) {
      stops.push(
        h('stop', {
          key: i,
          offset: colors.length === 1 ? 0 : i / (colors.length - 1),
          stopColor: colors[i],
        })
      );
    }

    return h(
      'span',
      {
        className:
          'ds-iwpa' + (props.className ? ' ' + props.className : ''),
        style: { width: width + 'px', height: height + 'px' },
        role: 'progressbar',
        'aria-valuemin': 0,
        'aria-valuemax': 100,
        'aria-valuenow': Math.round(progress * 100),
      },
      h(
        'span',
        {
          className: 'ds-iwpa__inner',
          style: {
            inset: pad + stroke + 'px',
            borderRadius: br + 'px',
          },
        },
        props.src
          ? h('img', { className: 'ds-iwpa__img', src: props.src, alt: props.alt || '' })
          : h('span', { className: 'ds-iwpa__placeholder' }),
        // Overlay negro 20% + % centrado (titleH3, labelAlwaysWhite)
        h(
          'span',
          { className: 'ds-iwpa__overlay' },
          h('span', { className: 'ds-iwpa__pct' }, Math.round(progress * 100) + '%')
        )
      ),
      h(
        'svg',
        {
          className: 'ds-iwpa__ring',
          viewBox: '0 0 ' + width + ' ' + height,
          width: width,
          height: height,
        },
        h(
          'defs',
          null,
          h(
            'linearGradient',
            { id: gradId, x1: '0', y1: '0', x2: '1', y2: '1' },
            stops
          )
        ),
        // Track — bgSecondaryBtn
        h('rect', {
          className: 'ds-iwpa__track',
          x: half,
          y: half,
          width: rw,
          height: rh,
          rx: rx,
          fill: 'none',
          strokeWidth: stroke,
        }),
        // Progreso — arranca en el centro superior, sentido horario
        progress > 0
          ? h('rect', {
              className: 'ds-iwpa__progress',
              x: half,
              y: half,
              width: rw,
              height: rh,
              rx: rx,
              fill: 'none',
              stroke: 'url(#' + gradId + ')',
              strokeWidth: stroke,
              strokeLinecap: 'round',
              pathLength: 100,
              strokeDasharray: progress * 100 + ' 100',
              strokeDashoffset: -startShift,
            })
          : null
      )
    );
  }
  return ImageWithProgressAround;
})();
