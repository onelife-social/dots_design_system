// DotsProfilePhoto — port de lib/src/components/photos_components/dots_profile_photo.dart
// (+ dots_profile_photo_bited.dart como variante `bited`). Dart = fuente de verdad.
__ds.DotsProfilePhoto = (function () {
  'use strict';

  // Placeholder degradado determinista cuando no hay `src` (o falla la carga)
  function gradVariant(seed) {
    var s = String(seed == null ? '' : seed);
    var n = 0;
    for (var i = 0; i < s.length; i++) n = (n + s.charCodeAt(i)) % 997;
    return 'abcd'[n % 4];
  }

  function DotsProfilePhoto(props) {
    var useState = hooks().useState;
    var errState = useState(false);
    var hasError = errState[0];
    var setError = errState[1];

    var bited = !!props.bited; // DotsProfilePhotoBited
    var width = props.width == null ? (bited ? 44 : 32) : props.width;   // Dart defaults 32 / 44
    var height = props.height == null ? (bited ? 44 : 32) : props.height;
    var showImg = !!props.src && !hasError;

    var inner = showImg
      ? h('img', {
          className: 'ds-profile-photo__img',
          src: props.src,
          alt: props.alt || '',
          onError: function (e) {
            setError(true);
            if (props.onError) props.onError(e);
          },
        })
      : h('span', {
          className:
            'ds-profile-photo__ph ds-profile-photo__ph--' + gradVariant(props.src || props.alt),
        });

    var rootProps = {
      className: 'ds-profile-photo' + (props.className ? ' ' + props.className : ''),
      style: { width: width + 'px', height: height + 'px' },
      onClick: props.onClick,
      role: props.onClick ? 'button' : undefined,
    };

    if (!bited) {
      return h('span', rootProps, h('span', { className: 'ds-profile-photo__circle' }, inner));
    }

    // _BiteCircleClipper: círculo de diámetro min(w,h) menos mordida r = d*biteSize
    // centrada en (d*biteOffset.x, d*biteOffset.y) — aproximado con mask radial.
    var biteSize = props.biteSize == null ? 0.25 : props.biteSize;
    var off = props.biteOffset || { x: 0.85, y: 0.85 };
    var d = Math.min(width, height);
    var left = (width - d) / 2;
    var top = (height - d) / 2;
    var r = d * biteSize;
    var cx = left + d * off.x;
    var cy = top + d * off.y;
    var mask =
      'radial-gradient(circle ' + r + 'px at ' + cx + 'px ' + cy + 'px, transparent ' +
      (r - 0.5) + 'px, #000 ' + (r + 0.5) + 'px)';

    return h(
      'span',
      rootProps,
      h(
        'span',
        {
          className: 'ds-profile-photo__circle',
          style: { WebkitMask: mask, mask: mask },
        },
        inner
      ),
      // Reaction — caja 2r×2r centrada en la mordida (Dart: Positioned + Align.center)
      props.reaction
        ? h(
            'span',
            {
              className: 'ds-profile-photo__reaction',
              style: {
                left: cx - r + 'px',
                top: cy - r + 'px',
                width: 2 * r + 'px',
                height: 2 * r + 'px',
              },
            },
            props.reaction
          )
        : null
    );
  }

  return DotsProfilePhoto;
})();
