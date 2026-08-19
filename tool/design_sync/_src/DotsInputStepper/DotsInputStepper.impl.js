// DotsInputStepper — port de lib/src/components/buttons/dots_input_stepper.dart (Dart = fuente de verdad)
__ds.DotsInputStepper = (function () {
  'use strict';

  function DotsInputStepper(props) {
    const { useState } = hooks();
    var min = props.minValue == null ? 0 : props.minValue; // Dart: required (default web: 0)
    var max = props.maxValue == null ? 99 : props.maxValue; // Dart: required (default web: 99)
    var controlled = props.value !== undefined && props.value !== null;
    const [internal, setInternal] = useState(props.defaultValue == null ? min : props.defaultValue);
    var value = controlled ? props.value : internal;
    var canDecrement = value > min;
    var canIncrement = value < max;

    function step(delta, canStep, dartCallback) {
      if (!canStep) return;
      var next = value + delta;
      if (!controlled) setInternal(next);
      if (typeof dartCallback === 'function') dartCallback();
      if (typeof props.onChanged === 'function') props.onChanged(next);
    }

    // Dart: DotsIconButton small (28) sin fondo ni blur; enabled textTertiary,
    // disabled resuelto por el tema del botón → textDisabled.
    function stepBtn(iconName, enabled, onClick, fallbackGlyph) {
      return h(
        'button',
        {
          type: 'button',
          className: 'ds-stepper__btn' + (enabled ? '' : ' is-disabled'),
          disabled: !enabled,
          onClick: onClick,
        },
        __ds.DotsIcon
          ? h(__ds.DotsIcon, { name: iconName, size: 14, color: 'currentColor' })
          : fallbackGlyph,
      );
    }

    return h(
      'div',
      { className: 'ds-stepper' },
      stepBtn('ic-rest', canDecrement, function () { step(-1, canDecrement, props.onDecrement); }, '−'),
      h('span', { className: 'ds-stepper__value' }, String(value)),
      stepBtn('ic-add', canIncrement, function () { step(1, canIncrement, props.onIncrement); }, '+'),
    );
  }

  return DotsInputStepper;
})();
