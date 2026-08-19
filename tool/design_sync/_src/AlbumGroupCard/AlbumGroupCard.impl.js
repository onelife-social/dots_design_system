// AlbumGroupCard — port de lib/src/components/cards/group_cards/album_group_card.dart (Dart = fuente de verdad)
__ds.AlbumGroupCard = (function () {
  'use strict';
  var VARIANTS = { small: true, large: true }; // AlbumGroupCardVariant

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function AlbumGroupCard(props) {
    var variant = VARIANTS[props.variant] ? props.variant : 'small'; // Dart: default small
    var isSmall = variant === 'small';
    // Dart: AspectRatio 1:1 con constraints 135–160 (small) / 288–340 (large)
    var size = props.size == null ? (isSmall ? 148 : 288) : props.size;
    var edge = props.edgeSize == null ? (isSmall ? 60 : 110) : props.edgeSize;
    var isBlocked = !!props.isBlocked;

    var children = [
      h('div', {
        key: 'img',
        className: 'ds-album-card__img' + (props.imageSrc ? '' : ' ds-album-card__img--ph'),
        style: props.imageSrc ? { backgroundImage: 'url("' + props.imageSrc + '")' } : null,
      }),
      h('div', { key: 'fade', className: 'ds-album-card__fade', style: { height: edge + 'px' } }),
      h('div', {
        key: 'ttl',
        className: 'ds-album-card__title ds-album-card__title--' + variant,
      }, props.title || ''),
    ];

    if (!isBlocked && props.tagIcon) {
      children.push(h('span', {
        key: 'tag',
        className: 'ds-album-card__tag ' + (isSmall ? 'ds-album-card__tag--small' : 'ds-album-card__tag--large'),
      }, icon({ name: props.tagIcon, size: 20, color: 'currentColor' })));
    }
    if (isBlocked) {
      children.push(h('div', { key: 'lock', className: 'ds-album-card__lock' },
        icon({ name: 'ic-lock', size: 32, color: 'currentColor' })));
    }

    return h('div', {
      className: 'ds-album-card ds-album-card--' + variant + (props.className ? ' ' + props.className : ''),
      style: { width: size + 'px', height: size + 'px' },
      onClick: props.onClick,
      role: props.onClick ? 'button' : undefined,
    }, children);
  }

  return AlbumGroupCard;
})();
