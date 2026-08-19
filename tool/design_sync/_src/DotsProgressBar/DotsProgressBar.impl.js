// DotsProgressBar — port de lib/src/components/progress_bar/dots_progress_bar.dart (Dart = fuente de verdad)
__ds.DotsProgressBar = (function () {
  'use strict';
  function DotsProgressBar(props) {
    var percentage = Math.min(1, Math.max(0, props.percentage || 0));
    var parts = props.parts == null ? 3 : Math.max(1, props.parts);
    var spaceBetween = props.spaceBetween == null ? 5 : props.spaceBetween;
    var width =
      props.width == null
        ? '100%'
        : typeof props.width === 'number'
          ? props.width + 'px'
          : props.width;
    var segs = [];
    for (var i = 0; i < parts; i++) {
      // Fracción rellena de cada parte (aprox. del painter Dart, gaps despreciados)
      var fill = Math.min(1, Math.max(0, percentage * parts - i));
      segs.push(
        h(
          'span',
          {
            key: i,
            className: 'ds-progress-bar__seg',
            style: props.bgColor ? { background: props.bgColor } : undefined,
          },
          h('span', {
            className: 'ds-progress-bar__fill',
            style: props.barColor
              ? { width: fill * 100 + '%', background: props.barColor }
              : { width: fill * 100 + '%' },
          })
        )
      );
    }
    return h(
      'span',
      {
        className: 'ds-progress-bar' + (props.className ? ' ' + props.className : ''),
        style: { width: width, gap: spaceBetween + 'px' },
        role: 'progressbar',
        'aria-valuemin': 0,
        'aria-valuemax': 100,
        'aria-valuenow': Math.round(percentage * 100),
      },
      segs
    );
  }
  // Espejo del factory Dart DotsProgressBar.byStep(stepNumber, totalSteps)
  DotsProgressBar.byStep = function (stepNumber, totalSteps) {
    return h(DotsProgressBar, { percentage: stepNumber / totalSteps });
  };
  return DotsProgressBar;
})();
