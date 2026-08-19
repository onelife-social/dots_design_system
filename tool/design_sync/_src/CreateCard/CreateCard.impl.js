// CreateCard — port de lib/src/components/cards/create_card/create_card.dart (Dart = fuente de verdad)
__ds.CreateCard = (function () {
  'use strict';

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function CreateCard(props) {
    var variant = props.variant === 'button' ? 'button' : 'label'; // CreateCardVariant, default label
    var width = props.width == null ? 164 : props.width;           // Dart: width = 164, height fija 112

    if (variant === 'button') {
      // _PromptCardCreateContent → DotsIconButton large columna: círculo add + label
      return h('div', {
        className: 'ds-create-card ds-create-card--button' + (props.className ? ' ' + props.className : ''),
        style: { width: width + 'px' },
        onClick: props.onClick,
        role: props.onClick ? 'button' : undefined,
      },
        h('span', { className: 'ds-create-card__circle' }, icon({ name: 'ic-add', size: 16, color: 'currentColor' })),
        h('span', { className: 'ds-create-card__btn-label' }, props.title || '')
      );
    }

    // variant label — degradado horizontal primaryColor→secondaryColor (Dart no pinta fondo sin
    // primaryColor; aquí cae al degradado verde de marca del CSS para no dejar la tarjeta invisible)
    var style = { width: width + 'px' };
    if (props.primaryColor) {
      style.background = 'linear-gradient(90deg, ' + props.primaryColor + ', ' + (props.secondaryColor || props.primaryColor) + ')';
    }
    return h('div', {
      className: 'ds-create-card ds-create-card--label' + (props.className ? ' ' + props.className : ''),
      style: style,
      onClick: props.onClick,
      role: props.onClick ? 'button' : undefined,
    },
      props.icon ? h('span', { className: 'ds-create-card__icon' }, icon({ name: props.icon, size: 32, color: 'currentColor' })) : null,
      h('span', { className: 'ds-create-card__title' }, props.title || ''),
      // DotsIconButton medium (Ø28) disabled — bgBtnImage al 40%, icono add blanco
      h('span', { className: 'ds-create-card__add' }, icon({ name: 'ic-add', size: 14, color: 'currentColor' }))
    );
  }

  return CreateCard;
})();
