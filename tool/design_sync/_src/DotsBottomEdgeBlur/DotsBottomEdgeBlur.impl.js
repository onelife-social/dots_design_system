// DotsBottomEdgeBlur — port de lib/src/components/containers/dots_bottom_edge_blur.dart
// (Dart = fuente de verdad)
__ds.DotsBottomEdgeBlur = (function () {
  'use strict';

  function DotsBottomEdgeBlur(props) {
    var edgeSize = props.edgeSize;
    var sigma = props.sigma === undefined ? 12 : props.sigma;

    // Dart: `if (edgeSize <= 0 || sigma <= 0) return child;` — devolvemos el hijo
    // sin envolver, para no alterar su layout (margin collapsing, flex/grid…).
    // Solo si llega className hace falta el contenedor para poder aplicarlo.
    if (!(edgeSize > 0) || !(sigma > 0)) {
      return props.className
        ? h('div', { className: 'ds-bottom-edge-blur ' + props.className }, props.children)
        : props.children;
    }

    // Hijos como argumentos posicionales (no como array): así React no los trata
    // como lista y no exige `key` en el children que llegue de fuera.
    return h(
      'div',
      { className: 'ds-bottom-edge-blur' + (props.className ? ' ' + props.className : '') },
      props.children,
      h('div', {
        className: 'ds-bottom-edge-blur__band',
        style: { height: edgeSize + 'px', '--ds-beb-sigma': sigma + 'px' },
      })
    );
  }

  return DotsBottomEdgeBlur;
})();
