// DotsPlanningItem — port de lib/src/components/planning/ (dots_planning_item.dart +
// dots_planning_info_item.dart + dots_planning_row_builder.dart) (Dart = fuente de verdad)
__ds.DotsPlanningItem = (function () {
  'use strict';

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', {
          style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' },
        });
  }

  // DotsPlanningItemRow (dots_planning_row_builder.dart): omite filas sin icono o sin texto
  function row(item, key) {
    if (!item || !item.icon || item.text == null || !String(item.text).trim()) return null;
    return h(
      'span',
      { className: 'ds-planning-item__row', key: key },
      h('span', { className: 'ds-planning-item__row-icon', 'aria-hidden': true },
        icon({ name: item.icon, size: 16, color: 'var(--label-primary)' })),
      h('span',
        { className: 'ds-planning-item__row-text' + (item.underline ? ' is-underline' : '') },
        item.text)
    );
  }

  function DotsPlanningItem(props) {
    var useState = hooks().useState;
    var st = useState(!!props.defaultExpanded);
    var controlled = props.expanded != null;
    var expanded = controlled ? !!props.expanded : st[0];

    function toggle() {
      if (props.onToggle) props.onToggle(!expanded);
      if (!controlled) st[1](!expanded);
    }

    // Dart: mainIcon/mainIconActive default chevronDown/chevronUp
    var chevron = expanded
      ? props.mainIconActive || 'ic-chevron-up'
      : props.mainIcon || 'ic-chevron-down';

    var subItems = props.subItems || [];

    return h(
      'div',
      {
        className: 'ds-planning-item' + (props.className ? ' ' + props.className : ''),
        onClick: toggle,
      },
      // _PlanningImage: DotsSquircleImage 52 squircle16, default default_section_planning.webp
      h('span', {
        className: 'ds-planning-item__img',
        style: props.sectionImage
          ? { backgroundImage: 'url(' + props.sectionImage + ')' }
          : undefined,
      }),
      h(
        'span',
        { className: 'ds-planning-item__col' },
        // _PlanningTitle: bodyLargeMedium textPrimary + DotsIcon 20 textQuarternary
        h(
          'span',
          { className: 'ds-planning-item__title-row' },
          h('span', { className: 'ds-planning-item__title' }, props.mainText),
          h('span', { className: 'ds-planning-item__chevron', 'aria-hidden': true },
            icon({ name: chevron, size: 20, color: 'var(--text-quarternary)' }))
        ),
        props.mainItem ? row(props.mainItem, 'main') : null,
        // _PlanningAnimatedSwitcher (200ms easeOut/easeIn, slide -0.1 + fade)
        h(
          'span',
          { className: 'ds-planning-item__sub' + (expanded ? ' is-expanded' : '') },
          h('span', { className: 'ds-planning-item__sub-inner' },
            subItems.map(function (it, i) { return row(it, i); }))
        )
      )
    );
  }
  return DotsPlanningItem;
})();
