// RecapCard — port de lib/src/components/cards/recap/ (recap_card.dart + recap_card_locked.dart
// unificados vía prop `locked`; CountdownRecap de countdown_recap.dart embebido). Dart = fuente de verdad.
__ds.RecapCard = (function () {
  'use strict';
  var VARIANTS = { active: true, blocked: true, generated: true, onlyTitle: true }; // RecapCardVariant
  var LOCKED_VARIANTS = { countdown: true, locked: true, soon: true };             // RecapCardLockedVariant

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function stopWrap(fn) {
    if (!fn) return undefined;
    return function (e) { if (e && e.stopPropagation) e.stopPropagation(); fn(e); };
  }

  function pad2(n) { return (n < 10 ? '0' : '') + n; }

  function mainButton(p, fbClass) {
    return __ds.DotsMainButton
      ? h(__ds.DotsMainButton, p)
      : h('button', { type: 'button', className: fbClass, onClick: p.onClick },
          p.icon ? icon({ name: p.icon, size: 16, color: 'currentColor' }) : null, p.label);
  }

  function imageLayer(props, blurred) {
    return h('div', {
      className: 'ds-recap-card__img' + (props.imageSrc ? '' : ' ds-recap-card__img--ph') + (blurred ? ' ds-recap-card__img--blur' : ''),
      style: props.imageSrc ? { backgroundImage: 'url("' + props.imageSrc + '")' } : null,
    });
  }

  function RecapCard(props) {
    var R = hooks();
    var useState = R.useState, useEffect = R.useEffect;
    var locked = !!props.locked;
    var lockedVariant = LOCKED_VARIANTS[props.lockedVariant] ? props.lockedVariant : 'countdown';
    var variant = VARIANTS[props.variant] ? props.variant : 'active'; // Dart: factories; default web active
    var width = props.width == null ? 220 : props.width;

    // CountdownRecap — tick de 1s mientras quede tiempo (Dart: Timer.periodic)
    var target = (locked && lockedVariant === 'countdown' && props.countdownDate)
      ? new Date(props.countdownDate).getTime()
      : 0;
    var tick = useState(0);
    useEffect(function () {
      if (!target || target - Date.now() <= 0) return undefined;
      var id = setInterval(function () {
        if (target - Date.now() <= 0) clearInterval(id);
        tick[1](function (n) { return n + 1; });
      }, 1000);
      return function () { clearInterval(id); };
    }, [target]);
    var remaining = target ? Math.max(0, target - Date.now()) : 0;

    return locked
      ? renderLocked(props, lockedVariant, width, remaining)
      : renderUnlocked(props, variant, width);
  }

  // ---- RecapCard (recap_card.dart): 4:5, squircle52, overlay negro 30% + borde 2 borderButton ----
  function renderUnlocked(props, variant, width) {
    var isBlocked = variant === 'blocked';
    var isGenerated = variant === 'generated';
    var isOnlyTitle = variant === 'onlyTitle'; // Dart: active sin título/badge/botón

    var title = isOnlyTitle ? null : props.title;
    var badgeText = isOnlyTitle ? null : props.badgeText;
    var buttonText = isOnlyTitle ? null : props.buttonText;

    // Lado derecho de la fila superior (badge premium / share / lock)
    var control = null;
    if (!isBlocked && badgeText) {
      control = __ds.BadgeLabel
        ? h(__ds.BadgeLabel, { content: badgeText, variant: 'premium', size: 'large' })
        : h('span', { className: 'ds-recap-card__badge-fb' }, badgeText);
    } else if (isGenerated && !badgeText) {
      // DotsIconButton floating large Ø44 · icono share 24 · textPrimary
      control = h('button', {
        type: 'button', className: 'ds-recap-card__icon-btn', onClick: stopWrap(props.onInfoClick),
        'aria-label': 'share',
      }, icon({ name: 'ic-share', size: 24, color: 'currentColor' }));
    } else if (isBlocked) {
      // DotsIconButton floating large Ø44 · lock · bgBtnImage al 50%
      control = h('button', {
        type: 'button', className: 'ds-recap-card__icon-btn ds-recap-card__icon-btn--half', onClick: stopWrap(props.onInfoClick),
        'aria-label': 'lock',
      }, icon({ name: 'ic-lock', size: 24, color: 'currentColor' }));
    }

    // Zona inferior: createdBy (generated) o DotsMainButton main con blur
    var bottom = null;
    if (isGenerated) {
      bottom = h('div', { className: 'ds-recap-card__created-by' },
        props.albumName ? h('span', null, props.albumName) : null,
        props.createdBy ? h('span', null, props.createdBy) : null);
    } else if (buttonText) {
      bottom = mainButton({
        label: buttonText, variant: 'main', expand: false, shouldApplyBlur: true,
        onClick: stopWrap(props.onClick),
      }, 'ds-recap-card__cta-fb');
    }

    return h('div', {
      className: 'ds-recap-card' + (props.className ? ' ' + props.className : ''),
      style: { width: width + 'px' },
      onClick: props.onClick,
      role: props.onClick ? 'button' : undefined,
    },
      imageLayer(props, isBlocked), // blocked → ImageFilter.blur(15)
      h('div', { className: 'ds-recap-card__overlay' },
        props.textImageSrc ? h('div', {
          className: 'ds-recap-card__text-img',
          style: { backgroundImage: 'url("' + props.textImageSrc + '")' },
        }) : null),
      h('div', { className: 'ds-recap-card__inner' },
        h('div', { className: 'ds-recap-card__title-row' },
          title
            ? h('span', { className: 'ds-recap-card__ttl' },
                icon({ name: 'ic-clock--timer', size: 16, color: 'currentColor' }), title)
            : h('span', null),
          control),
        h('div', { className: 'ds-recap-card__bottom' }, bottom))
    );
  }

  // ---- RecapCardLocked (recap_card_locked.dart): 7:8, squircle52, pad 20, CountdownRecap ----
  function renderLocked(props, lockedVariant, width, remaining) {
    var showTimes = lockedVariant === 'countdown' && remaining > 0;
    var body;
    if (showTimes) {
      var d = Math.floor(remaining / 86400000);
      var hrs = Math.floor(remaining / 3600000) % 24;
      var min = Math.floor(remaining / 60000) % 60;
      var sec = Math.floor(remaining / 1000) % 60;
      body = h('div', { className: 'ds-recap-card__times' },
        timeItem(pad2(d), props.daysLabel),
        timeItem(pad2(hrs), props.hoursLabel),
        timeItem(pad2(min), props.minutesLabel),
        timeItem(pad2(sec), props.secondsLabel));
    } else {
      // Dart: countdown terminado (o variantes locked/soon) → descripción
      body = h('div', { className: 'ds-recap-card__cd-desc' }, props.description || '');
    }

    return h('div', {
      className: 'ds-recap-card ds-recap-card--locked' + (props.className ? ' ' + props.className : ''),
      style: { width: width + 'px' },
    },
      imageLayer(props, !!props.blurImage), // blurImageProvider → ImageFilter.blur(15)
      h('div', { className: 'ds-recap-card__inner' },
        lockedVariant !== 'soon'
          ? h('button', {
              type: 'button',
              className: 'ds-recap-card__icon-btn ds-recap-card__icon-btn--medium ds-recap-card__info',
              onClick: props.onInfoClick,
              'aria-label': 'info',
            }, icon({ name: 'ic-info', size: 20, color: 'currentColor' }))
          : null,
        // CountdownRecap — w192 r24 borde blanco 30% + blur20
        h('div', { className: 'ds-recap-card__countdown' },
          h('span', { className: 'ds-recap-card__cd-lock' }, icon({ name: 'ic-lock', size: 20, color: 'currentColor' })),
          h('div', { className: 'ds-recap-card__cd-ttl' }, props.title || ''),
          body),
        lockedVariant === 'locked' && props.buttonText
          ? h('div', { className: 'ds-recap-card__bottom' },
              mainButton({
                label: props.buttonText, variant: 'main', expand: false, icon: 'ic-gallery',
                onClick: props.onButtonClick,
              }, 'ds-recap-card__cta-fb'))
          : null)
    );
  }

  function timeItem(value, label) {
    return h('span', { className: 'ds-recap-card__t' },
      h('span', { className: 'ds-recap-card__t-v' }, value),
      h('span', { className: 'ds-recap-card__t-l' }, label || ''));
  }

  return RecapCard;
})();
