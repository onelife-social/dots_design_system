// ImageWithIcon — port de lib/src/components/notifications/image_with_icon.dart (Dart = fuente de verdad)
__ds.ImageWithIcon = (function () {
  'use strict';

  function ImageWithIcon(props) {
    var useState = hooks().useState;
    var errState = useState(false);
    var imgError = errState[0], setImgError = errState[1];

    var width = props.width == null ? 53 : props.width;
    var height = props.height == null ? 68 : props.height;
    var borderRadius = props.borderRadius == null ? 12 : props.borderRadius;
    var borderWidth = props.borderWidth == null ? 2 : props.borderWidth;
    var iconSize = props.iconSize == null ? 18 : props.iconSize;
    var circular = !!props.circularImage;
    var showIcon = props.showIcon !== false;

    var radius = circular ? width / 2 : borderRadius; // circularImage → width/2

    // Geometría del badge (idéntica al Dart)
    var iconBorderWidth = iconSize * 0.1;
    var iconContainerSize = iconSize * 1.5;
    var iconRadius = (iconContainerSize + iconBorderWidth) / 2;
    var iconPosition = -(props.iconOffset != null ? props.iconOffset : iconRadius) + iconBorderWidth;

    var hasImage = props.src != null && props.src !== '';
    var hasAliasText = !!props.aliasLabelImageText;

    var body = null;
    if (hasImage) {
      // Card + Image(fit: cover); loading/errorBuilder → defaultImage (default_user_item.webp)
      body = h('div', {
        className: 'ds-image-with-icon__card',
        style: { width: width + 'px', height: height + 'px', borderRadius: radius + 'px', '--ds-iwi-bw': borderWidth + 'px' },
      },
        imgError
          ? h('div', { className: 'ds-image-with-icon__default' })
          : h('img', {
              className: 'ds-image-with-icon__img',
              src: props.src,
              alt: '',
              onError: function (e) {
                setImgError(true); // Dart: errorBuilder → defaultImage
                if (props.onError) props.onError(e);
              },
            }),
        h('div', { className: 'ds-image-with-icon__gradient' })
      );
    } else if (hasAliasText) {
      // Contenedor bgSecondaryBtn con inicial — Nunito 600 40 textTertiary
      body = h('div', {
        className: 'ds-image-with-icon__alias',
        style: {
          width: width + 'px',
          height: height + 'px',
          borderRadius: circular ? '50%' : borderRadius + 'px',
        },
      }, h('span', {
        className: 'ds-image-with-icon__alias-text',
        style: props.aliasLabelImageTextStyle || null,
      }, props.aliasLabelImageText));
    }

    var badge = null;
    if (showIcon && props.icon) {
      badge = h('div', {
        className: 'ds-image-with-icon__badge',
        style: {
          top: iconPosition + 'px',
          right: iconPosition + 'px',
          width: (iconRadius * 2) + 'px',
          height: (iconRadius * 2) + 'px',
        },
      }, h('div', {
        className: 'ds-image-with-icon__badge-inner',
        style: {
          width: iconContainerSize + 'px',
          height: iconContainerSize + 'px',
          margin: iconBorderWidth + 'px',
        },
      },
        __ds.DotsIcon
          ? h(__ds.DotsIcon, { name: props.icon, size: iconSize, color: props.iconColor })
          : h('span', { style: { width: iconSize + 'px', height: iconSize + 'px', display: 'inline-block' } })
      ));
    }

    return h('div', {
      className: 'ds-image-with-icon' + (props.className ? ' ' + props.className : ''),
      style: { width: width + 'px', height: height + 'px' },
    }, body, badge);
  }

  return ImageWithIcon;
})();
