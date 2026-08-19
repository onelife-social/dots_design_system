// DotsTooltip — port de lib/src/components/tooltip/dots_tooltip.dart (Dart = fuente de verdad)
__ds.DotsTooltip = (function () {
  'use strict';

  // DotsToolTipTailPosition → alignment.x (-0.82 … 0.82) → left % (Alignment -1..1 → 0..100%)
  var TAIL = {
    topAlignLeadingEdge: { top: true, left: '9%', corner: 'tl' },
    topAlignLeading: { top: true, left: '22%', corner: null },
    topAlignCenter: { top: true, left: '50%', corner: null },
    topAlignTrailing: { top: true, left: '78%', corner: null },
    topAlignTrailingEdge: { top: true, left: '91%', corner: 'tr' },
    bottomAlignLeadingEdge: { top: false, left: '9%', corner: 'bl' },
    bottomAlignLeading: { top: false, left: '22%', corner: null },
    bottomAlignCenter: { top: false, left: '50%', corner: null },
    bottomAlignTrailing: { top: false, left: '78%', corner: null },
    bottomAlignTrailingEdge: { top: false, left: '91%', corner: 'br' },
  };

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function closeButton(onClick) {
    // Dart: DotsCloseButton small softContrast addBlur=false
    return __ds.DotsCloseButton
      ? h(__ds.DotsCloseButton, { size: 'small', variant: 'softContrast', addBlur: false, onClick: onClick })
      : h('button', { type: 'button', className: 'ds-tooltip__close-fallback', 'aria-label': 'Cerrar', onClick: onClick }, '×');
  }

  function DotsTooltip(props) {
    var tail = TAIL[props.tailPosition] || TAIL.bottomAlignCenter;
    var showCloseButton = props.showCloseButton !== false; // Dart: default true
    var maxWidth = props.maxWidth == null ? 288 : props.maxWidth; // Dart: default 288

    var iconNode = props.iconNode ||
      (props.icon ? icon({ name: props.icon, size: 32, color: 'var(--label-highlight)' }) : null);

    var cls = 'ds-tooltip' + (tail.corner ? ' ds-tooltip--corner-' + tail.corner : '');
    if (props.className) cls += ' ' + props.className;

    // Cola — TrianglePainter 21×13 (fill bgBaseContrast + stroke 2 bgContainerSecondary)
    var tailStyle = { left: tail.left };
    if (tail.top) {
      tailStyle.top = '-12px';
      tailStyle.transform = 'translateX(-50%) rotate(180deg)';
    } else {
      tailStyle.bottom = '-12px';
      tailStyle.transform = 'translateX(-50%)';
    }

    return h(
      'div',
      { className: cls, style: { maxWidth: maxWidth + 'px' }, onClick: props.onClick },
      iconNode,
      h('p', { className: 'ds-tooltip__text' }, props.text),
      showCloseButton
        ? h('span', {
            className: 'ds-tooltip__close',
            onClick: function (e) {
              e.stopPropagation();
              if (props.onClose) props.onClose();
            },
          }, closeButton(null))
        : null,
      h(
        'svg',
        { className: 'ds-tooltip__tail', style: tailStyle, viewBox: '0 0 21 13', 'aria-hidden': true },
        h('path', { d: 'M0 0 L8.5 11 Q10.5 13.4 12.5 11 L21 0', strokeWidth: 2, strokeLinejoin: 'round' })
      )
    );
  }

  return DotsTooltip;
})();
