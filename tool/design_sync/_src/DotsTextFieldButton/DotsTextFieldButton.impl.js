// DotsTextFieldButton — port de lib/src/components/text_fields/dots_textfield_button.dart (Dart = fuente de verdad)
__ds.DotsTextFieldButton = (function () {
  'use strict';

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function DotsTextFieldButton(props) {
    var R = hooks();
    var controlled = props.value !== undefined && props.value !== null;
    var innerState = R.useState(props.defaultValue != null ? String(props.defaultValue) : '');
    var focusState = R.useState(false);
    var inputRef = R.useRef(null);

    var text = controlled ? String(props.value) : innerState[0];
    var setText = innerState[1];
    var focused = focusState[0];
    var setFocused = focusState[1];

    var enabled = props.enabled !== false;                       // Dart: enabled = true
    var background = props.background !== false;                 // Dart: background = true
    var isError = !!props.isError;                               // Dart: isError = false
    var alignCenter = !!props.alignCenter;                       // Dart: alignCenter = false
    var applyErrorColor = props.applyErrorColor !== false;       // Dart: applyErrorColor = true
    var applyErrorAsterisk = props.applyErrorAsterisk !== false; // Dart: applyErrorAsterisk = true

    var showClear = text.length > 0 && focused; // Dart: _showClearButton

    function handleChange(e) {
      var v = e.target.value;
      if (!controlled) setText(v);
      if (props.onChanged) props.onChanged(v);
    }
    function handleKeyDown(e) {
      if (e.key === 'Enter' && props.onSubmitted) props.onSubmitted(e.target.value);
    }
    function handleFocus() { setFocused(true); }
    function handleBlur() { setFocused(false); }
    function handleClear() {
      // Dart: _defaultClear — controller.clear() + onChanged('')
      if (!controlled) setText('');
      if (props.onChanged) props.onChanged('');
      if (inputRef.current) inputRef.current.focus();
    }
    function handleBoxClick() {
      if (enabled && inputRef.current) inputRef.current.focus();
    }

    // suffixIcon tiene prioridad sobre el botón de borrado (Dart)
    var suffix = null;
    if (props.suffixIcon) {
      var suffixStyle = props.suffixIconColor ? { color: props.suffixIconColor } : undefined;
      suffix = h('span', { className: 'ds-tf-btn__suffix', style: suffixStyle, 'aria-hidden': true },
        icon({ name: props.suffixIcon, size: 16, color: 'currentColor' }));
    } else if (showClear) {
      var clearProps = {
        icon: props.iconButton || 'ic-cross',           // Dart: iconDataButton = DotsIconData.cross
        variant: props.buttonVariant || 'inverted',     // Dart: DotsCloseButtonVariant.inverted
        size: props.buttonSize || 'extraSmall',         // Dart: DotsCloseButtonSize.extraSmall
        onClick: props.onButtonClick || handleClear,    // Dart: onTapBtn ?? _defaultClear
      };
      suffix = h('span',
        {
          className: 'ds-tf-btn__clear',
          onMouseDown: function (e) { e.preventDefault(); }, // no robar el foco al input
        },
        __ds.DotsCloseButton
          ? h(__ds.DotsCloseButton, clearProps)
          : h('button', { type: 'button', className: 'ds-tf-btn__clear-fallback', onClick: clearProps.onClick, 'aria-label': 'Borrar texto' },
              icon({ name: clearProps.icon, size: 10, color: 'currentColor' }))
      );
    }

    var endButton = null;
    if (props.endButtonText != null) {
      var endStyle = props.endButtonTextColor ? { color: props.endButtonTextColor } : undefined;
      endButton = [
        h('span', { key: 'd', className: 'ds-tf-btn__end-divider' }),
        h('button',
          {
            key: 'b',
            type: 'button',
            className: 'ds-tf-btn__end-btn',
            style: endStyle,
            onMouseDown: function (e) { e.preventDefault(); },
            onClick: props.onEndButtonClick, // Dart: onEndButtonTap
          },
          props.endButtonText),
      ];
    }

    var inputCls =
      'ds-tf-btn__input' +
      (applyErrorColor && isError ? ' ds-tf-btn__input--error' : '') +
      (isError ? ' ds-tf-btn__input--hint-error' : '');

    return h(
      'div',
      { className: 'ds-tf-btn' + (alignCenter ? ' ds-tf-btn--center' : '') },
      h(
        'div',
        {
          className: 'ds-tf-btn__box' + (background ? '' : ' ds-tf-btn__box--no-bg'),
          onClick: handleBoxClick,
        },
        props.icon
          ? h('span',
              { className: 'ds-tf-btn__icon' + (isError ? ' ds-tf-btn__icon--error' : ''), 'aria-hidden': true },
              icon({ name: props.icon, size: 20, color: 'currentColor' }))
          : null,
        h('input', {
          ref: inputRef,
          className: inputCls,
          type: 'text',
          value: text,
          placeholder: props.hintText || '', // Dart: hintText = ''
          maxLength: props.maxTextLength,
          disabled: !enabled,
          autoFocus: !!props.autoFocus,
          autoCapitalize: props.textCapitalization || 'none', // Dart: TextCapitalization.none
          onChange: handleChange,
          onKeyDown: handleKeyDown,
          onFocus: handleFocus,
          onBlur: handleBlur,
        }),
        suffix,
        endButton
      ),
      isError && props.errorText != null
        ? h('div', { className: 'ds-tf-btn__error-text' },
            applyErrorAsterisk ? '* ' + props.errorText : props.errorText)
        : null
    );
  }

  return DotsTextFieldButton;
})();
