// DotsFilterChip — port de lib/src/components/dots_filter_chip/dots_filter_chip.dart (Dart = fuente de verdad)
__ds.DotsFilterChip = (function () {
  'use strict';

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function DotsFilterChip(props) {
    // Dart: GestureDetector en todo el chip; el DotsCloseButton interno no tiene onTap propio.
    return h(
      'button',
      { type: 'button', className: 'ds-filter-chip', onClick: props.onClick },
      h('span', { className: 'ds-filter-chip__label' }, props.label || ''),
      // DotsCloseButton extraSmall (16, icono 10) variant highContrast
      h('span', { className: 'ds-filter-chip__close', 'aria-hidden': true },
        icon({ name: 'ic-cross', size: 10, color: 'currentColor' }))
    );
  }

  return DotsFilterChip;
})();
