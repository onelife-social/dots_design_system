// DotsToggle — port de lib/src/components/buttons/dots_toggle.dart (Dart = fuente de verdad)
__ds.DotsToggle = (function () {
  'use strict';
  function DotsToggle(props) {
    const { useState } = hooks();
    const controlled = props.isSelected !== undefined && props.isSelected !== null;
    const [internal, setInternal] = useState(!!props.defaultSelected);
    const selected = controlled ? !!props.isSelected : internal;
    function handleClick() {
      if (props.disabled) return;
      if (!controlled) setInternal(!selected);
      if (typeof props.onChanged === 'function') props.onChanged(!selected);
    }
    return h(
      'button',
      {
        type: 'button',
        role: 'switch',
        'aria-checked': selected,
        disabled: !!props.disabled,
        className:
          'ds-toggle' + (selected ? ' is-on' : '') + (props.disabled ? ' is-disabled' : ''),
        onClick: handleClick,
      },
      h('span', { className: 'ds-toggle__knob' }),
    );
  }
  return DotsToggle;
})();
