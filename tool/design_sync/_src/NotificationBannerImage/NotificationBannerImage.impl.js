// NotificationBannerImage — port de lib/src/components/notifications/notification_banner_image.dart (Dart = fuente de verdad)
__ds.NotificationBannerImage = (function () {
  'use strict';

  var BTN_SIZES = { mainAction: 1, large: 1, medium: 1, small: 1 };

  function NotificationBannerImage(props) {
    var useState = hooks().useState;
    var errState = useState(false);
    var imgError = errState[0], setImgError = errState[1];

    var imagePadding = props.imagePadding == null ? 20 : props.imagePadding;
    var showClose = props.showCloseButton !== false;
    var isBtnActive = props.isBtnActive !== false;
    var btnSize = BTN_SIZES[props.actionButtonSize] ? props.actionButtonSize : 'medium';
    var clickable = typeof props.onActionClick === 'function';

    // Image(fit: cover) — imageSize opcional (cuadrada); errorBuilder → SizedBox.shrink
    var imageEl = null;
    if (props.src && !imgError) {
      var imgStyle = props.imageSize != null
        ? { width: props.imageSize + 'px', height: props.imageSize + 'px' }
        : null;
      imageEl = h('img', {
        className: 'ds-notif-banner-img__img' + (props.imageSize != null ? ' ds-notif-banner-img__img--sized' : ''),
        src: props.src,
        alt: '',
        style: imgStyle,
        onError: function (e) {
          setImgError(true); // Dart: errorBuilder → SizedBox.shrink()
          if (props.onError) props.onError(e);
        },
      });
    } else if (!props.src) {
      // Sin src (en Dart imageProvider es required): placeholder degradado como screens/home.html
      var phStyle = props.imageSize != null
        ? { width: props.imageSize + 'px', height: props.imageSize + 'px' }
        : null;
      imageEl = h('div', { className: 'ds-notif-banner-img__placeholder', style: phStyle });
    }

    // RichText: description (textTertiary) + ' appendedDescription' (labelHighlight)
    var descEl = null;
    if (props.description) {
      descEl = h('div', { className: 'ds-notif-banner-img__desc' },
        props.description,
        props.appendedDescription
          ? h('span', { className: 'ds-notif-banner-img__desc-appended' }, ' ' + props.appendedDescription)
          : null
      );
    }

    var actionEl = null;
    if (props.actionButtonText) {
      // stopPropagation: en Dart el GestureDetector interno del botón gana al del banner (un solo tap)
      actionEl = h('div', {
        className: 'ds-notif-banner-img__action',
        onClick: function (e) { e.stopPropagation(); },
      },
        __ds.DotsMainButton
          ? h(__ds.DotsMainButton, {
              label: props.actionButtonText,
              size: btnSize,
              variant: isBtnActive ? 'main' : 'secondary',
              expand: false,
              onClick: props.onActionClick,
            })
          : h('button', {
              type: 'button',
              className: 'ds-notif-banner-img__action-fallback',
              onClick: props.onActionClick,
            }, props.actionButtonText)
      );
    }

    var closeEl = null;
    if (showClose) {
      closeEl = h('div', {
        className: 'ds-notif-banner-img__close',
        onClick: function (e) { e.stopPropagation(); }, // que cerrar no dispare onActionClick del banner
      },
        __ds.DotsCloseButton
          ? h(__ds.DotsCloseButton, {
              icon: 'ic-cross',
              size: 'medium',
              variant: 'softContrast',
              onClick: props.onClose,
            })
          : h('button', {
              type: 'button',
              className: 'ds-notif-banner-img__close-fallback',
              'aria-label': 'Cerrar',
              onClick: function (e) {
                e.stopPropagation();
                if (props.onClose) props.onClose();
              },
            }, '×')
      );
    }

    // Dart: si onActionTap != null, todo el banner es GestureDetector(onTap: onActionTap)
    return h('div',
      {
        className: 'ds-notif-banner-img' +
          (clickable ? ' ds-notif-banner-img--clickable' : '') +
          (props.className ? ' ' + props.className : ''),
        onClick: clickable ? props.onActionClick : undefined,
      },
      imageEl
        ? h('div', {
            className: 'ds-notif-banner-img__img-wrap',
            style: { paddingLeft: imagePadding + 'px', paddingRight: imagePadding + 'px' },
          }, imageEl)
        : null,
      h('div', { className: 'ds-notif-banner-img__content' },
        h('div', { className: 'ds-notif-banner-img__title' }, props.title),
        descEl,
        actionEl
      ),
      closeEl
    );
  }

  return NotificationBannerImage;
})();
