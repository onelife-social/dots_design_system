// ActivityPreview — port de lib/src/components/notifications/activity_preview.dart
// + ActivityPreview.OverviewItem — port de activity_overview_item.dart (Dart = fuente de verdad)
__ds.ActivityPreview = (function () {
  'use strict';

  var VARIANTS = { reactions: 1, views: 1, favs: 1 }; // ActivityPreviewVariant

  // Badge del OverviewItem por variante — friends001 / hobby002 / couple001
  // (colores de categoría sin token en tokens.css; iguales en light y dark — dots_colors.dart)
  var BADGE_COLORS = { reactions: '#FAA25E', views: '#9297EF', favs: '#F43C51' };

  // ActivityOverviewItem.formatCount (k / M / B)
  function formatCount(count) {
    if (count >= 1000000000) return (count / 1000000000).toFixed(1) + 'B';
    if (count >= 1000000) return (count / 1000000).toFixed(1) + 'M';
    if (count >= 1000) return (count / 1000).toFixed(1) + 'k';
    return String(count);
  }

  function icon(name, size, color) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, { name: name, size: size, color: color })
      : h('span', { style: { width: size + 'px', height: size + 'px', display: 'inline-block' } });
  }

  /* ── ActivityPreview — tarjeta 3:4 con píldora blur ─────────────────────── */
  function ActivityPreview(props) {
    var useState = hooks().useState;
    var errState = useState(false);
    var imgError = errState[0], setImgError = errState[1];

    var variant = VARIANTS[props.variant] ? props.variant : 'reactions';
    var isReactions = variant === 'reactions';

    var pillChildren = [];
    if (isReactions && props.reactions && props.reactions.length) {
      props.reactions.forEach(function (reaction, i) {
        // typo.number.numLabelDefault (Nunito 13/800) — reacciones (emojis)
        pillChildren.push(h('span', { key: 'r' + i, className: 'ds-activity-preview__reaction' }, reaction));
      });
    }
    if (!isReactions) {
      pillChildren.push(h('span', { key: 'i', className: 'ds-activity-preview__pill-icon' },
        icon(variant === 'views' ? 'ic-eye' : 'ic-heart', 14, 'var(--label-always-white)')));
    }
    // typo.number.numBodyDefault (Nunito 14/800) labelAlwaysWhite
    pillChildren.push(h('span', {
      key: 'n',
      className: 'ds-activity-preview__number' + (isReactions ? '' : ' ds-activity-preview__number--after-icon'),
    }, props.number || ''));

    return h('div',
      {
        className: 'ds-activity-preview' +
          (props.src && !imgError ? '' : ' ds-activity-preview--placeholder') +
          (props.onCardClick ? ' ds-activity-preview--clickable' : '') +
          (props.className ? ' ' + props.className : ''),
        onClick: props.onCardClick,
        role: props.onCardClick ? 'button' : undefined,
      },
      props.src && !imgError
        ? h('img', {
            className: 'ds-activity-preview__img',
            src: props.src,
            alt: '',
            onError: function (e) {
              setImgError(true);
              if (props.onError) props.onError(e);
            },
          })
        : null,
      h('div', { className: 'ds-activity-preview__pill' }, pillChildren)
    );
  }

  /* ── ActivityPreview.OverviewItem — pila de fotos 53×68 + contadores ────── */
  function OverviewItem(props) {
    var variant = VARIANTS[props.variant] ? props.variant : 'reactions';
    var width = props.width == null ? 53 : props.width;
    var height = props.height == null ? 68 : props.height;
    var borderRadius = props.borderRadius == null ? 12 : props.borderRadius;
    var borderWidth = props.borderWidth == null ? 1 : props.borderWidth;
    var maxUserImages = props.maxUserImages == null ? 2 : props.maxUserImages;
    var images = props.images || [];
    var userImages = props.userImages || [];
    var count = props.count == null ? 0 : props.count;
    var reactionsCount = props.reactionsCount == null ? 0 : props.reactionsCount;

    function hideOnError(e) {
      e.target.style.display = 'none'; // deja visible el placeholder degradado de la card
      if (props.onError) props.onError(e);
    }

    // borde white30 inside → ::after con inset shadow (var --ds-ov-bw); sombras sin token (#00000026)
    var cardStyle = {
      width: width + 'px',
      height: height + 'px',
      borderRadius: borderRadius + 'px',
      boxShadow: '0 6px 6px #00000026',
      '--ds-ov-bw': borderWidth + 'px',
    };
    var backStyle = {
      width: width + 'px',
      height: height + 'px',
      borderRadius: borderRadius + 'px',
      boxShadow: '-6px 5px 10px #00000026',
      '--ds-ov-bw': borderWidth + 'px',
    };

    // Foto trasera rotada -0.087 rad ≈ -5deg, anclada abajo-derecha (solo con >1 imagen)
    var backCard = null;
    if (images.length > 1) {
      backCard = h('div', { className: 'ds-activity-overview__card ds-activity-overview__card--back', style: backStyle },
        images[images.length - 1]
          ? h('img', { className: 'ds-activity-overview__photo', src: images[images.length - 1], alt: '', onError: hideOnError })
          : null
      );
    }

    var mainCard = h('div', { className: 'ds-activity-overview__card ds-activity-overview__card--main', style: cardStyle },
      images[0]
        ? h('img', { className: 'ds-activity-overview__photo', src: images[0], alt: '', onError: hideOnError })
        : null,
      h('div', { className: 'ds-activity-overview__gradient', style: { borderRadius: borderRadius + 'px' } })
    );

    // Badge esquina: CircleAvatar r10 bgBase → círculo interior color de variante + icono 14
    var badge = h('div', { className: 'ds-activity-overview__badge' },
      h('div', { className: 'ds-activity-overview__badge-inner', style: { background: BADGE_COLORS[variant] } },
        props.icon ? icon(props.icon, 14, props.iconColor || 'var(--label-always-white)') : null
      )
    );

    // Avatares solapados 17px (offset 10px por avatar)
    var avatars = null;
    var shownUsers = userImages.slice(0, maxUserImages);
    if (reactionsCount > 0 && shownUsers.length > 0) {
      avatars = h('div', {
        className: 'ds-activity-overview__avatars',
        style: { width: (17 + (shownUsers.length - 1) * 10) + 'px' },
      }, shownUsers.map(function (src, i) {
        return h('div', {
          key: i,
          className: 'ds-activity-overview__avatar',
          style: { left: (i * 10) + 'px', zIndex: shownUsers.length - i },
        },
          // fallback debajo; la foto lo tapa cuando carga (Dart: imageErrorBuilder → Icons.person)
          h('span', { className: 'ds-activity-overview__avatar-fallback' }, icon('ic-user', 12, 'var(--text-tertiary)')),
          src
            ? h('img', {
                className: 'ds-activity-overview__avatar-img',
                src: src,
                alt: '',
                onError: function (e) { e.target.style.display = 'none'; }, // → fallback ic-user
              })
            : null
        );
      }));
    }

    return h('div',
      { className: 'ds-activity-overview' + (props.className ? ' ' + props.className : '') },
      h('div', { className: 'ds-activity-overview__stack', style: { width: width + 'px', height: height + 'px' } },
        backCard, mainCard, badge),
      h('div', { className: 'ds-activity-overview__info' },
        h('div', { className: 'ds-activity-overview__count' }, formatCount(count)),
        h('div', { className: 'ds-activity-overview__title' }, props.title),
        reactionsCount > 0
          ? h('div', { className: 'ds-activity-overview__reactions' },
              h('span', { className: 'ds-activity-overview__reactions-count' }, '+' + formatCount(reactionsCount)),
              avatars)
          : null
      )
    );
  }

  ActivityPreview.OverviewItem = OverviewItem;
  return ActivityPreview;
})();
