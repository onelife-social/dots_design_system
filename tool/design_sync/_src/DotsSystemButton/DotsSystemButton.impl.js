// DotsSystemButton — port de lib/src/components/buttons/dots_system_button/ (Dart = fuente de verdad)
__ds.DotsSystemButton = (function () {
  'use strict';

  var VARIANTS = ['active', 'disabled', 'destructive'];
  var ICON_SIZE = { medium: 20 }; // DotsSystemButtonSize.medium.iconSize

  function DotsSystemButton(props) {
    var size = ICON_SIZE[props.size] ? props.size : 'medium';         // DotsSystemButtonSize.medium (único)
    var variant = VARIANTS.indexOf(props.variant) >= 0 ? props.variant : 'active'; // DotsSystemButtonVariant.active

    var className = 'ds-system-btn ds-system-btn--size-' + size + ' ds-system-btn--' + variant;
    if (props.expand) className += ' ds-system-btn--expand';
    if (props.className) className += ' ' + props.className;

    var iconEl = null;
    if (props.icon) {
      iconEl = h(
        'span',
        { className: 'ds-system-btn__icon', 'aria-hidden': true },
        __ds.DotsIcon
          ? h(__ds.DotsIcon, { name: props.icon, size: ICON_SIZE[size] })
          : h('span', { style: { width: ICON_SIZE[size] + 'px', height: ICON_SIZE[size] + 'px', display: 'inline-block' } })
      );
    }

    // OJO: la variante 'disabled' es SOLO visual en Dart (InkWell sigue recibiendo onTap)
    return h(
      'button',
      {
        type: 'button',
        className: className,
        'aria-disabled': variant === 'disabled' || undefined,
        onClick: props.onClick,
      },
      iconEl,
      h('span', { className: 'ds-system-btn__label' }, props.label)
    );
  }

  return DotsSystemButton;
})();
