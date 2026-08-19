// BlurContainer — port de lib/src/components/containers/blur_container.dart y
// dots_linear_gradient_blur.dart (Dart = fuente de verdad).
// Aproximación web: shader de blur → CSS filter; blur progresivo →
// backdrop-filter + mask-image con gradiente (misma técnica que screens/home.html).
__ds.BlurContainer = (function () {
  'use strict';

  // Flutter Alignment → coordenadas (x→, y↓)
  var ALIGN = {
    topLeft: [-1, -1], topCenter: [0, -1], topRight: [1, -1],
    centerLeft: [-1, 0], center: [0, 0], centerRight: [1, 0],
    bottomLeft: [-1, 1], bottomCenter: [0, 1], bottomRight: [1, 1],
  };

  function clamp01(v) {
    v = +v;
    if (!(v >= 0)) return 0;
    return v > 1 ? 1 : v;
  }

  /** BlurContainer(sigma 0–5, child) — blurea TODO su contenido (BlurPainter). */
  function BlurContainer(props) {
    var sigma = +props.sigma;
    if (!(sigma >= 0)) sigma = 0;
    if (sigma > 5) sigma = 5; // assert Dart: 0.0–5.0
    var style = sigma > 0
      ? { filter: 'blur(' + sigma + 'px)', WebkitFilter: 'blur(' + sigma + 'px)' }
      : null;
    return h(
      'div',
      { className: 'ds-blur-container' + (props.className ? ' ' + props.className : ''), style: style },
      props.children
    );
  }

  /** DotsLinearGradientBlur — blur progresivo definido por values/stops/start/end + tint. */
  function GradientBlur(props) {
    var sigma = props.sigma == null ? 8 : +props.sigma; // Dart lo exige; 8 = uso típico del home
    var values = Array.isArray(props.values) && props.values.length ? props.values : [0, 1];
    var stops = Array.isArray(props.stops) && props.stops.length === values.length
      ? props.stops
      : values.map(function (_, i) { return values.length === 1 ? 0 : i / (values.length - 1); });
    var s = ALIGN[props.start] || ALIGN.topCenter;
    var e = ALIGN[props.end] || ALIGN.bottomCenter;
    var dx = e[0] - s[0];
    var dy = e[1] - s[1];
    // Ángulo CSS: 0deg = arriba, horario. Vector start→end con y hacia abajo.
    var angle = dx === 0 && dy === 0 ? 180 : Math.atan2(dx, -dy) * 180 / Math.PI;

    // La máscara replica la textura del shader: alpha = fuerza de blur en cada punto
    var parts = values.map(function (v, i) {
      return 'rgba(0,0,0,' + clamp01(v) + ') ' + (clamp01(stops[i]) * 100) + '%';
    });
    var grad = 'linear-gradient(' + angle.toFixed(2) + 'deg, ' + parts.join(', ') + ')';

    var overlayStyle = {
      backdropFilter: 'blur(' + sigma + 'px)',
      WebkitBackdropFilter: 'blur(' + sigma + 'px)',
      maskImage: grad,
      WebkitMaskImage: grad,
    };
    if (props.tintColor) overlayStyle.background = props.tintColor; // Dart: tintColor (default transparente)

    return h(
      'div',
      { className: 'ds-gradient-blur' + (props.className ? ' ' + props.className : '') },
      props.children,
      h('div', { className: 'ds-gradient-blur__overlay', 'aria-hidden': true, style: overlayStyle })
    );
  }

  BlurContainer.GradientBlur = GradientBlur;
  return BlurContainer;
})();
