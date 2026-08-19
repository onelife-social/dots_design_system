// BtnFolder — port de lib/src/components/buttons/btn_folder/ (Dart = fuente de verdad)
__ds.BtnFolder = (function () {
  'use strict';
  var LONG_PRESS_MS = 500;

  function BtnFolder(props) {
    var R = hooks();
    var useRef = R.useRef;
    var timer = useRef(null);
    var fired = useRef(false);

    function startPress() {
      fired.current = false;
      if (!props.onLongPress) return;
      timer.current = setTimeout(function () {
        fired.current = true;
        props.onLongPress();
      }, LONG_PRESS_MS);
    }
    function cancelPress() {
      if (timer.current) { clearTimeout(timer.current); timer.current = null; }
    }
    function handleClick() {
      if (fired.current) { fired.current = false; return; } // el long-press ya consumió el gesto
      if (props.onClick) props.onClick();
    }

    var isSelected = !!props.isSelected;
    var isNonExpandable = !!props.isNonExpandable;
    // iconSelectedColor es requerido en Dart; #3E9ACB = azul de carpeta del home (child006, sin token)
    var selColor = props.iconSelectedColor || '#3E9ACB';
    var text = props.text != null ? String(props.text) : null;
    if (text && text.length > 20) text = text.substring(0, 20) + '…';

    var pill = h('button', {
      type: 'button',
      className: 'ds-btn-folder__pill' +
        (isSelected ? ' ds-btn-folder__pill--selected' : '') +
        (isNonExpandable ? ' ds-btn-folder__pill--nonexp' : ''),
      onClick: handleClick,
      onPointerDown: startPress,
      onPointerUp: cancelPress,
      onPointerLeave: cancelPress,
      onContextMenu: function (e) { if (props.onLongPress) e.preventDefault(); },
    },
      h('span', {
        className: 'ds-btn-folder__icon',
        style: isSelected && !isNonExpandable ? { color: selColor } : undefined,
      }, h(__ds.DotsIcon, { name: props.icon, size: 20 })),
      !isNonExpandable && text ? h('span', { className: 'ds-btn-folder__text' }, text) : null
    );

    var edit = (props.showEditIcon && props.isEditable)
      ? h('button', {
          type: 'button',
          className: 'ds-btn-folder__edit',
          onClick: props.onLongPress,
          'aria-label': 'Editar carpeta',
        }, h(__ds.DotsIcon, { name: 'ic-pencil', size: 10 }))
      : null;

    return h('span', { className: 'ds-btn-folder' },
      h('span', { className: 'ds-btn-folder__clip' }, pill),
      edit
    );
  }
  return BtnFolder;
})();
