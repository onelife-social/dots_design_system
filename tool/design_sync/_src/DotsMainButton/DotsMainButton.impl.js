// DotsMainButton — port de lib/src/components/buttons/dots_main_button/ (Dart = fuente de verdad)
__ds.DotsMainButton = (function () {
  'use strict';

  var SIZE_HEIGHT = { mainAction: 52, large: 44, medium: 36, small: 28 };

  var VARIANTS = [
    'main', 'secondary', 'secondaryPremium', 'secondaryPremiumPlus', 'secondaryLight',
    'secondaryDark', 'destructive', 'disabled', 'disabledOpaque', 'ghost',
    'premiumPlus', 'premium', 'surface', 'surfacePremium', 'surfacePremiumPlus',
  ];

  // Variantes cuyo foregroundGradient se anula si llega textColor (ver dots_main_button_theme.dart)
  var GRADIENT_CANCELLED_BY_TEXTCOLOR = {
    secondaryPremium: true, secondaryPremiumPlus: true,
    surfacePremium: true, surfacePremiumPlus: true,
  };

  function DotsMainButton(props) {
    var useRef = hooks().useRef;
    var lastTapRef = useRef(0);

    var size = SIZE_HEIGHT[props.size] ? props.size : 'large';                 // DotsMainButtonSize.large
    var variant = VARIANTS.indexOf(props.variant) >= 0 ? props.variant : 'main'; // DotsMainButtonVariant.main
    var enabled = props.enabled !== false;
    var isLoading = !!props.isLoading;
    var disabledVariant = VARIANTS.indexOf(props.disabledVariant) >= 0 ? props.disabledVariant : 'disabled';
    var effVariant = enabled ? variant : disabledVariant;
    var iconPosition = props.iconPosition === 'right' ? 'right' : 'left';
    var iconSize = props.iconSize == null ? 20 : props.iconSize;
    var expand = props.expand !== false;

    var className = 'ds-main-btn ds-main-btn--size-' + size + ' ds-main-btn--' + effVariant;
    if (expand) className += ' ds-main-btn--expand';
    if (props.adaptPaddingForText) className += ' ds-main-btn--adapt-padding';
    if (props.shouldApplyBlur) className += ' ds-main-btn--blur';
    if (props.textColor && GRADIENT_CANCELLED_BY_TEXTCOLOR[effVariant]) {
      className += ' ds-main-btn--custom-text';
    }
    if (props.className) className += ' ' + props.className;

    var rootStyle = {};
    if (props.backgroundColor) rootStyle.background = props.backgroundColor; // anula tb. backgroundGradient (Dart)
    if (props.textColor) rootStyle.color = props.textColor;

    function handleClick(e) {
      if (!props.onClick) return;
      if (props.useThrottle) {
        // EasyThrottle.throttle(…, throttleDuration) → primer tap pasa, resto se ignora en la ventana
        var now = Date.now();
        var win = props.throttleDuration == null ? 400 : props.throttleDuration;
        if (now - lastTapRef.current < win) return;
        lastTapRef.current = now;
      }
      props.onClick(e);
    }

    var iconEl = null;
    if (props.icon && !isLoading) {
      var iconStyle = props.iconColor ? { color: props.iconColor } : null;
      iconEl = h(
        'span',
        { className: 'ds-main-btn__icon', style: iconStyle, 'aria-hidden': true },
        __ds.DotsIcon
          ? h(__ds.DotsIcon, { name: props.icon, size: iconSize })
          : h('span', { style: { width: iconSize + 'px', height: iconSize + 'px', display: 'inline-block' } })
      );
    }

    var labelEl = h(
      'span',
      { className: 'ds-main-btn__label', style: props.textStyle || null },
      props.label
    );

    // details solo en mainAction y large (Dart)
    var detailsEl = null;
    if (props.details != null && (size === 'mainAction' || size === 'large')) {
      detailsEl = h('span', { className: 'ds-main-btn__details' }, props.details);
    }

    var children;
    if (isLoading) {
      // GradientProgressIndicator: diámetro = height - 25, stroke 3 (mínimo visual 12px en web)
      var d = Math.max(SIZE_HEIGHT[size] - 25, 12);
      children = [h('span', {
        key: 'spinner',
        className: 'ds-main-btn__spinner',
        style: { width: d + 'px', height: d + 'px' },
      })];
    } else if (iconPosition === 'left') {
      children = [iconEl, labelEl, detailsEl];
    } else {
      children = [labelEl, detailsEl, iconEl];
    }

    return h(
      'button',
      {
        type: 'button',
        className: className,
        style: (props.backgroundColor || props.textColor) ? rootStyle : null,
        disabled: !enabled || isLoading,
        'aria-busy': isLoading || undefined,
        onClick: (enabled && !isLoading) ? handleClick : undefined,
      },
      children
    );
  }

  return DotsMainButton;
})();
