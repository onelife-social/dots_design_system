// BadgeMilestone — port de lib/src/components/badges/badge_milestone/ (Dart = fuente de verdad)
__ds.BadgeMilestone = (function () {
  'use strict';

  var VARIANTS = { main: true, ghost: true }; // BadgeMilestoneVariant

  function BadgeMilestone(props) {
    var variant = VARIANTS[props.variant] ? props.variant : 'main'; // Dart: default main
    return h(
      'span',
      { className: 'ds-badge-milestone ds-badge-milestone--' + variant },
      h('span', { className: 'ds-badge-milestone__text' }, props.content)
    );
  }

  return BadgeMilestone;
})();
