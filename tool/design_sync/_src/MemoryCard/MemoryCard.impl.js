// MemoryCard — port de lib/src/components/cards/memory_card/memory_card.dart (Dart = fuente de verdad)
__ds.MemoryCard = (function () {
  'use strict';

  function MemoryCard(props) {
    var variant = props.variant === 'recap' ? 'recap' : 'memory'; // MemoryCardVariant
    return h('div', {
      className: 'ds-memory-card' + (props.className ? ' ' + props.className : ''),
      onClick: props.onClick,
      role: props.onClick ? 'button' : undefined,
    },
      // _MemoryCardBorder 67.53×87.39 r18 w1.45 (memory: lineal verde · recap: sweep)
      h('div', { className: 'ds-memory-card__border ds-memory-card__border--' + variant },
        h('div', { className: 'ds-memory-card__inner' },
          // _Card 60.39×80 r15 — imagen o placeholder degradado
          h('div', {
            className: 'ds-memory-card__img' + (props.imageSrc ? '' : ' ds-memory-card__img--ph'),
            style: props.imageSrc ? { backgroundImage: 'url("' + props.imageSrc + '")' } : null,
          }))),
      h('div', { className: 'ds-memory-card__name' }, props.groupName || '')
    );
  }

  return MemoryCard;
})();
