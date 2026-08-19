// DotsCountdown — port de lib/src/components/countdown/ (CountdownRecap + CountdownEventFinished; Dart = fuente de verdad)
__ds.DotsCountdown = (function () {
  'use strict';
  function pad2(v) {
    var s = String(v == null ? 0 : v);
    return s.length >= 2 ? s : '0' + s;
  }
  function remainingOf(target) {
    var diff = target - Date.now();
    if (diff <= 0) return { finished: true, days: 0, hours: 0, minutes: 0, seconds: 0 };
    var s = Math.floor(diff / 1000);
    return {
      finished: false,
      days: Math.floor(s / 86400),
      hours: Math.floor(s / 3600) % 24,
      minutes: Math.floor(s / 60) % 60,
      seconds: s % 60,
    };
  }
  function icon(name, size) {
    // Render-time con fallback: si DotsIcon no está en el bundle, no rompas.
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, { name: name, size: size, color: 'var(--label-always-white)' })
      : null;
  }
  // _CountdownTimeItem / _CountdownEventFinishedBigItem — valor titleH4 + label labelSmallMedium
  function timeItem(key, value, label, dimLabel) {
    return h(
      'span',
      { key: key, className: 'ds-countdown__item' },
      h('span', { className: 'ds-countdown__item-value' }, value),
      h(
        'span',
        { className: 'ds-countdown__item-label' + (dimLabel ? ' is-dim' : '') },
        label
      )
    );
  }

  function DotsCountdown(props) {
    var hk = hooks();
    var useState = hk.useState;
    var useEffect = hk.useEffect;
    var variant = props.variant || 'recap'; // 'recap' | 'small' | 'big' (small/big = enum Dart CountdownEventFinishedVariant)
    var target =
      props.targetDate == null ? null : new Date(props.targetDate).getTime();

    // Tick de 1s (Timer.periodic de _CountdownRecapState) — solo con targetDate en variant recap.
    var live = target != null && variant === 'recap';
    var tick = useState(0);
    useEffect(
      function () {
        if (!live) return undefined;
        if (remainingOf(target).finished) return undefined;
        var id = setInterval(function () {
          tick[1](function (n) {
            return n + 1;
          });
          // _timer?.cancel() del Dart al llegar a cero
          if (remainingOf(target).finished) clearInterval(id);
        }, 1000);
        return function () {
          clearInterval(id);
        };
      },
      [target, live]
    );

    var className =
      'ds-countdown ds-countdown--' +
      variant +
      (variant === 'recap' && props.isDotbook ? ' ds-countdown--dotbook' : '') +
      (props.className ? ' ' + props.className : '');

    if (variant === 'small') {
      // _CountdownEventFinishedSmallBody — h36, icono 16 + texto labelDefaultBold
      var text = (
        (props.years || '') + ' ' + (props.yearsLabel || '') + ' ' +
        (props.months || '') + ' ' + (props.monthsLabel || '') + ' ' +
        (props.conjunctionText || '') + ' ' +
        (props.days || '') + ' ' + (props.daysLabel || '')
      ).replace(/\s+/g, ' ').trim();
      return h(
        'span',
        { className: className },
        icon(props.icon || 'ic-wedding-rings', 16),
        h('span', { className: 'ds-countdown__small-text' }, text)
      );
    }

    if (variant === 'big') {
      // _CountdownEventFinishedBigBody — w169, título + fila años/meses/días
      return h(
        'span',
        { className: className },
        h('span', { className: 'ds-countdown__title' }, props.title || ''),
        h(
          'span',
          { className: 'ds-countdown__times ds-countdown__times--big' },
          timeItem('y', props.years || '', props.yearsLabel || '', false),
          timeItem('m', props.months || '', props.monthsLabel || '', false),
          timeItem('d', props.days || '', props.daysLabel || '', false)
        )
      );
    }

    // variant 'recap' — CountdownRecap: contador en curso o cuerpo terminado
    var r;
    if (target != null) {
      r = remainingOf(target);
    } else {
      // Valores fijos para diseño estático
      r = {
        finished: !!props.finished,
        days: props.days || 0,
        hours: props.hours || 0,
        minutes: props.minutes || 0,
        seconds: props.seconds || 0,
      };
    }
    return h(
      'span',
      { className: className },
      icon('ic-lock', 20),
      h('span', { className: 'ds-countdown__title' }, props.title || ''),
      r.finished
        ? h('span', { className: 'ds-countdown__desc' }, props.description || '')
        : h(
            'span',
            { className: 'ds-countdown__times' },
            timeItem('d', pad2(r.days), props.daysLabel || '', true),
            timeItem('h', pad2(r.hours), props.hoursLabel || '', true),
            timeItem('m', pad2(r.minutes), props.minutesLabel || '', true),
            timeItem('s', pad2(r.seconds), props.secondsLabel || '', true)
          )
    );
  }
  return DotsCountdown;
})();
