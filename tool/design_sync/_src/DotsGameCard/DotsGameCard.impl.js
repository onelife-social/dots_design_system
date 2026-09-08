// DotsGameCard — port de lib/src/components/cards/game_card/game_card.dart (Dart = fuente de verdad)
__ds.DotsGameCard = (function () {
  'use strict';

  // Dart _badgeVariant: un BadgeLabel distinto por estado.
  var BADGE_VARIANT = {
    processing: 'secondary',
    error: 'warningMaterial',
    active: 'greenMaterial',
  };

  function badge(text, variant) {
    if (__ds.BadgeLabel) {
      return h(__ds.BadgeLabel, { content: text, size: 'medium', variant: variant });
    }
    return h('span', { className: 'ds-game-card__badge-fb' }, text);
  }

  // El paquete Dart no trae spinner indeterminado y deja el indicador al host
  // (DotsSpinner es determinado y pinta en blanco, invisible sobre bgStrong).
  // Este anillo es solo el placeholder de diseño cuando no llega progressIndicator.
  function defaultIndicator() {
    return h('span', { className: 'ds-game-card__spinner' });
  }

  function action(props, status) {
    if (status !== 'processing') {
      return __ds.DotsMainButton
        ? h(__ds.DotsMainButton, {
            label: props.actionText,
            size: 'large',
            expand: false,
            onClick: props.onActionClick,
          })
        : h('button', {
            className: 'ds-game-card__action-fb',
            onClick: props.onActionClick,
          }, props.actionText);
    }
    // Dart: en processing la card informa y NO se pulsa — onActionTap se ignora.
    var indicator = props.progressIndicator === undefined
      ? defaultIndicator()
      : props.progressIndicator;
    var row = [];
    if (indicator) row.push(h('span', { key: 'pi', className: 'ds-game-card__progress' }, indicator));
    row.push(h('span', { key: 'tx', className: 'ds-game-card__progress-text' }, props.actionText));
    return h('div', { className: 'ds-game-card__processing' }, row);
  }

  function DotsGameCard(props) {
    var status = props.status || 'active';

    var art = props.image !== undefined
      ? props.image
      : (props.imageSrc
          ? h('img', { className: 'ds-game-card__img', src: props.imageSrc, alt: props.imageAlt || '' })
          : h('div', { className: 'ds-game-card__img ds-game-card__img--ph' }));

    return h('div', {
      className: 'ds-game-card' + (props.className ? ' ' + props.className : ''),
    }, [
      h('div', { key: 'art', className: 'ds-game-card__art' }, art),
      h('div', { key: 'content', className: 'ds-game-card__content' }, [
        h('div', { key: 'badge', className: 'ds-game-card__badge' },
          badge(props.badgeText, BADGE_VARIANT[status] || BADGE_VARIANT.active)),
        h('div', { key: 'title', className: 'ds-game-card__title' }, props.title || ''),
        h('div', { key: 'desc', className: 'ds-game-card__desc' }, props.description || ''),
      ]),
      h('div', { key: 'action', className: 'ds-game-card__action' }, action(props, status)),
    ]);
  }

  return DotsGameCard;
})();
