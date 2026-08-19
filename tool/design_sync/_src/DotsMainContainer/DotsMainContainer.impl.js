// DotsMainContainer — port de lib/src/components/containers/dots_main_container/ (Dart = fuente de verdad)
__ds.DotsMainContainer = (function () {
  'use strict';

  var VARIANTS = ['main', 'secondary', 'onBackground', 'tertiary'];

  function toCssSize(v) {
    return typeof v === 'number' ? v + 'px' : v;
  }

  function DotsMainContainer(props) {
    var variant = VARIANTS.indexOf(props.variant) >= 0 ? props.variant : 'main'; // DotsMainContainerVariant.main
    var forceHeight = props.forceHeight !== false;
    var padding = props.padding == null ? 16 : props.padding;

    // Dart: radius ?? (containerHeight > 100 ? 32 : 24); sin height → alto de pantalla → 32
    var radius = props.radius;
    if (radius == null) {
      radius = typeof props.height === 'number' && props.height <= 100 ? 24 : 32;
    }

    var className = 'ds-main-container ds-main-container--' + variant;
    if (props.onClick) className += ' ds-main-container--clickable';
    if (props.className) className += ' ' + props.className;

    var style = { borderRadius: toCssSize(radius) };
    if (props.width != null) style.width = toCssSize(props.width);
    if (props.height != null && forceHeight) style.height = toCssSize(props.height);
    if (props.children != null) style.padding = toCssSize(padding); // Dart: Padding solo con child
    if (props.backgroundColor) style.backgroundColor = props.backgroundColor;
    if (props.backgroundImage) {
      // acepta un valor CSS de background-image o una URL/data URI a pelo
      style.backgroundImage = props.backgroundImage.indexOf('(') >= 0
        ? props.backgroundImage
        : 'url(' + props.backgroundImage + ')';
    }
    if (props.style) for (var k in props.style) style[k] = props.style[k];

    return h(
      'div',
      {
        className: className,
        style: style,
        onClick: props.onClick || undefined, // Dart: GestureDetector(onTap)
        role: props.onClick ? 'button' : undefined,
        tabIndex: props.onClick ? 0 : undefined,
      },
      props.children
    );
  }

  return DotsMainContainer;
})();
