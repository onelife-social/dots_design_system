// DotsSegmentedControl — port de lib/src/components/segmented_control/ (Dart = fuente de verdad)
// Cubre SegmentedControl (type 'text', variant main|camera), SegmentedControlIcon
// (type 'icon') y SegmentedControlSingle (type 'single').
__ds.DotsSegmentedControl = (function () {
  'use strict';
  function badgeTag(tag) {
    // BadgeTag en (-2,-2) — rightOptionTag / buttonTag
    return tag ? h('span', { className: 'ds-seg__tag' }, tag) : null;
  }
  function DotsSegmentedControl(props) {
    const { useState } = hooks();
    const type = props.type || 'text';
    const controlled = props.selectedOption !== undefined && props.selectedOption !== null;
    const [internal, setInternal] = useState(props.defaultSelectedOption || 'left');
    const selected = controlled ? props.selectedOption : internal;
    function tap(option) {
      if (!controlled) setInternal(option);
      if (typeof props.onTapOption === 'function') props.onTapOption(option);
    }

    if (type === 'single') {
      // SegmentedControlSingle — una sola opción siempre seleccionada
      return h(
        'div',
        {
          className: 'ds-seg ds-seg--single',
          style: props.backgroundColor ? { background: props.backgroundColor } : null,
        },
        h(
          'span',
          {
            className: 'ds-seg__opt is-selected',
            style: props.selectedColor ? { background: props.selectedColor } : null,
          },
          props.buttonName,
        ),
        badgeTag(props.buttonTag),
      );
    }

    if (type === 'icon') {
      // SegmentedControlIcon — 108×48, celdas 48×40, pill deslizante 200ms
      const Icon = __ds.DotsIcon;
      const cell = function (side, name) {
        const sel = selected === side;
        return h(
          'button',
          {
            type: 'button',
            className: 'ds-seg-icon__cell' + (sel ? ' is-selected' : ''),
            'aria-pressed': sel,
            onClick: function () { tap(side); },
          },
          Icon
            ? h(Icon, {
                name: name,
                size: 24,
                color: sel ? 'var(--text-secondary)' : 'var(--text-disabled)',
              })
            : name,
        );
      };
      return h(
        'div',
        { className: 'ds-seg-icon' },
        h('span', { className: 'ds-seg-icon__pill' + (selected === 'right' ? ' is-right' : '') }),
        cell('left', props.leftOptionIcon),
        cell('right', props.rightOptionIcon),
      );
    }

    // type 'text' — SegmentedControl (variant main | camera)
    const variant = props.variant || 'main';
    const opt = function (side, label) {
      const sel = selected === side;
      return h(
        'button',
        {
          type: 'button',
          className: 'ds-seg__opt' + (sel ? ' is-selected' : ''),
          style: sel && props.selectedColor ? { background: props.selectedColor } : null,
          'aria-pressed': sel,
          onClick: function () { tap(side); },
        },
        label,
      );
    };
    return h(
      'div',
      {
        className: 'ds-seg' + (variant === 'camera' ? ' ds-seg--camera' : ''),
        style: props.backgroundColor ? { background: props.backgroundColor } : null,
      },
      opt('left', props.leftOptionName),
      opt('right', props.rightOptionName),
      badgeTag(props.rightOptionTag),
    );
  }
  return DotsSegmentedControl;
})();
