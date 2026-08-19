// EventGroupCard — port de lib/src/components/cards/group_cards/event_group_card.dart (Dart = fuente de verdad)
__ds.EventGroupCard = (function () {
  'use strict';
  var VARIANTS = { small: true, active: true, passed: true }; // EventGroupCardVariant

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  // Evita que los taps internos disparen también el onClick de la tarjeta
  function stopWrap(fn) {
    if (!fn) return undefined;
    return function (e) { if (e && e.stopPropagation) e.stopPropagation(); fn(e); };
  }

  function EventGroupCard(props) {
    var variant = VARIANTS[props.variant] ? props.variant : 'small'; // Dart: default small
    var isSmall = variant === 'small';
    // Dart: AspectRatio 1:1 con constraints 135–160 (small) / 288–340 (resto)
    var size = props.size == null ? (isSmall ? 148 : 288) : props.size;
    var edge = props.edgeSize == null ? (isSmall ? 60 : 110) : props.edgeSize;
    var actions = props.actions || [];
    var isBlocked = !!props.isBlocked;

    var children = [
      h('div', {
        key: 'img',
        className: 'ds-event-card__img' + (props.imageSrc ? '' : ' ds-event-card__img--ph'),
        style: props.imageSrc ? { backgroundImage: 'url("' + props.imageSrc + '")' } : null,
      }),
      h('div', { key: 'fade', className: 'ds-event-card__fade', style: { height: edge + 'px' } }),
    ];
    if (!isSmall) children.push(h('div', { key: 'top', className: 'ds-event-card__top-grad' }));

    if (isSmall) {
      children.push(h('div', { key: 'ttl', className: 'ds-event-card__title--small' }, props.title || ''));
    }

    if (!isBlocked && props.tagIcon) {
      children.push(h('span', {
        key: 'tag',
        className: 'ds-event-card__tag ' + (isSmall ? 'ds-event-card__tag--small' : 'ds-event-card__tag--big'),
      }, icon({ name: props.tagIcon, size: 20, color: 'currentColor' })));
    }
    if (isBlocked) {
      children.push(h('div', { key: 'lock', className: 'ds-event-card__lock' },
        icon({ name: 'ic-lock', size: 32, color: 'currentColor' })));
    }

    if (!isSmall) {
      var secondary;
      if (variant === 'active') {
        // punto 3×3 + labelSmallRegular blanco 70%
        secondary = h('div', {
          className: 'ds-event-card__sec',
          onClick: stopWrap(props.onSecondaryClick),
        }, h('span', { className: 'ds-event-card__sec-dot' }), props.secondaryText || '');
      } else {
        // passed → DotsMainButton secondary small con ic-exit-fullscreen (iconSize 14, texto blanco)
        secondary = h('div', { className: 'ds-event-card__sec-wrap' },
          __ds.DotsMainButton
            ? h(__ds.DotsMainButton, {
                label: props.secondaryText || '',
                variant: 'secondary',
                size: 'small',
                icon: 'ic-exit-fullscreen',
                iconSize: 14,
                textColor: '#FFFFFF', // labelAlwaysWhite
                iconColor: '#FFFFFF',
                expand: false,
                onClick: stopWrap(props.onSecondaryClick),
              })
            : h('button', {
                type: 'button',
                className: 'ds-event-card__sec-fb',
                onClick: stopWrap(props.onSecondaryClick),
              }, props.secondaryText || ''));
      }
      children.push(h('div', { key: 'head', className: 'ds-event-card__head' },
        h('div', { className: 'ds-event-card__head-title' }, props.title || ''),
        secondary));

      // _MenuEvent — píldora blur50 bgBtnDisabled con acciones (Dart la pinta vacía; aquí se omite sin acciones)
      if (actions.length) {
        var items = [];
        actions.forEach(function (a, i) {
          if (i > 0) items.push(h('span', { key: 's' + i, className: 'ds-event-card__sep' }));
          items.push(h('button', {
            key: 'a' + i,
            type: 'button',
            className: 'ds-event-card__act',
            onClick: stopWrap(a.onClick),
          }, icon({ name: a.icon, size: 20, color: 'currentColor' }), h('span', null, a.text)));
        });
        children.push(h('div', { key: 'menu', className: 'ds-event-card__menu' }, items));
      }
    }

    return h('div', {
      className: 'ds-event-card ds-event-card--' + variant + (props.className ? ' ' + props.className : ''),
      style: { width: size + 'px', height: size + 'px' },
      onClick: props.onClick,
      role: props.onClick ? 'button' : undefined,
    }, children);
  }

  return EventGroupCard;
})();
