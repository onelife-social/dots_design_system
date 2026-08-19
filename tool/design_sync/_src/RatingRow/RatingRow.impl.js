// RatingRow — port de lib/src/components/rating/rating_row.dart + rating_star.dart (Dart = fuente de verdad, widget DotsRatingStarRow / DotsRatingStar)
__ds.RatingRow = (function () {
  'use strict';

  // Gradientes verticales reales de rating_star.dart (colores accent sin token CSS):
  // detractor friends001→friends003, neutral class008→friends005, promoter family008→team007
  var GRADIENTS = [
    ['detractor', '#FAA25E', '#FA5B3D'],
    ['neutral', '#FCD12A', '#F7954A'],
    ['promoter', '#4FC976', '#01AF94'],
  ];

  function GradientDefs() {
    return h(
      'svg',
      { width: 0, height: 0, style: { position: 'absolute' }, 'aria-hidden': true },
      h(
        'defs',
        null,
        GRADIENTS.map(function (g) {
          return h(
            'linearGradient',
            { key: g[0], id: 'ds-rating-g-' + g[0], x1: '0', y1: '0', x2: '0', y2: '1' },
            h('stop', { offset: '0', stopColor: g[1] }),
            h('stop', { offset: '1', stopColor: g[2] }),
          );
        }),
      ),
    );
  }

  function Star(props) {
    const Icon = __ds.DotsIcon;
    const variant = props.variant || 'disabled';
    const size = props.iconSize == null ? 28 : props.iconSize;
    return h(
      'span',
      {
        className:
          'ds-rating-star ds-rating-star--' + variant + (props.onTap ? ' is-tappable' : ''),
        onClick: props.onTap,
      },
      props.showText ? h('span', { className: 'ds-rating-star__label' }, props.label) : null,
      h(
        'span',
        { className: 'ds-rating-star__icon' },
        Icon
          ? h(Icon, { name: 'ic-star', size: size })
          : h('span', { className: 'ds-rating-star__icon-fallback', style: { fontSize: size + 'px' } }, '★'),
      ),
    );
  }

  // Port de _buildVariants (rating_row.dart)
  function buildVariants(starLabels, selectedIndex) {
    const n = starLabels.length;
    const out = [];
    for (let i = 0; i < n; i++) {
      if (selectedIndex == null) { out.push('disabled'); continue; }
      if (n === 5) { out.push(i <= selectedIndex ? 'neutral' : 'disabled'); continue; }
      if (selectedIndex <= 5) out.push(i <= selectedIndex ? 'detractor' : 'disabled');
      else if (selectedIndex <= 7) out.push(i <= selectedIndex ? 'neutral' : 'disabled');
      else out.push(i <= selectedIndex ? 'promoter' : 'disabled');
    }
    return out;
  }

  function makeStar(props, variants, index) {
    return h(Star, {
      key: index,
      label: props.starLabels[index],
      variant: variants[index],
      showText: props.showStarText !== false,
      iconSize: props.iconSize,
      onTap:
        typeof props.onStarTap === 'function'
          ? function () { props.onStarTap(index); }
          : undefined,
    });
  }

  function RatingRow(props) {
    const starLabels = props.starLabels || [];
    const variants = buildVariants(starLabels, props.selectedIndex == null ? null : props.selectedIndex);

    let body;
    if (props.compact) {
      // _CompactLayout — primera fila de 6 (si >5) y segunda de 4, centradas, gap 5
      const firstCount = starLabels.length > 5 ? 6 : starLabels.length;
      const first = [];
      for (let i = 0; i < firstCount; i++) first.push(makeStar(props, variants, i));
      const rows = [h('div', { key: 'r1', className: 'ds-rating-row__stars ds-rating-row__stars--compact' }, first)];
      if (starLabels.length > 5) {
        const second = [];
        for (let j = 6; j < starLabels.length; j++) second.push(makeStar(props, variants, j));
        rows.push(h('div', { key: 'r2', className: 'ds-rating-row__stars ds-rating-row__stars--compact' }, second));
      }
      body = rows;
    } else {
      // _DefaultLayout — spaceBetween + textos abajo (labelSmallMedium textQuarternary)
      const stars = [];
      for (let i = 0; i < starLabels.length; i++) stars.push(makeStar(props, variants, i));
      body = [
        h('div', { key: 'stars', className: 'ds-rating-row__stars' }, stars),
        h(
          'div',
          { key: 'ends', className: 'ds-rating-row__ends' },
          h('span', null, props.leftText || ''),
          h('span', null, props.rightText || ''),
        ),
      ];
    }

    return h(
      'div',
      { className: 'ds-rating-row' + (props.compact ? ' ds-rating-row--compact' : '') },
      h(GradientDefs, null),
      body,
    );
  }
  return RatingRow;
})();
