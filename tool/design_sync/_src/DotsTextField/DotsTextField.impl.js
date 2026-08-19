// DotsTextField — port de lib/src/components/text_fields/dots_textfield.dart (Dart = fuente de verdad)
__ds.DotsTextField = (function () {
  'use strict';

  // TextInputType (Dart) → atributos del <input>
  var KEYBOARD = {
    emailAddress: { type: 'email', inputMode: 'email' },
    phone: { type: 'tel', inputMode: 'tel' },
    number: { type: 'text', inputMode: 'numeric' },
    url: { type: 'url', inputMode: 'url' },
  };

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function DotsTextField(props) {
    var R = hooks();
    var controlled = props.value !== undefined && props.value !== null;
    var innerState = R.useState(props.defaultValue != null ? String(props.defaultValue) : '');
    var focusState = R.useState(false);
    var inputRef = R.useRef(null);

    var text = controlled ? String(props.value) : innerState[0];
    var setText = innerState[1];
    var focused = focusState[0];
    var setFocused = focusState[1];

    var enabled = props.enabled !== false;        // Dart: enabled = true
    var background = props.background !== false;  // Dart: background = true
    var showUnderline = !!props.showUnderline;    // Dart: showUnderline = false
    var alignCenter = !!props.alignCenter;        // Dart: alignCenter = false
    var isError = !!props.isError;                // Dart: isError = false

    var showClear = enabled && focused && text.length > 0; // Dart: _showClearButton
    var kb = KEYBOARD[props.keyboardType] || { type: 'text', inputMode: undefined };

    function handleChange(e) {
      var v = e.target.value;
      if (!controlled) setText(v);
      if (props.onChanged) props.onChanged(v);
    }
    function handleKeyDown(e) {
      if (e.key === 'Enter' && props.onSubmitted) props.onSubmitted(e.target.value);
    }
    function handleFocus() { setFocused(true); }
    function handleBlur(e) {
      setFocused(false);
      if (props.onFocusLost) props.onFocusLost(e.target.value); // Dart: onFocusLost
    }
    function handleClear() {
      if (!controlled) setText('');
      if (props.onChanged) props.onChanged('');
      if (inputRef.current) inputRef.current.focus();
    }
    function handleBoxClick() {
      // Dart: GestureDetector → focusNode.requestFocus()
      if (enabled && inputRef.current) inputRef.current.focus();
    }

    var rootCls = 'ds-textfield' + (alignCenter ? ' ds-textfield--center' : '');
    var boxCls =
      'ds-textfield__box' +
      (background ? '' : ' ds-textfield__box--no-bg') +
      (!background && showUnderline ? ' ds-textfield__box--underline' : '');
    // Dart: color texto = labelDestructive solo si isError && !background && !focus
    var inputCls =
      'ds-textfield__input' +
      (isError && !background && !focused ? ' ds-textfield__input--error' : '') +
      (props.addHintTextColorError === true && isError && !focused ? ' ds-textfield__input--hint-error' : '');
    // Dart: icono destructive solo si !background && isError
    var iconCls = 'ds-textfield__icon' + (!background && isError ? ' ds-textfield__icon--error' : '');

    return h(
      'div',
      { className: rootCls },
      h(
        'div',
        { className: boxCls, onClick: handleBoxClick },
        props.leading || null,
        props.icon
          ? h('span', { className: iconCls, 'aria-hidden': true }, icon({ name: props.icon, size: 20, color: 'currentColor' }))
          : null,
        h('input', {
          ref: inputRef,
          className: inputCls,
          type: kb.type,
          inputMode: kb.inputMode,
          value: text,
          placeholder: props.hintText,
          maxLength: props.maxTextLength,
          disabled: !enabled,
          autoFocus: !!props.autoFocus,
          autoCapitalize: props.textCapitalization || 'none', // Dart: TextCapitalization.none
          onChange: handleChange,
          onKeyDown: handleKeyDown,
          onFocus: handleFocus,
          onBlur: handleBlur,
        }),
        showClear
          ? h(
              'button',
              {
                type: 'button',
                // Dart: DotsCloseButton extraSmall — inverted (con fondo) / softContrast (sin fondo)
                className:
                  'ds-textfield__clear ' +
                  (background ? 'ds-textfield__clear--inverted' : 'ds-textfield__clear--soft'),
                'aria-label': 'Borrar texto',
                onMouseDown: function (e) { e.preventDefault(); }, // no robar el foco al input
                onClick: handleClear,
              },
              icon({ name: 'ic-cross', size: 10, color: 'currentColor' })
            )
          : null
      ),
      background && isError && props.errorText
        ? h('div', { className: 'ds-textfield__error-text' }, props.errorText)
        : null
    );
  }

  return DotsTextField;
})();
