// DotsItemInput — port de lib/src/components/text_fields/dots_item_input.dart (Dart = fuente de verdad)
__ds.DotsItemInput = (function () {
  'use strict';

  // DotsItemInputPosition → sufijo de clase (radio 16 por posición)
  var POSITIONS = { onlyOne: 'only-one', first: 'first', middle: 'middle', last: 'last' };

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function DotsItemInput(props) {
    var pos = POSITIONS[props.position] || 'only-one'; // Dart: default → r16 completo
    var clickable = typeof props.onClick === 'function';

    function handleKeyDown(e) {
      if ((e.key === 'Enter' || e.key === ' ') && clickable) {
        e.preventDefault();
        props.onClick();
      }
    }

    return h(
      'div',
      {
        className: 'ds-item-input ds-item-input--' + pos + (clickable ? ' ds-item-input--clickable' : ''),
        role: clickable ? 'button' : undefined,
        tabIndex: clickable ? 0 : undefined,
        onClick: props.onClick, // Dart: onTap
        onKeyDown: clickable ? handleKeyDown : undefined,
      },
      h('span', { className: 'ds-item-input__icon', 'aria-hidden': true },
        icon({ name: props.icon || 'ic-calendar', size: 20, color: 'currentColor' })), // Dart: icon ?? calendar
      h('span', { className: 'ds-item-input__label' }, props.label || ''),
      h('span', { className: 'ds-item-input__value' }, props.value || '')
    );
  }

  return DotsItemInput;
})();
