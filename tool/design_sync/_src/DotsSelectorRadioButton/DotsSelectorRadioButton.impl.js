// DotsSelectorRadioButton (+ DotsSelectorRadioButtonLabel, DotsSettingItemRadioBtn) — port de lib/src/components/selectors/ (Dart = fuente de verdad)
__ds.DotsSelectorRadioButton = (function () {
  'use strict';

  function radio(isSelected, size) {
    return __ds.DotsRadioButton
      ? h(__ds.DotsRadioButton, { isSelected: isSelected, size: size })
      : h('span', {
          className: 'ds-sel-radio-fallback' + (isSelected ? ' is-on' : ''),
          style: { width: size + 'px', height: size + 'px' },
        });
  }

  function detailIcon(name, size) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, { name: name, size: size, color: 'var(--text-tertiary)' })
      : null;
  }

  // DotsSelectorRadioButton — tarjeta con título + 2 filas icono/detalle + radio
  function DotsSelectorRadioButton(props) {
    var selected = !!props.isSelected;
    return h(
      'div',
      {
        className: 'ds-sel-card' + (selected ? ' is-selected' : ''),
        role: 'radio',
        'aria-checked': selected,
        tabIndex: 0,
        onClick: props.onClick,
      },
      h(
        'div',
        { className: 'ds-sel-card__body ds-sel-card__body--gap10' },
        h('div', { className: 'ds-sel-card__title' }, props.title),
        h(
          'div',
          { className: 'ds-sel-card__detail' },
          detailIcon(props.icon1 || 'ic-clock-filled', props.icon1Size || 16), // Dart: DotsIconData.clockFilled, 16
          props.details1,
        ),
        h(
          'div',
          { className: 'ds-sel-card__detail' },
          detailIcon(props.icon2 || 'ic-calendar', props.icon2Size || 16), // Dart: DotsIconData.calendar, 16
          props.details2,
        ),
      ),
      radio(selected, 24),
    );
  }

  // SelectorRadioButtonLabelVariant → BadgeLabelVariant (getBadgeLabelVariant en Dart)
  var BADGE_VARIANT = { free: 'main', acquired: 'green', premium: 'premium', premiumPlus: 'premiumPlus' };

  // DotsSelectorRadioButtonLabel — tarjeta con BadgeLabel + título serif + detalles
  function DotsSelectorRadioButtonLabel(props) {
    var selectable = props.isSelectable !== false;
    var selected = !!props.isSelected && selectable;
    var variant = BADGE_VARIANT[props.variant] ? props.variant : 'free';
    var badge = __ds.BadgeLabel
      ? h(__ds.BadgeLabel, { content: props.tagText, variant: BADGE_VARIANT[variant] })
      : h('span', { className: 'ds-sel-card__badge-ph' }, props.tagText);
    return h(
      'div',
      {
        className: 'ds-sel-card' + (selected ? ' is-selected' : ''),
        role: selectable ? 'radio' : undefined,
        'aria-checked': selectable ? selected : undefined,
        tabIndex: selectable ? 0 : undefined,
        onClick: selectable ? props.onClick : undefined,
      },
      h(
        'div',
        { className: 'ds-sel-card__body ds-sel-card__body--gap8' },
        h('div', null, badge),
        h(
          'div',
          null,
          h('div', { className: 'ds-sel-card__title-serif' }, props.title),
          h('div', { className: 'ds-sel-card__detail1' }, props.details1),
        ),
        h('div', { className: 'ds-sel-card__detail2' }, props.details2),
      ),
      selectable ? radio(selected, 24) : null,
    );
  }

  // DotsSettingItemRadioBtn — fila radio 22 + leading + trailing
  function DotsSettingItemRadioBtn(props) {
    var selected = !!props.isSelected;
    return h(
      'div',
      {
        className: 'ds-setting-radio',
        role: 'radio',
        'aria-checked': selected,
        tabIndex: 0,
        onClick: props.onClick,
      },
      radio(selected, 22),
      h('span', { className: 'ds-setting-radio__leading' }, props.leadingLabel),
      props.trailingLabel != null
        ? h('span', { className: 'ds-setting-radio__trailing' }, props.trailingLabel)
        : null,
    );
  }

  __ds.DotsSelectorRadioButtonLabel = DotsSelectorRadioButtonLabel;
  __ds.DotsSettingItemRadioBtn = DotsSettingItemRadioBtn;
  return DotsSelectorRadioButton;
})();
