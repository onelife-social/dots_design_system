// DotsCloseButton — port de lib/src/components/buttons/dots_close_button/ (Dart = fuente de verdad)
__ds.DotsCloseButton = (function () {
  'use strict';

  // DotsCloseButtonSize: size × iconSize
  var SIZES = {
    large: { size: 44, iconSize: 20 },
    medium: { size: 30, iconSize: 16 },
    small: { size: 24, iconSize: 16 },
    extraSmall: { size: 16, iconSize: 10 },
  };
  var VARIANTS = { softContrast: 1, highContrast: 1, onBackground: 1, inverted: 1 };

  function DotsCloseButton(props) {
    var sizeName = SIZES[props.size] ? props.size : 'large';
    var variant = VARIANTS[props.variant] ? props.variant : 'softContrast';
    var addBlur = props.addBlur !== false;
    return h('button', {
      type: 'button',
      className: 'ds-close-btn ds-close-btn--' + sizeName + ' ds-close-btn--' + variant +
        (addBlur ? ' ds-close-btn--blur' : ''),
      onClick: props.onClick,
      'aria-label': 'Cerrar',
    }, h(__ds.DotsIcon, {
      name: props.icon || 'ic-cross',
      size: SIZES[sizeName].iconSize,
      color: props.color,
    }));
  }
  return DotsCloseButton;
})();
