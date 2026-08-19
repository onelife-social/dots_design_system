// DotsAccordion — port de lib/src/components/accordion/dots_accordion.dart (Dart = fuente de verdad)
__ds.DotsAccordion = (function () {
  'use strict';

  function Divider() {
    // DotsDivider — dos líneas de 1px (labelSecondary + bgStrong), opacity 0.6, radius 1000
    return h(
      'div',
      { className: 'ds-accordion__divider' },
      h('div', { className: 'ds-accordion__divider-l1' }),
      h('div', { className: 'ds-accordion__divider-l2' }),
    );
  }

  function DotsAccordion(props) {
    const { useState } = hooks();
    const Icon = __ds.DotsIcon;
    const sections = props.sections || [];
    const singleOpen = props.singleOpen !== false;
    const duration = props.animationDuration == null ? 180 : props.animationDuration;
    const addHPad = props.addHorizontalPadding !== false;

    const [state, setState] = useState(null);
    const expanded =
      state && state.length === sections.length
        ? state
        : sections.map(function (s) { return !!(s && s.expanded); });

    function toggle(index) {
      const next = expanded.map(function (v, i) {
        if (singleOpen) return i === index ? !v : false;
        return i === index ? !v : v;
      });
      setState(next);
      if (typeof props.onToggle === 'function') props.onToggle(index, next[index]);
    }

    const children = [];
    for (let i = 0; i < sections.length; i++) {
      const s = sections[i] || {};
      if (i > 0) children.push(h(Divider, { key: 'div-' + i }));
      children.push(
        h(
          'div',
          {
            key: 'sec-' + i,
            className: 'ds-accordion__section' + (expanded[i] ? ' is-expanded' : ''),
            style: { '--ds-accordion-duration': duration + 'ms' },
          },
          h(
            'div',
            {
              className: 'ds-accordion__header',
              role: 'button',
              'aria-expanded': !!expanded[i],
              onClick: function (idx) { return function () { toggle(idx); }; }(i),
            },
            s.leadingIcon && Icon
              ? h(Icon, {
                  name: s.leadingIcon,
                  size: 20,
                  color: 'var(--text-tertiary)',
                  className: 'ds-accordion__leading',
                })
              : null,
            h('span', { className: 'ds-accordion__title' }, s.title),
            Icon
              ? h(Icon, {
                  name: 'ic-chevron-down',
                  size: 16,
                  color: 'var(--text-tertiary)',
                  className: 'ds-accordion__chevron',
                })
              : h('span', { className: 'ds-accordion__chevron ds-accordion__chevron--fallback' }, '⌄'),
          ),
          // AnimatedSize → grid-template-rows 0fr→1fr con transition
          h(
            'div',
            { className: 'ds-accordion__collapse' },
            h(
              'div',
              { className: 'ds-accordion__collapse-inner' },
              h('div', { className: 'ds-accordion__content' }, s.content),
            ),
          ),
        ),
      );
    }

    return h(
      'div',
      { className: 'ds-accordion' + (addHPad ? ' ds-accordion--hpad' : '') },
      children,
    );
  }
  return DotsAccordion;
})();
