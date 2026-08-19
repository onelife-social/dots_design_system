// ImageThumbnail — port de lib/src/components/image_thumbnail/image_thumbnail.dart (DotsImageThumbnail; Dart = fuente de verdad)
__ds.ImageThumbnail = (function () {
  'use strict';
  function ImageThumbnail(props) {
    var variant = props.variant || 'image'; // enum Dart DotsImageThumbnailVariant
    var isIcon = variant === 'icon';
    var size = props.size == null ? 40 : props.size;
    var iconSize = props.iconSize == null ? 20 : props.iconSize;
    return h(
      'span',
      {
        className:
          'ds-image-thumbnail' +
          (isIcon ? ' ds-image-thumbnail--icon' : '') +
          (props.className ? ' ' + props.className : ''),
        style: { width: size + 'px', height: size + 'px' },
      },
      !isIcon && props.src
        ? h('img', {
            className: 'ds-image-thumbnail__img',
            src: props.src,
            alt: props.alt || '',
            onError: props.onError,
          })
        : null,
      props.coverImage
        ? h('span', { className: 'ds-image-thumbnail__cover' })
        : null,
      isIcon
        ? h(
            'span',
            { className: 'ds-image-thumbnail__icon' },
            __ds.DotsIcon
              ? h(__ds.DotsIcon, {
                  name: props.icon || 'ic-user',
                  size: iconSize,
                  color: props.iconColor,
                })
              : null
          )
        : null
    );
  }
  return ImageThumbnail;
})();
