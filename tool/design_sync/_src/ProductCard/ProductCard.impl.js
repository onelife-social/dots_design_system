// ProductCard — port de lib/src/components/cards/product_card/product_card.dart (Dart = fuente de verdad)
__ds.ProductCard = (function () {
  'use strict';

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function dots(count, active) {
    var items = [];
    for (var i = 0; i < count; i++) {
      items.push(h('span', {
        key: 'd' + i,
        className: 'ds-product-card__dot' + (i === active ? ' is-active' : ''),
      }));
    }
    return h('div', { className: 'ds-product-card__dots' }, items);
  }

  function ProductCard(props) {
    // Dart: AspectRatio(aspectRatio) sobre el ancho disponible; por defecto cuadrada.
    var ratio = props.aspectRatio || 1;
    var pageCount = props.pageCount || 0;
    var children = [];

    children.push(h('div', {
      key: 'bg',
      className: 'ds-product-card__bg' + (props.imageSrc ? '' : ' ds-product-card__bg--ph'),
      style: props.imageSrc ? { backgroundImage: 'url("' + props.imageSrc + '")' } : null,
    }));
    children.push(h('div', { key: 'scrim', className: 'ds-product-card__scrim' }));

    if (props.badge) {
      children.push(h('div', { key: 'badge', className: 'ds-product-card__badge' }, props.badge));
    }
    if (pageCount > 0) {
      children.push(h('div', { key: 'pc', className: 'ds-product-card__pagecontrol' },
        dots(pageCount, props.activePage || 0)));
    }

    var copy = [h('div', { key: 't', className: 'ds-product-card__title' }, props.title || '')];
    if (props.subtitle) {
      copy.push(h('div', { key: 's', className: 'ds-product-card__subtitle' }, props.subtitle));
    }
    if (props.caption) {
      var line = [h('span', { key: 'c' }, props.caption)];
      if (props.captionPrevious) {
        line.push(h('span', { key: 'cp', className: 'ds-product-card__caption-prev' }, props.captionPrevious));
      }
      copy.push(h('div', { key: 'cap', className: 'ds-product-card__caption' }, line));
    }

    var row = [h('div', { key: 'copy', className: 'ds-product-card__copy' }, copy)];
    if (props.onActionClick) {
      row.push(h('button', {
        key: 'act',
        className: 'ds-product-card__action',
        onClick: function (e) { e.stopPropagation(); props.onActionClick(); },
      }, icon({ name: props.actionIcon || 'ic-arrow-right', size: 20, color: 'currentColor' })));
    }
    children.push(h('div', { key: 'bottom', className: 'ds-product-card__bottom' }, row));

    return h('div', {
      className: 'ds-product-card' + (props.className ? ' ' + props.className : ''),
      style: { aspectRatio: String(ratio) },
      onClick: props.onClick,
      role: props.onClick ? 'button' : undefined,
    }, children);
  }

  return ProductCard;
})();
