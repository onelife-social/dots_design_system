// UserItem — port de lib/src/components/user_items/user_item.dart
// (+ user_info.dart → UserItem.Info, user_info_data.dart → props planos name/details/src/alias).
// Dart = fuente de verdad.
__ds.UserItem = (function () {
  'use strict';

  function gradVariant(seed) {
    var s = String(seed == null ? '' : seed);
    var n = 0;
    for (var i = 0; i < s.length; i++) n = (n + s.charCodeAt(i)) % 997;
    return 'abcd'[n % 4];
  }

  function initials(name) {
    var parts = String(name || '').trim().split(/\s+/).filter(Boolean);
    if (!parts.length) return '';
    var out = parts[0].charAt(0);
    if (parts.length > 1) out += parts[1].charAt(0);
    return out.toUpperCase();
  }

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', {
          style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' },
        });
  }

  // UserInfo — avatar 26 (small) / 40 (large) + nombre (+ details)
  function Info(props) {
    var useState = hooks().useState;
    var errState = useState(false);
    var hasError = errState[0];
    var setError = errState[1];

    var size = props.size === 'large' ? 'large' : 'small'; // UserInfoSize (default small)
    var showImg = !!props.src && !hasError;

    var avatar;
    if (showImg) {
      avatar = h(
        'span',
        { className: 'ds-user-info__avatar' },
        h('img', {
          className: 'ds-user-info__avatar-img',
          src: props.src,
          alt: props.name || '',
          onError: function (e) {
            setError(true);
            if (props.onError) props.onError(e);
          },
        })
      );
    } else if (props.alias) {
      // aliasLabelImageText — círculo bgContainerSecondaryOnBackground + textTertiary
      avatar = h(
        'span',
        { className: 'ds-user-info__avatar ds-user-info__avatar--alias' },
        props.alias
      );
    } else {
      // Sin src ni alias — placeholder degradado con iniciales
      avatar = h(
        'span',
        {
          className:
            'ds-user-info__avatar ds-user-info__avatar--ph ds-user-info__avatar--ph-' +
            gradVariant(props.name),
        },
        initials(props.name)
      );
    }

    return h(
      'span',
      {
        className:
          'ds-user-info ds-user-info--' + size + (props.className ? ' ' + props.className : ''),
      },
      avatar,
      h(
        'span',
        { className: 'ds-user-info__names' },
        h('span', { className: 'ds-user-info__name' }, props.name || ''),
        props.details ? h('span', { className: 'ds-user-info__details' }, props.details) : null
      )
    );
  }

  // UserItem — 170×45, squircle24, bgStrong, sombra flotante, addCircle 20 labelHighlight
  function UserItem(props) {
    return h(
      'button',
      {
        type: 'button',
        className: 'ds-user-item' + (props.className ? ' ' + props.className : ''),
        onClick: props.onClick
          ? function () {
              props.onClick(props.id == null ? null : props.id);
            }
          : undefined,
      },
      h(Info, {
        name: props.name,
        details: props.details,
        src: props.src,
        alias: props.alias,
        onError: props.onError,
        size: 'small',
      }),
      icon({ name: 'ic-add-circle', size: 20, color: 'var(--label-highlight)' })
    );
  }

  UserItem.Info = Info;
  return UserItem;
})();
