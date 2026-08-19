// BadgeLabel — port de lib/src/components/badges/badge_label/ (Dart = fuente de verdad)
__ds.BadgeLabel = (function () {
  'use strict';

  // BadgeLabelVariant (Dart) → sufijo de clase
  var VARIANTS = {
    main: 'main',
    secondary: 'secondary',
    green: 'green',
    white: 'white',
    greenMaterial: 'green-material',
    warning: 'warning',
    warningMaterial: 'warning-material',
    red: 'red',
    premiumPlus: 'premium-plus',
    premium: 'premium',
  };
  var SIZES = { large: true, medium: true, small: true }; // BadgeLabelSize

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function BadgeLabel(props) {
    var size = SIZES[props.size] ? props.size : 'medium';      // Dart: default medium
    var variant = VARIANTS[props.variant] || VARIANTS.main;    // Dart: default main
    return h(
      'span',
      { className: 'ds-badge-label ds-badge-label--' + size + ' ds-badge-label--' + variant },
      props.badgeIcon
        ? h('span', { className: 'ds-badge-label__icon', 'aria-hidden': true },
            icon({ name: props.badgeIcon, size: 16, color: 'currentColor' }))
        : null,
      h('span', { className: 'ds-badge-label__text' }, props.content)
    );
  }

  return BadgeLabel;
})();
