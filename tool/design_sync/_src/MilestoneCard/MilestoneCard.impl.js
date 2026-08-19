// MilestoneCard — port de lib/src/components/milestones/milestone_card.dart
// (+ milestone_badge_type.dart / milestone_badge_info.dart) (Dart = fuente de verdad)
__ds.MilestoneCard = (function () {
  'use strict';

  // MilestoneBadgeType (Dart): icon + color. Colores child010/couple001/friends005
  // no existen como token CSS (mismo hex en light y dark en Dart) — excepción documentada.
  var BADGE_TYPES = {
    video: { icon: 'ic-video', color: '#4FAEF8' /* child010 */ },
    audio: { icon: 'ic-mic', color: '#F43C51' /* couple001 */ },
    description: { icon: 'ic-pages', color: '#F7954A' /* friends005 */ },
  };

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', {
          style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' },
        });
  }

  // BadgeIconGroup (badges/badge_icon_group.dart): 63×70, [0] medium(36/20) left0 bottom0,
  // [1] small(28/16) left 4|31 bottom 42|31 según n, [2] small left35 bottom26
  function badgeGroup(types, onClick) {
    var list = types.slice(0, 3).filter(function (t) { return BADGE_TYPES[t]; });
    if (!list.length) return null;
    var pos = [
      { left: 0, bottom: 0, size: 36, iconSize: 20 },
      list.length === 3
        ? { left: 4, bottom: 42, size: 28, iconSize: 16 }
        : { left: 31, bottom: 31, size: 28, iconSize: 16 },
      { left: 35, bottom: 26, size: 28, iconSize: 16 },
    ];
    return h(
      'span',
      {
        className: 'ds-milestone-card__badges',
        onClick: onClick
          ? function (e) { e.stopPropagation(); onClick(); }
          : undefined,
      },
      list.map(function (t, i) {
        var b = BADGE_TYPES[t];
        var p = pos[i];
        return h(
          'span',
          {
            key: t + i,
            className: 'ds-milestone-card__badge-icon',
            style: { left: p.left + 'px', bottom: p.bottom + 'px', width: p.size + 'px', height: p.size + 'px' },
          },
          icon({ name: b.icon, size: p.iconSize, color: b.color })
        );
      })
    );
  }

  function MilestoneCard(props) {
    var width = props.width == null ? 170 : props.width;
    var isBig = width > 150; // Dart: squircle32 / squircle24
    var hasTitle = props.title != null && props.title !== '';

    var cls =
      'ds-milestone-card ds-milestone-card--' + (isBig ? 'big' : 'small') +
      (props.isSelected ? ' is-selected' : '') +
      (props.className ? ' ' + props.className : '');

    // _BtnEdit: DotsIconButton pencil (size default large), bgBtnImage
    var editBtn = null;
    if (props.showEdit) {
      var onEdit = props.onClickEdit
        ? function (e) { if (e && e.stopPropagation) e.stopPropagation(); props.onClickEdit(); }
        : undefined;
      editBtn = h(
        'span',
        { className: 'ds-milestone-card__edit' },
        __ds.DotsIconButton
          ? h(__ds.DotsIconButton, {
              icon: 'ic-pencil',
              backgroundColor: 'var(--bg-btn-image)',
              onClick: onEdit,
            })
          : h('button',
              { type: 'button', className: 'ds-milestone-card__edit-fallback', onClick: onEdit },
              icon({ name: 'ic-pencil', size: 24, color: 'var(--text-primary)' }))
      );
    }

    return h(
      'span',
      { className: cls, style: { width: width + 'px' }, onClick: props.onClick },
      props.src
        ? h('img', { className: 'ds-milestone-card__img', src: props.src, alt: props.title || '' })
        : h('span', { className: 'ds-milestone-card__img ds-milestone-card__img--default' }),
      // _CardWithBlur: DotsLinearGradientBlur sigma 15, tint black 35%, fundido hasta 108px
      hasTitle ? h('span', { className: 'ds-milestone-card__top-blur', 'aria-hidden': true }) : null,
      hasTitle
        ? h(
            'span',
            { className: 'ds-milestone-card__title-box' },
            h('span',
              { className: 'ds-milestone-card__title' + (props.limitTitle ? ' is-limited' : '') },
              props.title),
            props.date
              ? h('span', { className: 'ds-milestone-card__date' }, props.date)
              : null
          )
        : null,
      // _CardBadge: badge-milestone-1.svg (data URI en el CSS), top 5 right 5
      props.showBadge ? h('span', { className: 'ds-milestone-card__badge1', 'aria-hidden': true }) : null,
      editBtn,
      props.badgeTypes && props.badgeTypes.length
        ? badgeGroup(props.badgeTypes, props.onBadgesClick)
        : null
    );
  }
  MilestoneCard.badgeTypes = BADGE_TYPES;
  return MilestoneCard;
})();
