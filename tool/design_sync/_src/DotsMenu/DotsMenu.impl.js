// DotsMenu — port de lib/src/components/menu/ (dots_menu.dart + dots_menu_item_model.dart
// + settings_item.dart + settings_list.dart; Dart = fuente de verdad)
__ds.DotsMenu = (function () {
  'use strict';

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  // ── DotsMenu — menú contextual con navegación anidada por subItems ─────────
  // Item model (DotsMenuItemModel): { id, label, details, icon, selected,
  // isDelete, subItems, addDivider, onClick }
  function findStack(subItems, targetId) {
    for (var i = 0; i < (subItems || []).length; i++) {
      var it = subItems[i];
      if (it.id === targetId) return [it];
      if (it.subItems && it.subItems.length) {
        var stack = findStack(it.subItems, targetId);
        if (stack.length) return [it].concat(stack);
      }
    }
    return [];
  }

  function MenuItem(p) {
    var item = p.item;
    // Dart _MenuItem.leftIcon: selected → check; subItems && !initial → chevron down/right
    var leftIcon = null;
    if (item.selected) leftIcon = 'ic-check';
    else if (item.subItems && item.subItems.length && !p.isInitialItem) {
      leftIcon = p.isExpanded ? 'ic-chevron-down' : 'ic-chevron-right';
    }
    var iconColor = item.isDelete
      ? 'var(--label-destructive)'
      : item.selected
        ? 'var(--label-highlight)'
        : null;
    var textStyle = item.isDelete ? { color: 'var(--label-destructive)' } : null;

    return h(
      'div',
      {
        className: 'ds-menu__item' + (item.details != null ? ' ds-menu__item--details' : ''),
        role: 'menuitem',
        tabIndex: 0,
        onClick: function () {
          if (item.onClick) item.onClick();
          if (p.onTapItem) p.onTapItem();
        },
      },
      leftIcon ? icon({ name: leftIcon, size: 14, color: iconColor || 'var(--text-primary)', className: 'ds-menu__item-left' }) : null,
      h(
        'span',
        { className: 'ds-menu__item-body' },
        h('span', { className: 'ds-menu__item-label', style: textStyle }, item.label),
        item.details != null
          ? h('span', { className: 'ds-menu__item-details', style: textStyle }, item.details)
          : null
      ),
      item.icon
        ? icon({ name: item.icon, size: 16, color: iconColor || 'var(--label-primary)', className: 'ds-menu__item-right' })
        : null
    );
  }

  function DotsMenu(props) {
    var useState = hooks().useState;
    var initial = useState(function () {
      var root = Object.assign({}, props.mainItem, { subItems: props.subitems || [] });
      var stack = [];
      var selected = root;
      if (props.defaultSelectedItemId != null && props.defaultSelectedItemId !== root.id) {
        var path = findStack(root.subItems, props.defaultSelectedItemId);
        if (path.length) {
          selected = path.pop();
          stack = [root].concat(path);
        }
      }
      return { stack: stack, selected: selected };
    });
    var state = initial[0];
    var setState = initial[1];
    var selected = state.selected;
    var isInitialItem = state.stack.length === 0;
    var subs = selected.subItems || [];
    var scrollable = subs.length > 7; // Dart: > 7 subitems → maxHeight 336 con scroll

    var children = [];
    for (var i = 0; i < subs.length; i++) {
      (function (item) {
        children.push(h(MenuItem, {
          key: 'i' + i,
          item: item,
          isExpanded: false,
          onTapItem: function () {
            if (item.subItems && item.subItems.length) {
              setState({ stack: state.stack.concat([selected]), selected: item });
            }
          },
        }));
      })(subs[i]);
      var isLast = i === subs.length - 1;
      if (subs[i].addDivider && !isLast) children.push(h('div', { key: 'd' + i, className: 'ds-menu__divider ds-menu__divider--item' }));
      else if (!isLast) children.push(h('div', { key: 's' + i, className: 'ds-menu__spacer' }));
    }

    return h(
      'div',
      { className: 'ds-menu' + (props.className ? ' ' + props.className : ''), role: 'menu' },
      h(MenuItem, {
        item: selected,
        isExpanded: true,
        isInitialItem: isInitialItem,
        onTapItem: function () {
          if (state.stack.length) {
            var stack = state.stack.slice();
            setState({ selected: stack.pop(), stack: stack });
          }
        },
      }),
      h('div', { className: 'ds-menu__divider' }),
      h('div', { className: 'ds-menu__list' + (scrollable ? ' ds-menu__list--scroll' : '') }, children)
    );
  }

  // ── DotsMenu.SettingsList — settings_list.dart + settings_item.dart ────────
  // Item: { variant: 'icon' | 'toggle', label, startIcon, endIcon, toggleValue,
  // onToggleTap, onClick, textColor, textAlignment }
  function SettingsItem(p) {
    var isToggle = p.variant === 'toggle'; // SettingsItemVariant
    var labelStyle = {};
    if (p.textColor) labelStyle.color = p.textColor;
    if (p.textAlignment) labelStyle.textAlign = p.textAlignment;
    return h(
      'div',
      {
        className: 'ds-menu-settings__item' + (isToggle ? ' ds-menu-settings__item--toggle' : ''),
        role: 'button',
        tabIndex: 0,
        onClick: p.onClick || p.onToggleTap,
      },
      p.startIcon ? icon({ name: p.startIcon, size: 20, color: 'var(--text-tertiary)', className: 'ds-menu-settings__start' }) : null,
      h('span', { className: 'ds-menu-settings__label', style: labelStyle }, p.label),
      isToggle
        ? h(
            'span',
            {
              className: 'ds-menu-settings__toggle' + (p.toggleValue ? ' is-on' : ''),
              role: 'switch',
              'aria-checked': !!p.toggleValue,
              onClick: function (e) {
                e.stopPropagation();
                if (p.onToggleTap) p.onToggleTap();
              },
            },
            h('span', { className: 'ds-menu-settings__knob' })
          )
        : p.endIcon
          ? icon({ name: p.endIcon, size: 16, color: 'var(--text-tertiary)' })
          : null
    );
  }

  function SettingsList(props) {
    var items = props.items || [];
    var textPad = props.textPadding == null ? 15 : props.textPadding; // Dart: 15
    var rows = [];
    for (var i = 0; i < items.length; i++) {
      rows.push(h(SettingsItem, Object.assign({ key: 'i' + i }, items[i])));
      if (i < items.length - 1) rows.push(h('div', { key: 'd' + i, className: 'ds-menu-settings__divider' }));
    }
    return h(
      'div',
      { className: 'ds-menu-settings' + (props.className ? ' ' + props.className : '') },
      props.title
        ? h('div', { className: 'ds-menu-settings__title', style: { margin: '0 ' + textPad + 'px 8px' } }, String(props.title).toUpperCase())
        : null,
      items.length ? h('div', { className: 'ds-menu-settings__list' }, rows) : null,
      props.description
        ? h('div', { className: 'ds-menu-settings__desc', style: { margin: '8px ' + textPad + 'px 0' } }, props.description)
        : null
    );
  }

  DotsMenu.SettingsList = SettingsList;
  DotsMenu.SettingsItem = SettingsItem;
  return DotsMenu;
})();
