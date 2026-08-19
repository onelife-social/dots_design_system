// DotsTextFieldPhone — port de lib/src/components/text_fields/dots_textfield_phone.dart (Dart = fuente de verdad)
__ds.DotsTextFieldPhone = (function () {
  'use strict';

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function DotsTextFieldPhone(props) {
    var enabled = props.enabled !== false; // Dart: enabled = true
    var cc = props.countryCode || { dialCode: '', flagEmoji: '' };

    function handleCountryClick(e) {
      e.stopPropagation(); // no robar el click al box (que enfoca el input)
      if (enabled && props.onCountryTap) props.onCountryTap();
    }

    // Dart: leading = flag + ' (dialCode)' + chevron-down 14 + divisor 0.5 labelSecondary·0.3
    var leading = h(
      'span',
      {
        className: 'ds-tf-phone__lead' + (enabled ? '' : ' ds-tf-phone__lead--disabled'),
        role: 'button',
        tabIndex: enabled ? 0 : undefined,
        onClick: handleCountryClick,
        onKeyDown: function (e) {
          if ((e.key === 'Enter' || e.key === ' ') && enabled && props.onCountryTap) {
            e.preventDefault();
            props.onCountryTap();
          }
        },
      },
      h('span', { className: 'ds-tf-phone__flag' }, cc.flagEmoji),
      h('span', { className: 'ds-tf-phone__dial' }, ' (' + cc.dialCode + ')'),
      h('span', { className: 'ds-tf-phone__chev', 'aria-hidden': true },
        icon({ name: 'ic-chevron-down', size: 14, color: 'currentColor' })),
      h('span', { className: 'ds-tf-phone__divider' })
    );

    var TF = __ds.DotsTextField;
    if (!TF) {
      // Fallback si DotsTextField no está en el bundle
      return h('div', { className: 'ds-tf-phone__fallback' }, leading, props.hintText || '');
    }

    // Dart: delega en DotsTextField con keyboardType phone + digitsOnly
    return h(TF, {
      leading: leading,
      value: props.value,
      defaultValue: props.defaultValue,
      hintText: props.hintText,
      addHintTextColorError: props.addHintTextColorError,
      onChanged: props.onChanged,
      onSubmitted: props.onSubmitted,
      onFocusLost: props.onFocusLost,
      maxTextLength: props.maxTextLength,
      isError: props.isError,
      errorText: props.errorText,
      enabled: enabled,
      background: props.background,
      showUnderline: props.showUnderline,
      keyboardType: 'phone', // TextInputType.phone → type=tel/inputMode tel
      autoFocus: props.autoFocus,
    });
  }

  return DotsTextFieldPhone;
})();
