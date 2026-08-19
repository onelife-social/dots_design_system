// MilestonesList — port de lib/src/components/milestones/milestones_list.dart (Dart = fuente de verdad)
__ds.MilestonesList = (function () {
  'use strict';

  // Constantes Dart
  var CARD_HEIGHT = 326;
  var BADGE_HEIGHT = 17;
  var TAIL_EXTENSION = 64;
  var CARD_WIDTH = (CARD_HEIGHT * 3) / 4; // MilestoneCard aspect 3:4 → 244.5
  var PATTERN_1 = [0, -23, 37, 16, -38];
  var PATTERN_2 = [0, -38, 37, -39, 29, 37];
  var BEND = 20;

  // PRNG determinista (mulberry32) — espejo funcional de Random(seed) de Dart
  // (misma semilla ⇒ mismo layout entre renders; secuencia ≠ bit a bit que Dart)
  function rng(seed) {
    var a = seed >>> 0;
    return function () {
      a |= 0; a = (a + 0x6d2b79f5) | 0;
      var t = Math.imul(a ^ (a >>> 15), 1 | a);
      t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
      return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
    };
  }

  function isCard(item) {
    return typeof item !== 'string';
  }

  // gap = 20–34 aleatorio entre cards, 64 entre badge y card (o viceversa)
  function verticalSpacing(curr, next, rand) {
    var currH = isCard(curr) ? CARD_HEIGHT : BADGE_HEIGHT;
    var nextH = isCard(next) ? CARD_HEIGHT : BADGE_HEIGHT;
    var gap = isCard(curr) && isCard(next) ? 20 + Math.floor(rand() * 15) : 64;
    return currH / 2 + gap + nextH / 2;
  }

  function layout(list, seed, centerX) {
    var rand = rng(seed);
    var topPadding = BADGE_HEIGHT / 2;
    var bottomPadding = CARD_HEIGHT / 2 + TAIL_EXTENSION;
    var count = list.length;

    // Patrones x: empieza con pattern1, luego alterna aleatoriamente
    var xs = [];
    var pattern = PATTERN_1;
    while (xs.length < count) {
      for (var k = 0; k < pattern.length && xs.length < count; k++) xs.push(pattern[k]);
      pattern = rand() < 0.5 ? PATTERN_1 : PATTERN_2;
    }

    var points = [];
    var y = topPadding;
    var total = topPadding;
    for (var i = 0; i < count; i++) {
      points.push({ x: centerX + xs[i], y: y });
      if (i < count - 1) {
        var sp = verticalSpacing(list[i], list[i + 1], rand);
        y += sp;
        total += sp;
      }
    }
    total += bottomPadding;
    // Cola: prolonga la línea como si hubiera una última card fantasma
    if (count > 0) points.push({ x: centerX + xs[count - 1], y: y + CARD_HEIGHT / 2 + TAIL_EXTENSION });
    return { points: points, totalHeight: total };
  }

  // _BezierTimelinePainter: cuadráticas con control en el punto medio ± bend 20
  function pathD(points) {
    if (!points.length) return '';
    var d = 'M ' + points[0].x + ' ' + points[0].y;
    for (var i = 1; i < points.length; i++) {
      var prev = points[i - 1];
      var curr = points[i];
      var dir = curr.x - prev.x >= 0 ? 1 : -1;
      var cx = (prev.x + curr.x) / 2 + BEND * dir;
      var cy = (prev.y + curr.y) / 2;
      d += ' Q ' + cx + ' ' + cy + ' ' + curr.x + ' ' + curr.y;
    }
    return d;
  }

  function renderItem(item) {
    var R = hooks();
    if (typeof item === 'string') {
      // Dart: BadgeMilestone(content, variant: ghost)
      return __ds.BadgeMilestone
        ? h(__ds.BadgeMilestone, { content: item, variant: 'ghost' })
        : h('span', { className: 'ds-milestones-list__badge' }, item);
    }
    if (R.isValidElement && R.isValidElement(item)) return item; // elemento ya construido
    // Objeto de props de MilestoneCard
    var cardProps = Object.assign({ width: CARD_WIDTH }, item);
    return __ds.MilestoneCard
      ? h(__ds.MilestoneCard, cardProps)
      : h('span', {
          className: 'ds-milestones-list__card-fallback',
          style: { width: cardProps.width + 'px' },
        });
  }

  function MilestonesList(props) {
    var R = hooks();
    var list = props.list || [];
    var seed = props.seed == null ? 1 : props.seed;
    var ref = R.useRef(null);
    var widthState = R.useState(props.width || 0);
    var width = props.width || widthState[0] || 375;

    R.useLayoutEffect(function () {
      if (props.width) return;
      function measure() {
        if (ref.current) widthState[1](ref.current.clientWidth);
      }
      measure();
      window.addEventListener('resize', measure);
      return function () { window.removeEventListener('resize', measure); };
    }, [props.width]);

    var lay = R.useMemo(
      function () { return layout(list, seed, width / 2); },
      [list, seed, width]
    );

    var items = [];
    for (var i = 0; i < list.length; i++) {
      items.push(
        h(
          'span',
          {
            key: i,
            className: 'ds-milestones-list__item',
            style: { left: lay.points[i].x + 'px', top: lay.points[i].y + 'px' },
          },
          renderItem(list[i])
        )
      );
    }

    return h(
      'div',
      {
        ref: ref,
        className: 'ds-milestones-list' + (props.className ? ' ' + props.className : ''),
        style: { height: lay.totalHeight + 'px' },
      },
      h(
        'svg',
        {
          className: 'ds-milestones-list__line',
          width: '100%',
          height: lay.totalHeight,
          viewBox: '0 0 ' + width + ' ' + lay.totalHeight,
          fill: 'none',
          'aria-hidden': true,
        },
        // Punteado: círculos r1 cada 8px (lineWidth 2, lineDotsSpacing 8, labelSecondary)
        h('path', {
          d: pathD(lay.points),
          stroke: 'var(--label-secondary)',
          strokeWidth: 2,
          strokeDasharray: '0.1 8',
          strokeLinecap: 'round',
        })
      ),
      items
    );
  }
  return MilestonesList;
})();
