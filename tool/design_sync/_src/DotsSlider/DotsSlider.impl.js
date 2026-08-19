// DotsSlider — port de lib/src/components/slider/dots_slider.dart (Dart = fuente de verdad)
__ds.DotsSlider = (function () {
  'use strict';

  function clamp(v, lo, hi) { return v < lo ? lo : v > hi ? hi : v; }

  function DotsSlider(props) {
    const { useState, useRef } = hooks();
    const Icon = __ds.DotsIcon;

    const max = props.max == null ? 1.0 : props.max;
    const divisions = props.divisions == null ? null : props.divisions;
    const controlled = props.value !== undefined && props.value !== null;
    const [internal, setInternal] = useState(
      props.defaultValue == null ? 0 : props.defaultValue,
    );
    const value = clamp(controlled ? props.value : internal, 0, max);
    // Como en Flutter: sin onChanged (y modo controlado) el slider no es interactivo
    const interactive = typeof props.onChanged === 'function' || !controlled;

    const trackRef = useRef(null);
    const draggingRef = useRef(false);

    function valueFromPointer(e) {
      const rect = trackRef.current.getBoundingClientRect();
      let ratio = rect.width > 0 ? (e.clientX - rect.left) / rect.width : 0;
      ratio = clamp(ratio, 0, 1);
      if (divisions) ratio = Math.round(ratio * divisions) / divisions;
      return ratio * max;
    }

    function commit(v) {
      if (!controlled) setInternal(v);
      if (typeof props.onChanged === 'function') props.onChanged(v);
    }

    function onPointerDown(e) {
      if (!interactive) return;
      draggingRef.current = true;
      if (e.currentTarget.setPointerCapture) e.currentTarget.setPointerCapture(e.pointerId);
      commit(valueFromPointer(e));
    }
    function onPointerMove(e) {
      if (!draggingRef.current) return;
      commit(valueFromPointer(e));
    }
    function onPointerUp() { draggingRef.current = false; }

    const pct = max > 0 ? (value / max) * 100 : 0;

    const ticks = [];
    if (divisions) {
      for (let i = 0; i <= divisions; i++) {
        ticks.push(
          h('span', {
            key: 't' + i,
            className: 'ds-slider__tick',
            style: { left: (i / divisions) * 100 + '%' },
          }),
        );
      }
    }

    return h(
      'div',
      { className: 'ds-slider' + (interactive ? '' : ' is-static') },
      Icon
        ? h(Icon, { name: props.leftIcon || 'ic-user', size: 20, color: 'var(--label-secondary)', className: 'ds-slider__icon' })
        : null,
      h(
        'div',
        {
          className: 'ds-slider__track',
          ref: trackRef,
          role: 'slider',
          'aria-valuemin': 0,
          'aria-valuemax': max,
          'aria-valuenow': value,
          onPointerDown: onPointerDown,
          onPointerMove: onPointerMove,
          onPointerUp: onPointerUp,
          onPointerCancel: onPointerUp,
        },
        h('div', { className: 'ds-slider__fill', style: { width: pct + '%' } }),
        ticks,
        h('div', { className: 'ds-slider__thumb', style: { left: pct + '%' } }),
      ),
      Icon
        ? h(Icon, { name: props.rightIcon || 'ic-group', size: 20, color: 'var(--label-secondary)', className: 'ds-slider__icon' })
        : null,
    );
  }
  return DotsSlider;
})();
