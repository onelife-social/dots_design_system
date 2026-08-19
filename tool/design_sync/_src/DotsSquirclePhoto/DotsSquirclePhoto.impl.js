// DotsSquirclePhoto — port de lib/src/components/photos_components/dots_squircle_photo.dart
// (Dart: DotsSquircleImage) + dots_squircle_photo_tag.dart (Dart: DotsSquircleImageTag)
// expuesto como DotsSquirclePhoto.Tag. Dart = fuente de verdad.
__ds.DotsSquirclePhoto = (function () {
  'use strict';

  function gradVariant(seed) {
    var s = String(seed == null ? '' : seed);
    var n = 0;
    for (var i = 0; i < s.length; i++) n = (n + s.charCodeAt(i)) % 997;
    return 'abcd'[n % 4];
  }

  function radiusPx(borderRadius, fallback) {
    if (borderRadius == null) return fallback + 'px';
    return typeof borderRadius === 'number' ? borderRadius + 'px' : borderRadius;
  }

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', {
          style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' },
        });
  }

  function DotsSquirclePhoto(props) {
    var useState = hooks().useState;
    var errState = useState(false);
    var hasError = errState[0];
    var setError = errState[1];

    var size = props.size == null ? 52 : props.size;              // Dart default 52
    var br = radiusPx(props.borderRadius, 16);                    // DotsBorderRadius.r16
    var hideBorder = props.hideBorder !== false;                  // Dart default true
    var borderSize = props.borderSize == null ? 1 : props.borderSize;
    var showImg = !!props.src && !hasError;

    return h(
      'span',
      {
        className: 'ds-squircle-photo' + (props.className ? ' ' + props.className : ''),
        style: { width: size + 'px', height: size + 'px', borderRadius: br },
        onClick: props.onClick,
      },
      showImg
        ? h('img', {
            className: 'ds-squircle-photo__img',
            src: props.src,
            alt: props.alt || '',
            onError: function (e) {
              setError(true);
              if (props.onError) props.onError(e);
            },
          })
        : h('span', {
            className:
              'ds-squircle-photo__ph ds-squircle-photo__ph--' + gradVariant(props.src || props.alt),
          }),
      // hideBorder: false → borde bgBtnImage (la opacidad 0.6 del Dart ya viene en el token)
      !hideBorder
        ? h('span', {
            className: 'ds-squircle-photo__border',
            style: {
              borderRadius: br,
              borderWidth: borderSize + 'px',
              borderColor: props.borderColor || undefined,
            },
          })
        : null,
      // uploadError → overlay negro 20% + icono cloudFail 24 labelAlwaysWhite
      props.uploadError
        ? h(
            'span',
            { className: 'ds-squircle-photo__error' },
            icon({
              name: props.uploadErrorIcon || 'ic-cloud-fail',
              size: 24,
              color: 'var(--label-always-white)',
            })
          )
        : null
    );
  }

  // DotsSquircleImageTag — lienzo (size+10)², imagen con borde + círculo tag 40 abajo-derecha
  function Tag(props) {
    var size = props.size == null ? 100 : props.size;              // Dart default 100
    var tagCircleSize = props.tagCircleSize == null ? 40 : props.tagCircleSize;
    var iconSize = props.iconSize == null ? 24 : props.iconSize;

    return h(
      'span',
      {
        className: 'ds-squircle-photo-tag' + (props.className ? ' ' + props.className : ''),
        style: { width: size + 10 + 'px', height: size + 10 + 'px' },
        onClick: props.onClick,
      },
      h(DotsSquirclePhoto, {
        src: props.src,
        alt: props.alt,
        onError: props.onError,
        size: size,
        borderRadius: props.borderRadius == null ? 24 : props.borderRadius, // r24
        hideBorder: false,
        borderSize: props.borderSize == null ? 2 : props.borderSize,
        borderColor: props.borderColor || 'var(--label-always-white)',
      }),
      h(
        'span',
        {
          className: 'ds-squircle-photo-tag__circle',
          style: { width: tagCircleSize + 'px', height: tagCircleSize + 'px' },
        },
        icon({
          name: props.icon || 'ic-calendar--check',               // DotsIconData.calendarCheck
          size: iconSize,
          color: props.iconColor || 'var(--label-always-white)',
        })
      )
    );
  }

  DotsSquirclePhoto.Tag = Tag;
  return DotsSquirclePhoto;
})();
