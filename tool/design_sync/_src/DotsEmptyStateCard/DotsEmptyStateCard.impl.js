// DotsEmptyStateCard — port de lib/src/components/empty_state/empty_state_card.dart (Dart = fuente de verdad).
// El ancho Dart (82% del ancho de pantalla) se sustituye por width:100% — dimensiona el contenedor padre.
__ds.DotsEmptyStateCard = (function () {
  'use strict';

  function DotsEmptyStateCard(props) {
    var variant = props.variant === 'image' ? 'image' : 'icon';
    var extra = props.extraSpaceAfterImage == null ? 0 : props.extraSpaceAfterImage;
    // Gap media→título: imagen 4 (+extraSpaceAfterImage), icono 16
    var gap = variant === 'image' ? 4 + extra : 16;

    var media = null;
    if (variant === 'image' && props.image) {
      media = h('img', {
        className: 'ds-empty-card__image',
        src: props.image,
        alt: '',
        style: props.imageWidth != null ? { width: props.imageWidth + 'px' } : null,
      });
    } else if (variant === 'icon' && props.icon) {
      // Dart recibe un widget DotsIcon; aquí: string (nombre de icono, 48px
      // textQuarternary por defecto) o nodo React ya construido.
      media = typeof props.icon === 'string'
        ? (__ds.DotsIcon
            ? h(__ds.DotsIcon, { name: props.icon, size: 48, color: 'var(--text-quarternary)' })
            : null)
        : props.icon;
    }

    var descProps = { className: 'ds-empty-card__desc' };
    if (props.descriptionColor) descProps.style = { color: props.descriptionColor };
    var desc;
    if (props.descriptionSpans != null) {
      // descriptionSpans sustituye al texto; description queda como etiqueta accesible
      descProps['aria-label'] = props.description;
      desc = h('p', descProps, props.descriptionSpans);
    } else {
      desc = h('p', descProps, props.description);
    }

    return h(
      'div',
      { className: 'ds-empty-card' + (props.className ? ' ' + props.className : '') },
      media ? h('div', { className: 'ds-empty-card__media', style: { marginBottom: gap + 'px' } }, media) : null,
      h(
        'p',
        {
          className: 'ds-empty-card__title',
          style: props.titleColor ? { color: props.titleColor } : null,
        },
        props.title
      ),
      desc,
      props.button ? h('div', { className: 'ds-empty-card__button' }, props.button) : null
    );
  }

  return DotsEmptyStateCard;
})();
