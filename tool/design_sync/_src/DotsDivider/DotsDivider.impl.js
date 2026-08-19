// DotsDivider — port de lib/src/components/divider/dots_divider.dart (Dart = fuente de verdad)
__ds.DotsDivider = (function () {
  'use strict';

  function DotsDivider(props) {
    var style = null;
    if (props.width != null) {
      style = { width: typeof props.width === 'number' ? props.width + 'px' : props.width };
    }
    return h(
      'div',
      {
        className: 'ds-divider' + (props.className ? ' ' + props.className : ''),
        style: style,
        role: 'separator',
        'aria-orientation': 'horizontal',
      },
      h('div', { className: 'ds-divider__line1' }),
      h('div', { className: 'ds-divider__line2' })
    );
  }

  return DotsDivider;
})();
