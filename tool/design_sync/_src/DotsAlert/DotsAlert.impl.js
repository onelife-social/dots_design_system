// DotsAlert — port de lib/src/components/alerts/ (Dart = fuente de verdad).
// Las factories Dart (DotsAlert.oneButton…) se expresan con la prop `variant`.
// El scrim full-screen (Stack + Positioned.fill negro 50%) es opt-in vía `showScrim`
// para poder componer la tarjeta suelta en diseños.
__ds.DotsAlert = (function () {
  'use strict';

  // DotsAlertVariant
  var VARIANTS = [
    'noButtons', 'oneButton', 'twoHorizontalButtons', 'twoHorizontalButtonsDestructive',
    'twoVerticalButtons', 'twoVerticalButtonsNoActive', 'twoVerticalButtonsDestructive',
    'input', 'selector',
  ];

  function dsIcon(name, size, color) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, { name: name, size: size, color: color })
      : h('span', { style: { width: size + 'px', height: size + 'px', display: 'inline-block' } });
  }

  // _mainButton: DotsMainButton(adaptPaddingForText, size large)
  function mainBtn(key, variant, text, onClick) {
    return __ds.DotsMainButton
      ? h(__ds.DotsMainButton, {
          key: key, label: text || '', variant: variant, size: 'large',
          adaptPaddingForText: true, onClick: onClick,
        })
      : h('button', { key: key, type: 'button', className: 'ds-alert__btn-fallback', onClick: onClick }, text || '');
  }

  function hasText(v) { return v != null && String(v).trim() !== ''; }

  function DotsAlert(props) {
    var useState = hooks().useState;
    var imgState = useState(false);
    var imgFailed = imgState[0], setImgFailed = imgState[1];

    var variant = VARIANTS.indexOf(props.variant) >= 0 ? props.variant : 'noButtons';
    var isInput = variant === 'input';
    var isSelector = variant === 'selector';
    var showCloseButton = !!props.showCloseButton;
    var showBlur = props.showBlurBackground !== false;

    // ── _icon: Padding(8) > chip 48×48 r24.5 bgHighlight, icono 24 labelHighlight;
    //    iconImage 48×48 cover con fallback al chip si falla (errorBuilder) ──
    var chip = h('div', { className: 'ds-alert__icon-chip' }, dsIcon(props.icon, 24));
    var iconContent = (props.iconImage && !imgFailed)
      ? h('img', {
          className: 'ds-alert__icon-img', src: props.iconImage, alt: '',
          onError: function () { setImgFailed(true); },
        })
      : chip;

    var header = h(
      'div', { className: 'ds-alert__header' },
      showCloseButton ? h('span', { className: 'ds-alert__header-spacer' }) : null,
      h('div', { className: 'ds-alert__icon-center' }, h('div', { className: 'ds-alert__icon-pad' }, iconContent)),
      showCloseButton
        ? (__ds.DotsCloseButton
            ? h(__ds.DotsCloseButton, { icon: 'ic-cross', size: 'medium', variant: 'softContrast', onClick: props.onClose })
            : h('button', { type: 'button', className: 'ds-alert__close-fallback', onClick: props.onClose, 'aria-label': 'Cerrar' }, '×'))
        : null
    );

    // ── _description según variante ──
    var description = null;
    if (isInput) {
      // DotsTextFieldButton(iconData: search): pilar 44 r1000 bgContainerSecondaryOnBackground
      description = h(
        'div', { className: 'ds-alert__input' },
        dsIcon('ic-search', 20, 'var(--text-tertiary)'),
        h('input', {
          className: 'ds-alert__input-el',
          type: 'text',
          placeholder: props.inputHint || '',
          onChange: props.onInputChanged
            ? function (e) { props.onInputChanged(e.target.value); }
            : undefined,
        })
      );
    } else if (isSelector) {
      var items = props.selectorItems || [];
      description = h(
        'div', { className: 'ds-alert__selector' },
        hasText(props.message) ? h('p', { className: 'ds-alert__msg ds-alert__selector-msg' }, props.message) : null,
        h('div', { className: 'ds-alert__list' }, items.map(function (it, i) {
          // DotsListsItem aproximado: thumb 40×40 + label bodyDefaultMedium
          return h(
            'button', { key: i, type: 'button', className: 'ds-alert__list-item', onClick: it.onClick },
            it.image
              ? h('img', { className: 'ds-alert__list-thumb', src: it.image, alt: '' })
              : h('span', { className: 'ds-alert__list-thumb' }),
            h('span', { className: 'ds-alert__list-label' }, it.label)
          );
        }))
      );
    } else if (hasText(props.message)) {
      description = h('p', { className: 'ds-alert__msg' }, props.message);
    }

    // ── _actions según variante ──
    var actions = null;
    switch (variant) {
      case 'oneButton':
        actions = h('div', { className: 'ds-alert__actions' },
          mainBtn('m', 'main', props.mainButtonText, props.onMainButtonClick));
        break;
      case 'twoHorizontalButtons':
      case 'twoHorizontalButtonsDestructive':
      case 'input':
      case 'selector':
        actions = h('div', { className: 'ds-alert__actions ds-alert__actions--row' },
          mainBtn('s', 'secondary', props.secondaryButtonText, props.onSecondaryButtonClick),
          mainBtn('m', variant === 'twoHorizontalButtonsDestructive' ? 'destructive' : 'main',
            props.mainButtonText, props.onMainButtonClick));
        break;
      case 'twoVerticalButtons':
        actions = h('div', { className: 'ds-alert__actions ds-alert__actions--col' },
          mainBtn('m', 'main', props.mainButtonText, props.onMainButtonClick),
          mainBtn('s', 'ghost', props.secondaryButtonText, props.onSecondaryButtonClick));
        break;
      case 'twoVerticalButtonsDestructive':
        actions = h('div', { className: 'ds-alert__actions ds-alert__actions--col' },
          mainBtn('m', 'destructive', props.mainButtonText, props.onMainButtonClick),
          mainBtn('s', 'ghost', props.secondaryButtonText, props.onSecondaryButtonClick));
        break;
      case 'twoVerticalButtonsNoActive':
        actions = h('div', { className: 'ds-alert__actions ds-alert__actions--col ds-alert__actions--gap8' },
          mainBtn('m', 'secondary', props.mainButtonText, props.onMainButtonClick),
          mainBtn('s', 'secondary', props.secondaryButtonText, props.onSecondaryButtonClick));
        break;
      default: // noButtons
        actions = null;
    }

    var card = h(
      'div',
      {
        className: 'ds-alert ds-alert--' + variant + (showBlur ? ' ds-alert--blur' : '') +
          (props.className ? ' ' + props.className : ''),
        role: 'alertdialog',
        'aria-label': props.title,
      },
      header,
      h(
        'div', { className: 'ds-alert__body' },
        hasText(props.title) ? h('p', { className: 'ds-alert__title' }, props.title) : null,
        description
      ),
      actions
    );

    if (!props.showScrim) return card;
    // Stack: Positioned.fill negro 50% + tarjeta centrada; tap fuera cierra
    return h(
      'div',
      {
        className: 'ds-alert__scrim',
        onClick: function (e) {
          if (e.target === e.currentTarget && props.enableCloseOnTapOutside !== false && props.onClose) props.onClose();
        },
      },
      card
    );
  }

  return DotsAlert;
})();
