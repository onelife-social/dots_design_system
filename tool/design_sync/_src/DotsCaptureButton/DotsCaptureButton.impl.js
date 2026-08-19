// DotsCaptureButton — port de lib/src/components/buttons/capture_button/ (Dart = fuente de verdad)
__ds.DotsCaptureButton = (function () {
  'use strict';

  var DIAMETER = 80; // _kCaptureButtonDiameter
  var INNER = 68; // _kCaptureButtonInnerDiameter
  var INNER_RECORDING = 60; // _kCaptureButtonInnerDiameterRecording (photo + recording)
  var STROKE = 6; // _kCaptureButtonRingStroke
  var RADIUS = (DIAMETER - STROKE) / 2; // 37 — arco con inset stroke/2, como el CustomPainter
  var CIRC = 2 * Math.PI * RADIUS;

  function DotsCaptureButton(props) {
    const { useState, useEffect, useRef } = hooks();
    var type = props.type === 'video' ? 'video' : 'photo'; // DotsCaptureButtonType
    var controlled = props.state !== undefined && props.state !== null; // DotsCaptureButtonState
    const [internalRecording, setInternalRecording] = useState(false);
    var recording = controlled ? props.state === 'recording' : internalRecording;
    const [progress, setProgress] = useState(0);
    var maxTime = props.maxTimeRecording > 0 ? props.maxTimeRecording : 60; // Dart: default 60
    const stopCbRef = useRef(null);
    stopCbRef.current = props.onStopRecording;
    var animating = type === 'video' && recording;

    // Timer de progreso (Timer.periodic 50 ms en Dart); al llegar a 1 → onStopRecording
    useEffect(
      function () {
        if (!animating) {
          setProgress(0);
          return undefined;
        }
        var start = Date.now();
        var id = setInterval(function () {
          var raw = Math.min((Date.now() - start) / (maxTime * 1000), 1);
          setProgress(raw);
          if (raw >= 1) {
            clearInterval(id);
            setInternalRecording(false);
            if (typeof stopCbRef.current === 'function') stopCbRef.current();
          }
        }, 50);
        return function () {
          clearInterval(id);
        };
      },
      [animating, maxTime],
    );

    function handleClick() {
      if (type === 'photo') {
        if (typeof props.onTakePicture === 'function') props.onTakePicture();
        return;
      }
      if (recording) {
        if (!controlled) setInternalRecording(false);
        if (typeof props.onStopRecording === 'function') props.onStopRecording();
      } else {
        if (!controlled) setInternalRecording(true);
        if (typeof props.onStartRecording === 'function') props.onStartRecording();
      }
    }

    var children;
    if (type === 'photo' || !recording) {
      // _ActiveButton — inner Ø68 (photo·recording: Ø60); photo blanco, video labelDestructive
      var inner = type === 'photo' && recording ? INNER_RECORDING : INNER;
      children = h('span', {
        className: 'ds-capture__inner ds-capture__inner--' + type,
        style: { width: inner + 'px', height: inner + 'px' },
      });
    } else {
      // _RecordingButton — arco de progreso blanco (round cap) + stop 32 r8 destructive
      children = [
        h(
          'svg',
          { key: 'ring', className: 'ds-capture__ring', viewBox: '0 0 80 80', 'aria-hidden': true },
          h('circle', {
            cx: 40,
            cy: 40,
            r: RADIUS,
            fill: 'none',
            stroke: 'var(--label-always-white)',
            strokeWidth: STROKE,
            strokeLinecap: 'round',
            strokeDasharray: progress * CIRC + ' ' + CIRC,
          }),
        ),
        h('span', { key: 'stop', className: 'ds-capture__stop' }),
      ];
    }

    return h(
      'button',
      {
        type: 'button',
        className: 'ds-capture',
        'aria-label': type === 'photo' ? 'Tomar foto' : recording ? 'Detener grabación' : 'Grabar vídeo',
        onClick: handleClick,
      },
      children,
    );
  }

  return DotsCaptureButton;
})();
