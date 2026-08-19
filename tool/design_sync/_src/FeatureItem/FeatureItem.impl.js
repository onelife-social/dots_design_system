// FeatureItem — port de lib/src/components/feature_item/feature_item.dart (Dart = fuente de verdad)
__ds.FeatureItem = (function () {
  'use strict';

  function FeatureItem(props) {
    var hasValue = props.value != null;

    var leading;
    if (props.image != null) {
      // FeatureItem.image → SizedBox.square(24) con el widget custom
      leading = h('span', { className: 'ds-feature-item__image' }, props.image);
    } else {
      // Default → DotsIcon(size 16, textQuarternary vía CSS currentColor)
      leading = h(
        'span',
        { className: 'ds-feature-item__icon', 'aria-hidden': true },
        __ds.DotsIcon
          ? h(__ds.DotsIcon, { name: props.icon, size: 16 })
          : h('span', { style: { width: '16px', height: '16px', display: 'inline-block' } })
      );
    }

    var className = 'ds-feature-item';
    if (hasValue) className += ' ds-feature-item--with-value';
    if (props.className) className += ' ' + props.className;

    return h(
      'div',
      { className: className },
      leading,
      h('span', { className: 'ds-feature-item__feature' }, props.feature),
      hasValue ? h('span', { className: 'ds-feature-item__value' }, props.value) : null
    );
  }

  return FeatureItem;
})();
