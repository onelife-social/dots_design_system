// DotsTextArea — port de lib/src/components/text_fields/dots_textarea.dart (Dart = fuente de verdad)
__ds.DotsTextArea = (function () {
  'use strict';

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function DotsTextArea(props) {
    var R = hooks();
    var controlled = props.value !== undefined && props.value !== null;
    var innerState = R.useState(props.defaultValue != null ? String(props.defaultValue) : '');
    var areaRef = R.useRef(null);

    var text = controlled ? String(props.value) : innerState[0];
    var setText = innerState[1];

    var hasLabel = !!props.label;
    var hasIcon = !!props.icon;
    var isError = !!props.isError;

    function handleChange(e) {
      var v = e.target.value;
      if (!controlled) setText(v);
      if (props.onChanged) props.onChanged(v);
    }
    function handleKeyDown(e) {
      // Dart: keyboardType multiline — Enter inserta salto; submit web = Ctrl/Cmd+Enter
      if (e.key === 'Enter' && (e.metaKey || e.ctrlKey) && props.onSubmitted) props.onSubmitted(e.target.value);
    }
    function handleBoxClick() {
      // Dart: GestureDetector → focusNode.requestFocus()
      if (areaRef.current) areaRef.current.focus();
    }

    // Dart: minHeight = minHeight ?? maxHeight ?? 50; maxHeight → scroll interno
    var boxStyle = {
      minHeight: (props.minHeight != null ? props.minHeight : (props.maxHeight != null ? props.maxHeight : 50)) + 'px',
    };
    if (props.maxHeight != null) boxStyle.maxHeight = props.maxHeight + 'px';

    // Dart: remaining = (maxTextLength - text.length).clamp(0, maxTextLength)
    var remaining = null;
    if (props.maxTextLength != null) {
      remaining = Math.min(Math.max(props.maxTextLength - text.length, 0), props.maxTextLength);
    }

    var area = h(
      'div',
      { className: 'ds-textarea__grow', 'data-value': text },
      h('textarea', {
        ref: areaRef,
        className: 'ds-textarea__input',
        value: text,
        rows: 1,
        placeholder: props.hintText,
        maxLength: props.maxTextLength,
        autoFocus: !!props.autoFocus,
        autoCapitalize: props.textCapitalization || 'none', // Dart: TextCapitalization.none
        onChange: handleChange,
        onKeyDown: handleKeyDown,
      })
    );

    var leadingIcon = hasIcon
      ? h('span', { className: 'ds-textarea__icon', 'aria-hidden': true },
          icon({ name: props.icon, size: 20, color: 'currentColor' }))
      : null;

    var body;
    if (hasLabel) {
      body = [
        h('div', { key: 'l', className: 'ds-textarea__label' }, leadingIcon, props.label),
        h('div', { key: 'b', className: 'ds-textarea__body' + (hasIcon ? ' ds-textarea__body--indent' : '') }, area),
      ];
    } else {
      body = h('div', { className: 'ds-textarea__row' },
        leadingIcon,
        h('div', { className: 'ds-textarea__body' }, area)
      );
    }

    return h(
      'div',
      { className: 'ds-textarea' },
      h('div', { className: 'ds-textarea__box', style: boxStyle, onClick: handleBoxClick },
        body,
        remaining != null ? h('span', { className: 'ds-textarea__counter' }, String(remaining)) : null
      ),
      isError && props.errorText ? h('div', { className: 'ds-textarea__error-text' }, props.errorText) : null
    );
  }

  return DotsTextArea;
})();
