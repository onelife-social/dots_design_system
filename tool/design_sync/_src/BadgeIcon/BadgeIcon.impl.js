// BadgeIcon — port de lib/src/components/badges/badge_icon/ (Dart = fuente de verdad).
// Incluye modo grupo (prop `icons`) espejo de BadgeIconGroup (badge_icon_group.dart).
__ds.BadgeIcon = (function () {
  'use strict';

  // BadgeIconSize (Dart): size del círculo / iconSize
  var SIZES = {
    large: { size: 44, iconSize: 24 },
    medium: { size: 36, iconSize: 20 },
    small: { size: 28, iconSize: 16 },
  };
  var STYLES = { white: true }; // BadgeIconStyle (solo white por ahora)

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function single(name, sizeName, style, iconColor, onClick, posStyle) {
    var s = SIZES[sizeName] || SIZES.large; // Dart: default large
    return h(
      'span',
      {
        className: 'ds-badge-icon ds-badge-icon--' + (STYLES[style] ? style : 'white'),
        style: Object.assign({ width: s.size + 'px', height: s.size + 'px' }, posStyle || null),
        onClick: onClick,
        role: onClick ? 'button' : undefined,
      },
      icon({ name: name, size: s.iconSize, color: iconColor || 'currentColor' })
    );
  }

  function BadgeIcon(props) {
    // Modo grupo — BadgeIconGroup (Dart): 1-3 iconos apilados en un lienzo 63x70.
    if (props.icons) {
      var icons = props.icons.slice(0, 3);
      if (!icons.length) return null; // Dart: SizedBox.shrink()
      var colors = props.iconColors || [];
      var kids = [
        single(icons[0], 'medium', props.style, colors[0], null, { left: 0, bottom: 0 }),
      ];
      if (icons.length >= 2)
        kids.push(single(icons[1], 'small', props.style, colors[1], null,
          icons.length === 3 ? { left: '4px', bottom: '42px' } : { left: '31px', bottom: '31px' }));
      if (icons.length === 3)
        kids.push(single(icons[2], 'small', props.style, colors[2], null, { left: '35px', bottom: '26px' }));
      return h(
        'span',
        { className: 'ds-badge-icon-group', onClick: props.onClick, role: props.onClick ? 'button' : undefined },
        kids
      );
    }
    return single(props.icon, props.size, props.style, props.iconColor, props.onClick);
  }

  return BadgeIcon;
})();
