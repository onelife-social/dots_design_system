// DotsPlanSelector — port de lib/src/components/premium/dots_plan_selector.dart (Dart = fuente de verdad)
__ds.DotsPlanSelector = (function () {
  'use strict';

  // DotsPlanSelectorVariant (Dart) → sufijo de clase
  var VARIANTS = { basic: 'basic', premium: 'premium', premiumPlus: 'premium-plus' };

  function DotsPlanSelector(props) {
    var variant = VARIANTS[props.variant] || VARIANTS.basic;
    var enabled = props.enabled !== false; // Dart: default true
    var selected = !!props.selected;
    var cls = 'ds-plan-selector';
    // Fondo webp (bgBasic/bgPremium/bgPremiumPlus) solo si selected && enabled (Dart: Ink.image)
    if (selected && enabled) cls += ' ds-plan-selector--selected ds-plan-selector--' + variant;
    if (!enabled) cls += ' is-disabled';
    if (props.className) cls += ' ' + props.className;
    return h(
      'button',
      {
        type: 'button',
        className: cls,
        disabled: !enabled,
        onClick: enabled ? props.onClick : undefined,
      },
      h('span', { className: 'ds-plan-selector__title' }, props.title),
      props.description
        ? h('span', { className: 'ds-plan-selector__desc' }, props.description)
        : null
    );
  }
  return DotsPlanSelector;
})();
