// DotsNavBar — port de lib/src/components/nav_bar/nav_bar.dart (Dart = fuente de verdad)
__ds.DotsNavBar = (function () {
  'use strict';
  var MAX_PENDING = 99; // kMaxPendingNumber (lib/src/core/constants.dart)
  var DEFAULT_ITEMS = [
    { icon: 'ic-add', label: 'Crear' },
    { icon: 'ic-home', label: 'Inicio' },
    { icon: 'ic-gallery', label: 'Galería' },
  ];
  function DotsNavBar(props) {
    var items = props.items || DEFAULT_ITEMS;
    var selectedIndex = props.selectedIndex || 0;
    var onSelect = props.onSelect;
    var Icon = __ds.DotsIcon;
    return h(
      'nav',
      { className: 'ds-nav-bar' + (props.className ? ' ' + props.className : '') },
      // Píldora del ítem activo — AnimatedPositioned left = selectedIndex * 70 (+5 de padding)
      h('span', {
        className: 'ds-nav-bar__pill',
        style: { left: 5 + selectedIndex * 70 + 'px' },
        'aria-hidden': true,
      }),
      items.map(function (item, i) {
        var selected = i === selectedIndex;
        var badge =
          item.badge == null
            ? null
            : item.badge > MAX_PENDING
              ? String(MAX_PENDING)
              : String(item.badge);
        return h(
          'button',
          {
            key: i,
            type: 'button',
            className: 'ds-nav-bar__item' + (selected ? ' is-selected' : ''),
            'aria-current': selected ? 'page' : undefined,
            onClick: onSelect
              ? function () {
                  onSelect(i);
                }
              : undefined,
          },
          h(
            'span',
            { className: 'ds-nav-bar__icon-wrap' },
            Icon
              ? h(Icon, { name: item.icon, size: 20, color: 'currentColor' })
              : h('span', { className: 'ds-nav-bar__icon-fallback' }),
            badge != null ? h('span', { className: 'ds-nav-bar__badge' }, badge) : null
          ),
          h('span', { className: 'ds-nav-bar__label' }, item.label)
        );
      })
    );
  }
  return DotsNavBar;
})();
