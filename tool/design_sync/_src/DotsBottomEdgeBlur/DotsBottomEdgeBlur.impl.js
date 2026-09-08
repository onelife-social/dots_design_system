// DotsBottomEdgeBlur — port de lib/src/components/containers/dots_bottom_edge_blur.dart
// (Dart = fuente de verdad)
__ds.DotsBottomEdgeBlur = (function () {
  'use strict';

  function DotsBottomEdgeBlur(props) {
    var edgeSize = props.edgeSize;
    var sigma = props.sigma === undefined ? 12 : props.sigma;

    // Dart: `if (edgeSize <= 0 || sigma <= 0) return child;`
    if (!(edgeSize > 0) || !(sigma > 0)) {
      return h('div', {
        className: 'ds-bottom-edge-blur' + (props.className ? ' ' + props.className : ''),
      }, props.children);
    }

    return h('div', {
      className: 'ds-bottom-edge-blur' + (props.className ? ' ' + props.className : ''),
    }, [
      props.children,
      h('div', {
        key: 'band',
        className: 'ds-bottom-edge-blur__band',
        style: { height: edgeSize + 'px', '--ds-beb-sigma': sigma + 'px' },
      }),
    ]);
  }

  return DotsBottomEdgeBlur;
})();
