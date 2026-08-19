// BadgeProgress — port de lib/src/components/badges/badge_progress.dart (Dart = fuente de verdad)
__ds.BadgeProgress = (function () {
  'use strict';

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function BadgeProgress(props) {
    return h(
      'span',
      { className: 'ds-badge-progress' },
      h('span', { className: 'ds-badge-progress__icon', 'aria-hidden': true },
        icon({ name: 'ic-check-circle', size: 20, color: 'var(--label-highlight)' })),
      h('span', { className: 'ds-badge-progress__text' }, props.current + '/' + props.max)
    );
  }

  return BadgeProgress;
})();
