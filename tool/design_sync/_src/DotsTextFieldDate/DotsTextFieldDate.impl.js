// DotsTextFieldDate — port de lib/src/components/text_fields/dots_textfield_date.dart (Dart = fuente de verdad)
__ds.DotsTextFieldDate = (function () {
  'use strict';

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function DotsTextFieldDate(props) {
    var background = props.background !== false; // Dart: background = true
    var isError = !!props.isError;               // Dart: isError = false

    // Dart: buildTextWidget — chip bgSecondaryBtn r24, minWidth 56, padding 10x4,
    // bodyDefaultMedium, texto destructive si isError
    function chip(text) {
      if (!text) return null;
      return h('span',
        { className: 'ds-tf-date__chip' + (isError ? ' ds-tf-date__chip--error' : '') },
        text);
    }

    function handleKeyDown(e) {
      if ((e.key === 'Enter' || e.key === ' ') && props.onClick) {
        e.preventDefault();
        props.onClick();
      }
    }

    return h(
      'div',
      { className: 'ds-tf-date' },
      h(
        'div',
        {
          className: 'ds-tf-date__box' + (background ? '' : ' ds-tf-date__box--no-bg'),
          role: 'button',
          tabIndex: 0,
          onClick: props.onClick, // Dart: onTap
          onKeyDown: handleKeyDown,
        },
        props.icon
          ? h('span', { className: 'ds-tf-date__icon', 'aria-hidden': true },
              icon({ name: props.icon, size: 20, color: 'currentColor' }))
          : null,
        props.label ? h('span', { className: 'ds-tf-date__label' }, props.label) : null,
        h('span', { className: 'ds-tf-date__spacer' }),
        h('span', { className: 'ds-tf-date__chips' }, chip(props.date), chip(props.time))
      ),
      background && isError && props.errorText
        ? h('div', { className: 'ds-tf-date__error-text' }, props.errorText)
        : null
    );
  }

  return DotsTextFieldDate;
})();
