// NotificationBanner — port de lib/src/components/notifications/notification_banner.dart (Dart = fuente de verdad)
__ds.NotificationBanner = (function () {
  'use strict';

  function NotificationBanner(props) {
    var showClose = props.showCloseButton !== false;

    // DotsMainButton(content, size: medium, variant: main, expand: false)
    var actionEl = null;
    if (props.actionButtonText != null && props.actionButtonText !== '') {
      actionEl = h('div', { className: 'ds-notif-banner__action' },
        __ds.DotsMainButton
          ? h(__ds.DotsMainButton, {
              label: props.actionButtonText,
              size: 'medium',
              variant: 'main',
              expand: false,
              onClick: props.onActionClick,
            })
          : h('button', {
              type: 'button',
              className: 'ds-notif-banner__action-fallback',
              onClick: props.onActionClick,
            }, props.actionButtonText)
      );
    }

    // DotsCloseButton(icon: cross, size: medium, variant: softContrast) — Positioned top 12 right 12
    var closeEl = null;
    if (showClose) {
      closeEl = h('div', { className: 'ds-notif-banner__close' },
        __ds.DotsCloseButton
          ? h(__ds.DotsCloseButton, {
              icon: 'ic-cross',
              size: 'medium',
              variant: 'softContrast',
              onClick: props.onClose,
            })
          : h('button', {
              type: 'button',
              className: 'ds-notif-banner__close-fallback',
              onClick: props.onClose,
              'aria-label': 'Cerrar',
            }, '×')
      );
    }

    return h('div',
      { className: 'ds-notif-banner' + (props.className ? ' ' + props.className : '') },
      h('div', { className: 'ds-notif-banner__title' }, props.title),
      props.body != null
        ? h('div', { className: 'ds-notif-banner__body' }, props.body)
        : null,
      actionEl,
      closeEl
    );
  }

  return NotificationBanner;
})();
