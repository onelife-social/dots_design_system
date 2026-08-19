// DotsSelector — port de lib/src/components/buttons/dots_selector.dart (Dart = fuente de verdad)
__ds.DotsSelector = (function () {
  'use strict';

  var SIZES = { small: 22, medium: 24 }; // DotsSelectorSize.height

  function DotsSelector(props) {
    const { useState } = hooks();
    var sizeName = SIZES[props.size] ? props.size : 'medium'; // Dart: default medium
    var variant = props.variant === 'num' ? 'num' : 'check'; // DotsSelectorVariant
    var controlled = props.isSelected !== undefined && props.isSelected !== null;
    const [internal, setInternal] = useState(!!props.defaultSelected);
    var selected = controlled ? !!props.isSelected : internal;

    function handleClick() {
      var next = !selected;
      if (!controlled) setInternal(next);
      if (typeof props.onChanged === 'function') props.onChanged(next);
    }

    var content = null;
    if (selected) {
      content =
        variant === 'check'
          ? __ds.DotsIcon
            ? h(__ds.DotsIcon, { name: 'ic-check', size: 14, color: 'var(--label-always-white)' })
            : h('span', { className: 'ds-selector__dot' })
          : String(props.number == null ? 1 : props.number); // Dart: number default 1
    }

    return h(
      'button',
      {
        type: 'button',
        role: 'checkbox',
        'aria-checked': selected,
        className: 'ds-selector ds-selector--' + sizeName + (selected ? ' is-on' : ''),
        onClick: handleClick,
      },
      content,
    );
  }

  return DotsSelector;
})();
