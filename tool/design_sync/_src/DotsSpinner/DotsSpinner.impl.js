// DotsSpinner — port de lib/src/components/spinner/spinner_round.dart (SpinnerRound; Dart = fuente de verdad)
__ds.DotsSpinner = (function () {
  'use strict';
  function DotsSpinner(props) {
    var size = props.size == null ? 43 : props.size;
    var strokeWidth = props.strokeWidth == null ? 4 : props.strokeWidth;
    var showPercentage = props.showPercentage !== false;
    var indeterminate = !!props.indeterminate; // extensión web: gira sin progreso conocido
    var progress = Math.min(1, Math.max(0, props.progress || 0));
    var half = size / 2;
    var r = (size - strokeWidth) / 2;
    var c = 2 * Math.PI * r;
    var arc = indeterminate ? 0.25 * c : progress * c;
    return h(
      'span',
      {
        className:
          'ds-spinner' +
          (indeterminate ? ' ds-spinner--indeterminate' : '') +
          (props.className ? ' ' + props.className : ''),
        style: { width: size + 'px', height: size + 'px' },
        role: 'progressbar',
        'aria-valuemin': 0,
        'aria-valuemax': 100,
        'aria-valuenow': indeterminate ? undefined : Math.floor(progress * 100),
      },
      h(
        'svg',
        {
          className: 'ds-spinner__svg',
          viewBox: '0 0 ' + size + ' ' + size,
          width: size,
          height: size,
        },
        // Track — bgBtnImage
        h('circle', {
          className: 'ds-spinner__track',
          cx: half,
          cy: half,
          r: r,
          fill: 'none',
          strokeWidth: strokeWidth,
        }),
        // Arco de progreso — labelAlwaysWhite, empieza arriba (startAngle 270°)
        h('circle', {
          className: 'ds-spinner__arc',
          cx: half,
          cy: half,
          r: r,
          fill: 'none',
          strokeWidth: strokeWidth,
          strokeLinecap: 'round',
          strokeDasharray: arc + ' ' + c,
          transform: 'rotate(-90 ' + half + ' ' + half + ')',
        })
      ),
      showPercentage && !indeterminate
        ? h('span', { className: 'ds-spinner__pct' }, Math.floor(progress * 100) + '%')
        : null
    );
  }
  return DotsSpinner;
})();
