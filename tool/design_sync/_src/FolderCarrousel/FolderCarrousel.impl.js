// FolderCarrousel — port de lib/src/components/carrousels/folder_carrousel.dart (Dart = fuente de verdad)
__ds.FolderCarrousel = (function () {
  'use strict';
  function FolderCarrousel(props) {
    var items = props.items || [];
    var showEditIcon = !!props.showEditIcon;
    var onSelect = props.onSelect;
    var Btn = __ds.BtnFolder;

    var nodes = items.map(function (item, i) {
      var handleClick =
        item.onClick ||
        (onSelect
          ? function () {
              onSelect(i);
            }
          : undefined);
      if (Btn) {
        return h(Btn, {
          key: i,
          icon: item.icon,
          text: item.text,
          onClick: handleClick,
          onLongPress: item.onLongPress, // BtnFolderData.onPressed
          isSelected: !!item.isSelected,
          // iconSelectedColor requerido en Dart; #3E9ACB = azul carpeta del home (child006, sin token)
          iconSelectedColor: item.iconSelectedColor || '#3E9ACB',
          isNonExpandable: !!item.isNonExpandable,
          isEditable: !!item.isEditable,
          showEditIcon: showEditIcon,
        });
      }
      // Fallback si BtnFolder no está en el bundle
      return h(
        'button',
        {
          key: i,
          type: 'button',
          className:
            'ds-folder-carrousel__fallback' + (item.isSelected ? ' is-selected' : ''),
          onClick: handleClick,
        },
        __ds.DotsIcon ? h(__ds.DotsIcon, { name: item.icon, size: 20 }) : null,
        item.text != null ? h('span', null, item.text) : null
      );
    });

    return h(
      'div',
      { className: 'ds-folder-carrousel' + (props.className ? ' ' + props.className : '') },
      nodes,
      // customWidgets (DefaultFolderWidget) — nodos extra al final de la fila
      props.children
    );
  }
  return FolderCarrousel;
})();
