// DotsRadioButton — port de lib/src/components/buttons/dots_radio_button.dart (Dart = fuente de verdad)
__ds.DotsRadioButton = (function () {
  'use strict';
  function DotsRadioButton(props) {
    const { useState } = hooks();
    const size = props.size || 24;
    const controlled = props.isSelected !== undefined && props.isSelected !== null;
    const [internal, setInternal] = useState(!!props.defaultSelected);
    const selected = controlled ? !!props.isSelected : internal;
    function handleClick() {
      if (props.disabled) return;
      if (!controlled && !selected) setInternal(true);
      if (typeof props.onChanged === 'function') props.onChanged(true);
    }
    const Icon = __ds.DotsIcon;
    return h(
      'button',
      {
        type: 'button',
        role: 'radio',
        'aria-checked': selected,
        disabled: !!props.disabled,
        className:
          'ds-radio' + (selected ? ' is-on' : '') + (props.disabled ? ' is-disabled' : ''),
        style: { width: size + 'px', height: size + 'px' },
        onClick: handleClick,
      },
      selected
        ? Icon
          ? h(Icon, { name: 'ic-selector', size: 15, color: 'var(--label-highlight)' })
          : h('span', { className: 'ds-radio__dot' })
        : null,
    );
  }
  return DotsRadioButton;
})();
