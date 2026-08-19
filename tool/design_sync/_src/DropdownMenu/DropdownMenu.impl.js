// DropdownMenu — port de lib/src/components/dropdowns/ (dropdown_menu + dropdown_list +
// dropdown_item → una sola API; Dart = fuente de verdad)
__ds.DropdownMenu = (function () {
  'use strict';

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  // DropdownItem (dropdown_item.dart) — fila del menú: texto + subtitle inline,
  // leading opcional, icono trailing 16, pressed → bgContainerSecondary
  function DropdownMenuItem(props) {
    var style = props.itemColor ? { color: props.itemColor } : null;
    var cls = 'ds-dropdown__item' +
      (props.destructive ? ' ds-dropdown__item--destructive' : '') +
      (props.minSize ? ' ds-dropdown__item--min' : '');
    return h(
      'div',
      { className: cls, style: style, role: 'menuitem', tabIndex: 0, onClick: props.onClick },
      props.leading ? h('span', { className: 'ds-dropdown__item-leading' }, props.leading) : null,
      h(
        'span',
        { className: 'ds-dropdown__item-text' },
        props.text,
        props.subtitle ? h('span', { className: 'ds-dropdown__item-subtitle' }, ' ' + props.subtitle) : null
      ),
      props.icon ? icon({ name: props.icon, size: 16, color: 'currentColor', className: 'ds-dropdown__item-icon' }) : null
    );
  }

  function renderMenu(props) {
    var items = props.items || [];
    var style = { width: (props.width == null ? 250 : props.width) + 'px' };
    if (props.maxHeight != null) {
      style.maxHeight = props.maxHeight + 'px';
      style.overflowY = 'auto';
    }
    return h(
      'div',
      { className: 'ds-dropdown__menu', style: style, role: 'menu' },
      items.map(function (it, i) { return h(DropdownMenuItem, Object.assign({ key: i }, it)); })
    );
  }

  // DropdownList (dropdown_list.dart) + DropdownMenu (dropdown_menu.dart).
  // Sin `label` renderiza solo el panel del menú; con `label`, botón + menú desplegado
  // debajo cuando está activo (isActive controlado, o toggle interno).
  function DropdownMenu(props) {
    var useState = hooks().useState;
    var inner = useState(!!props.defaultActive);
    var controlled = props.isActive !== undefined && props.isActive !== null;
    var active = controlled ? !!props.isActive : inner[0];

    if (!props.label) return renderMenu(props);

    var size = props.size === 'medium' ? 'medium' : 'small'; // DropdownListSize.small default
    var onBackground = props.variant === 'onBackground';     // DropdownListVariant.onBackgroundVariant

    var btnCls = 'ds-dropdown__btn ds-dropdown__btn--' + size +
      (active ? ' ds-dropdown__btn--active' : '') +
      (onBackground && !active ? ' ds-dropdown__btn--on-bg' : '') +
      (props.minSize === false ? ' ds-dropdown__btn--expand' : '');

    function handleTap() {
      if (!controlled) inner[1](!active);
      if (props.onToggle) props.onToggle(!active);
      if (props.onClick) props.onClick();
    }

    return h(
      'div',
      { className: 'ds-dropdown' + (props.className ? ' ' + props.className : '') },
      h(
        'button',
        { type: 'button', className: btnCls, 'aria-expanded': active, onClick: handleTap },
        h(
          'span',
          { className: 'ds-dropdown__btn-text' },
          props.label,
          props.subtitle ? h('span', { className: 'ds-dropdown__btn-subtitle' }, ' ' + props.subtitle) : null
        ),
        icon({
          name: active ? 'ic-chevron-up' : 'ic-chevron-down',
          size: 14,
          color: 'currentColor',
          className: 'ds-dropdown__chevron',
        })
      ),
      active
        ? h('div', { className: 'ds-dropdown__overlay' }, renderMenu({
            items: props.items,
            width: props.menuMaxWidth == null ? 250 : props.menuMaxWidth,
            maxHeight: props.menuMaxHeight,
          }))
        : null
    );
  }

  DropdownMenu.Item = DropdownMenuItem;
  return DropdownMenu;
})();
