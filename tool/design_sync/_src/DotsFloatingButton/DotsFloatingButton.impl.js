// DotsFloatingButton — port de lib/src/components/buttons/dots_floating_button/ (Dart = fuente de verdad)
__ds.DotsFloatingButton = (function () {
  'use strict';
  function DotsFloatingButton(props) {
    var blur = props.blur !== false;
    return h('button', {
      type: 'button',
      className: 'ds-floating-btn' + (blur ? ' ds-floating-btn--blur' : ''),
      onClick: props.onClick,
    },
      props.icon ? h(__ds.DotsIcon, { name: props.icon, size: 20 }) : null,
      h('span', { className: 'ds-floating-btn__label' }, props.content)
    );
  }
  return DotsFloatingButton;
})();
