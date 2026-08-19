// DotsToast — port de lib/src/components/toast/ (Dart = fuente de verdad).
// Unifica DotsToast + DotsToastInfo (isAction: false) + DotsToastAction (isAction: true):
// los wrappers Dart solo fijan isAction, aquí es una prop.
__ds.DotsToast = (function () {
  'use strict';

  // DotsToastVariant
  var VARIANTS = ['success', 'error', 'info', 'progress', 'connectionResumed', 'connectionLost', 'widget'];

  // DotsToast.iconData(variant, isAction) — nombres reales de assets/icons
  function iconName(variant, isAction) {
    switch (variant) {
      case 'success': return 'ic-check-circle';
      case 'error': return isAction ? 'ic-trash' : 'ic-cross-circle';
      case 'info': return 'ic-alert-circle';
      case 'connectionResumed': return 'ic-connection-on';
      case 'connectionLost': return 'ic-connection-off';
      default: return 'ic-slot'; // progress | widget → DotsIconData.progressSpinner ('ic-slot.svg')
    }
  }

  // DotsToast.iconColor(theme)
  function iconColor(variant) {
    switch (variant) {
      case 'success':
      case 'connectionResumed': return 'var(--label-highlight)';
      case 'error':
      case 'connectionLost': return 'var(--label-destructive)';
      default: return 'var(--text-tertiary)'; // info | progress | widget
    }
  }

  function iconEl(name, size, color, spin) {
    return h(
      'span',
      { className: 'ds-toast__icon' + (spin ? ' ds-toast__icon--spin' : ''), 'aria-hidden': true },
      __ds.DotsIcon
        ? h(__ds.DotsIcon, { name: name, size: size, color: color })
        : h('span', { style: { width: size + 'px', height: size + 'px', display: 'inline-block' } })
    );
  }

  function DotsToast(props) {
    var variant = VARIANTS.indexOf(props.variant) >= 0 ? props.variant : 'info';
    var isAction = !!props.isAction;
    var isProgress = variant === 'progress';
    var name = props.customIcon || iconName(variant, isAction);
    var color = props.customIconColor || iconColor(variant);

    var className = 'ds-toast ' + (isAction ? 'ds-toast--action' : 'ds-toast--info');
    if (props.onClick) className += ' ds-toast--clickable';
    if (props.className) className += ' ' + props.className;

    var titleEl = h('span', { className: 'ds-toast__title' }, props.title);

    var children;
    if (isAction) {
      // Columna 160: icono (o customWidget si variant widget) + título. Icono: progress 20, resto 24.
      var top = variant === 'widget'
        ? (props.customWidget || null)
        : iconEl(name, isProgress ? 20 : 24, color, false);
      children = [top, titleEl];
    } else {
      // Fila 358: icono + título + botón ghost (solo progress). En progress el icono rota
      // y va SIN tint (colores propios de ic-slot), como _RotatingIcon en Dart.
      var lead = isProgress ? iconEl(name, 24, undefined, true) : iconEl(name, 20, color, false);
      var btn = null;
      if (props.btnTitle != null && isProgress) {
        btn = __ds.DotsMainButton
          ? h(__ds.DotsMainButton, {
              label: props.btnTitle,
              variant: 'ghost',
              size: 'medium',
              adaptPaddingForText: true,
              expand: false,
              onClick: props.onClick,
            })
          : h('button', { type: 'button', className: 'ds-toast__btn-fallback', onClick: props.onClick }, props.btnTitle);
      }
      children = [lead, titleEl, btn];
    }

    return h('div', { className: className, role: 'status', onClick: props.onClick }, children);
  }

  return DotsToast;
})();
