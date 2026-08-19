// DotsListItem — port de lib/src/components/dots_list_items/dots_list_items.dart (Dart = fuente de verdad, widget DotsListsItem)
__ds.DotsListItem = (function () {
  'use strict';

  function renderThumb(props) {
    const Icon = __ds.DotsIcon;
    const variant = props.variant || 'main';
    const picType = props.picType || 'album';
    if (props.imageSrc && variant !== 'icon' && picType === 'album') {
      // DotsImageThumbnail variant image — 40×40, radius 12, cover
      return h('span', {
        className: 'ds-list-item__thumb ds-list-item__thumb--album',
        style: { backgroundImage: 'url("' + props.imageSrc + '")' },
      });
    }
    if (props.imageSrc && variant !== 'icon' && picType === 'user') {
      // círculo 40, fondo bgBaseContrast, imagen recortada en óvalo
      return h(
        'span',
        { className: 'ds-list-item__thumb ds-list-item__thumb--user' },
        h('img', { src: props.imageSrc, alt: '', onError: props.onError }),
      );
    }
    // DotsImageThumbnail variant icon — bg bgContainerSecondaryOnBackground, icono 20 textPrimary
    return h(
      'span',
      { className: 'ds-list-item__thumb ds-list-item__thumb--icon' },
      Icon
        ? h(Icon, { name: props.iconName || 'ic-user', size: 20, color: 'var(--text-primary)' })
        : null,
    );
  }

  function renderTrailing(variant) {
    const Radio = __ds.DotsRadioButton;
    const Icon = __ds.DotsIcon;
    if (variant === 'selector' || variant === 'radioButton') {
      if (Radio) return h(Radio, { isSelected: variant === 'radioButton', size: 22 });
      // fallback si DotsRadioButton no está en el bundle
      return h('span', {
        className: 'ds-list-item__radio-fallback' + (variant === 'radioButton' ? ' is-on' : ''),
      });
    }
    if (variant === 'check') {
      // DotsSelector.check(size: small(22), isSelected: true) — pill labelHighlight, check 14 blanco
      return h(
        'span',
        { className: 'ds-list-item__check' },
        Icon ? h(Icon, { name: 'ic-check', size: 14, color: 'var(--label-always-white)' }) : null,
      );
    }
    return null;
  }

  function DotsListItem(props) {
    const variant = props.variant || 'main';

    if (variant === 'divider') {
      return h(
        'div',
        { className: 'ds-list-item ds-list-item--divider' },
        h('div', { className: 'ds-list-item__divider-label' }, props.label || ''),
        h('div', { className: 'ds-list-item__hairline' }),
      );
    }

    return h(
      'div',
      {
        className: 'ds-list-item' + (props.onClick ? ' is-tappable' : ''),
        onClick: props.onClick,
        role: props.onClick ? 'button' : undefined,
      },
      renderThumb(props),
      props.label != null ? h('span', { className: 'ds-list-item__label' }, props.label) : null,
      renderTrailing(variant),
    );
  }
  return DotsListItem;
})();
