// DotsRichButton — port de lib/src/components/buttons/dots_rich_button/dots_rich_button.dart (Dart = fuente de verdad)
__ds.DotsRichButton = (function () {
  'use strict';

  var SIZES = { large: true, medium: true, small: true }; // DotsRichButtonSize

  function DotsRichButton(props) {
    var size = SIZES[props.size] ? props.size : 'medium';
    var textSize = props.textSize === 'large' ? 'large' : 'medium'; // DotsRichButtonTextSize

    // Leading: image > icon > nada (como en Dart)
    var lead = null;
    if (props.image) {
      lead = h('img', { className: 'ds-rich-btn__img', src: props.image, alt: '' });
    } else if (props.icon) {
      lead = __ds.DotsIcon
        ? h(__ds.DotsIcon, {
            name: props.icon,
            size: 24,
            color: props.iconColor || 'var(--text-secondary)', // Dart: default textSecondary
          })
        : h('span', { className: 'ds-rich-btn__lead-ph' });
    }

    var hasTrailing = props.trailingText != null && props.trailingText !== '';
    var trailing = hasTrailing
      ? h('span', { className: 'ds-rich-btn__trail' }, props.trailingText)
      : __ds.DotsIcon
        ? h(__ds.DotsIcon, { name: 'ic-chevron-right', size: 20, color: 'var(--text-tertiary)' })
        : h('span', { className: 'ds-rich-btn__trail' }, '›');

    return h(
      'button',
      { type: 'button', className: 'ds-rich-btn ds-rich-btn--' + size, onClick: props.onClick },
      lead,
      h(
        'span',
        { className: 'ds-rich-btn__mid' },
        h(
          'span',
          { className: 'ds-rich-btn__content ds-rich-btn__content--' + textSize },
          props.content,
          // Dart: punto rojo cuando hay trailingText
          hasTrailing ? h('span', { className: 'ds-rich-btn__reddot' }) : null,
        ),
        props.details ? h('span', { className: 'ds-rich-btn__details' }, props.details) : null,
      ),
      trailing,
    );
  }

  return DotsRichButton;
})();
