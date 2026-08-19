// BadgeTag — port de lib/src/components/badges/badge_tag.dart (Dart = fuente de verdad).
// Standalone oficial: DotsSegmentedControl (.ds-seg__tag) y DotsIconButton
// (.ds-icon-btn__tag) pintan su propio tag inline — clases distintas, sin colisión.
__ds.BadgeTag = (function () {
  'use strict';

  function body(tag, floating, offset) {
    return h(
      'span',
      {
        className: 'ds-badge-tag' + (floating ? ' ds-badge-tag--floating' : ''),
        style: floating
          ? {
              // Dart: Positioned(right: size?.width ?? -5, top: size?.height ?? -5)
              right: (offset && offset.width != null ? offset.width : -5) + 'px',
              top: (offset && offset.height != null ? offset.height : -5) + 'px',
            }
          : undefined,
      },
      tag ? tag : null // Dart: tag.isEmpty → SizedBox.shrink() (píldora vacía 18x18)
    );
  }

  function BadgeTag(props) {
    if (props.children == null) return body(props.tag, false);
    return h(
      'span',
      { className: 'ds-badge-tag-host' },
      props.children,
      body(props.tag, true, props.size)
    );
  }

  return BadgeTag;
})();
