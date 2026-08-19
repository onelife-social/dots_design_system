// UsersList — port de lib/src/components/users_list/users_list.dart
// (+ users_item_list.dart → UsersList.Item con `variant` = UserItemListVariant).
// Dart = fuente de verdad.
__ds.UsersList = (function () {
  'use strict';

  var VARIANTS = {
    main: 1, label: 1, textfield: 1, button: 1, pending: 1,
    join: 1, waiting: 1, basic: 1, existingAlias: 1, pendingMember: 1,
  };

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', {
          style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' },
        });
  }

  function userInfo(props, size) {
    var Info = __ds.UserItem && __ds.UserItem.Info;
    return Info
      ? h(Info, {
          name: props.name,
          details: props.details,
          src: props.src,
          alias: props.alias,
          size: size,
        })
      : h('span', { className: 'ds-users-item__info-fallback' }, props.name || '');
  }

  function closeButton(onClick) {
    return __ds.DotsCloseButton
      ? h(__ds.DotsCloseButton, { size: 'extraSmall', onClick: onClick })
      : h('button', { type: 'button', className: 'ds-users-item__close-fallback', onClick: onClick }, '×');
  }

  function mainButton(label, variant, onClick) {
    return __ds.DotsMainButton
      ? h(__ds.DotsMainButton, {
          label: label || '',
          variant: variant,
          size: 'small',
          expand: false,
          onClick: onClick,
        })
      : h('button', { type: 'button', onClick: onClick }, label || '');
  }

  // UsersItemList — una fila (leading + trailing por variante)
  function Item(props) {
    var variant = VARIANTS[props.variant] ? props.variant : 'main';
    var tapValue = props.id == null ? '' : props.id;
    function tap() {
      if (props.onClick) props.onClick(tapValue);
    }

    // _MainWidget
    var main;
    if (variant === 'textfield') {
      main = h('input', {
        className: 'ds-users-item__textfield',
        type: 'text',
        placeholder: props.label || '',
        defaultValue: props.textValue || '',
        maxLength: 50, // LengthLimitingTextInputFormatter(50)
        autoFocus: props.autofocusOnEmpty !== false && !(props.textValue || '').length,
        onChange: props.textOnChange
          ? function (e) {
              props.textOnChange(tapValue, e.target.value);
            }
          : undefined,
      });
    } else if (variant === 'button') {
      main = h(
        'span',
        { className: 'ds-users-item__add' },
        icon({ name: props.icon || 'ic-add', size: 16, color: 'var(--label-highlight)' }),
        h('span', null, props.label || '')
      );
    } else {
      // waiting / pendingMember → UserInfoSize.large, resto small
      main = userInfo(props, variant === 'waiting' || variant === 'pendingMember' ? 'large' : 'small');
    }

    // _TrailingWidget
    var trailing = null;
    if (variant === 'main' || variant === 'textfield') {
      trailing = closeButton(tap);
    } else if (variant === 'pending' || variant === 'join') {
      trailing = h(
        'span',
        { className: 'ds-users-item__trail-icon' },
        icon({
          name: variant === 'join' ? 'ic-chevron-right' : 'ic-clock-filled',
          size: props.iconSize == null ? (variant === 'join' ? 14 : 16) : props.iconSize,
          color: 'var(--text-secondary)',
        })
      );
    } else if (variant === 'label') {
      trailing = h('span', { className: 'ds-users-item__role' }, props.label || '');
    } else if (variant === 'pendingMember') {
      trailing = h(
        'span',
        { className: 'ds-users-item__btns' },
        mainButton(props.buttonLabel1, 'main', function () {
          if (props.onButton1Click) props.onButton1Click(tapValue);
        }),
        mainButton(props.buttonLabel2, 'secondary', function () {
          if (props.onButton2Click) props.onButton2Click(tapValue);
        })
      );
    }

    var clickableRow = variant !== 'textfield' && variant !== 'main' && variant !== 'pendingMember';
    return h(
      'div',
      {
        className:
          'ds-users-item ds-users-item--' + variant +
          (props.className ? ' ' + props.className : ''),
        onClick: clickableRow && props.onClick ? tap : undefined,
        role: clickableRow && props.onClick ? 'button' : undefined,
      },
      main,
      trailing
    );
  }

  // UsersList — contenedor r26 bgContainerSecondaryOnBackground con divisores
  function UsersList(props) {
    var members = props.members || [];
    if (!members.length) return null;

    var items = members.map(function (m, index) {
      var base = {
        key: m.id == null ? 'm' + index : m.id,
        id: m.id,
        name: m.name,
        details: m.details,
        src: m.src,
        alias: m.alias,
      };

      // Creator — siempre el índice 0 (Dart)
      if (index === 0) {
        return h(Item, Object.assign(base, { variant: 'label', label: props.creatorLabel }));
      }

      switch (m.memberType) {
        case 'creator':
          return null; // ya tratado arriba (Dart: Offstage)
        case 'admin':
          return h(
            Item,
            Object.assign(base, {
              variant: 'label',
              label: props.adminLabel,
              onClick: props.memberOnClick,
            })
          );
        case 'friend':
          return h(Item, Object.assign(base, { variant: 'main', onClick: props.memberOnClick }));
        case 'member':
          return props.canModifyMembers
            ? h(
                Item,
                Object.assign(base, { variant: 'join', onClick: props.memberOnClick, iconSize: 22 })
              )
            : h(Item, Object.assign(base, { variant: 'basic' }));
        case 'existingAlias':
          return h(Item, Object.assign(base, { variant: 'existingAlias' }));
        case 'alias':
          return h(
            Item,
            Object.assign(base, {
              variant: 'textfield',
              label: props.textfieldLabel || '',
              textValue: m.name,
              onClick: props.memberOnClick,
              textOnChange: props.textOnChange,
              autofocusOnEmpty: props.autofocusOnEmpty,
            })
          );
        default:
          return h(Item, Object.assign(base, { variant: 'basic' }));
      }
    });

    // Botones de añadir al final (Dart)
    if (props.addParticipantLabel && props.addParticipantOnClick) {
      items.push(
        h(Item, {
          key: '__add-participant',
          variant: 'button',
          label: props.addParticipantLabel,
          icon: 'ic-add',
          onClick: props.addParticipantOnClick,
        })
      );
    }
    if (props.showAddFriendButton && props.addFriendLabel && props.addFriendOnClick) {
      items.push(
        h(Item, {
          key: '__add-friend',
          variant: 'button',
          label: props.addFriendLabel,
          icon: 'ic-user',
          onClick: props.addFriendOnClick,
        })
      );
    }

    return h(
      'div',
      { className: 'ds-users-list' + (props.className ? ' ' + props.className : '') },
      items
    );
  }

  UsersList.Item = Item;
  return UsersList;
})();
