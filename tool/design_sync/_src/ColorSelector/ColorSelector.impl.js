// ColorSelector — port de lib/src/components/color_options/ (color_options.dart +
// color_selector.dart) unificados en una API (Dart = fuente de verdad).
// variant 'options'  → DotsColorOptionsRow  (paleta DotsColorOption + check)
// variant 'selector' → DotsColorSelectorRow (colores libres + anillo highlight)
__ds.ColorSelector = (function () {
  'use strict';

  // DotsColorOption → hex (dots_colors.dart; idénticos en light y dark).
  // No existen como tokens CSS — excepción documentada (solo textQuarternary es token).
  var OPTION_COLORS = {
    textQuarternary: 'var(--text-quarternary)',
    couple005: '#B66678', couple007: '#E55451',
    friends001: '#FAA25E', friends002: '#EE8062', friends005: '#F7954A',
    friends008: '#F5866B', friends010: '#F37C20',
    class005: '#F4BD24', class009: '#EFD58A',
    wedding002: '#E2C567',
    family001: '#77D98A', family004: '#9BC283', family006: '#8E9778',
    child001: '#82C8E5', child002: '#569AF8', child006: '#3E9ACB',
    birthday003: '#E483B3', birthday007: '#F38FA9',
    celebration002: '#6C7FCC',
    hobby001: '#CAB5FF', hobby002: '#9297EF', hobby004: '#C998C5',
    hobby005: '#B17DBD', hobby009: '#B175B1',
    work005: '#5579A9',
  };

  // DotsColorOptionsRow.colorOptions (orden Dart)
  var DEFAULT_OPTIONS = [
    'textQuarternary', 'couple007', 'friends002', 'friends010', 'friends005',
    'class005', 'wedding002', 'family006', 'family004', 'child006', 'child002',
    'celebration002', 'hobby009', 'hobby004', 'couple005',
  ];

  function resolve(c) {
    return Object.prototype.hasOwnProperty.call(OPTION_COLORS, c) ? OPTION_COLORS[c] : c;
  }

  function ColorSelector(props) {
    var variant = props.variant === 'selector' ? 'selector' : 'options';
    var size = props.size == null ? 32 : +props.size;
    // Defaults Dart: options spacing 18 · selector spacing 12
    var spacing = props.spacing == null ? (variant === 'selector' ? 12 : 18) : +props.spacing;
    var colors = Array.isArray(props.colors) && props.colors.length
      ? props.colors
      : (variant === 'options' ? DEFAULT_OPTIONS : []);

    var items = colors.map(function (c, i) {
      var isSelected = props.selected === c;
      var onClick = props.onColorSelected
        ? function () { props.onColorSelected(c); }
        : undefined;

      if (variant === 'selector') {
        // DotsColorSelectorRow._colorItem: anillo labelHighlight 1.5 + dot con
        // sombreado (colorSelectorShadow) + borde interior negro 25% si sel.
        return h(
          'button',
          {
            key: i,
            type: 'button',
            className: 'ds-color-selector__swatch' + (isSelected ? ' is-selected' : ''),
            style: { width: size + 'px', height: size + 'px' },
            onClick: onClick,
            'aria-pressed': isSelected,
            'aria-label': String(c),
          },
          // backgroundColor (no shorthand) — la textura colorSelectorShadow va en background-image (CSS)
          h('span', { className: 'ds-color-selector__dot', style: { backgroundColor: resolve(c) } })
        );
      }

      // DotsColorOptionsRow: círculo con borde negro 10% (1.5) / 25% (2) + check
      return h(
        'button',
        {
          key: i,
          type: 'button',
          className: 'ds-color-selector__option' + (isSelected ? ' is-selected' : ''),
          style: { width: size + 'px', height: size + 'px', backgroundColor: resolve(c) },
          onClick: onClick,
          'aria-pressed': isSelected,
          'aria-label': String(c),
        },
        isSelected
          ? (__ds.DotsIcon
              ? h(__ds.DotsIcon, { name: 'ic-check-thick', size: size * 0.5, color: 'var(--label-always-white)' })
              : h('span', { style: { width: size * 0.5 + 'px', height: size * 0.5 + 'px', display: 'inline-block' } }))
          : null
      );
    });

    return h(
      'div',
      {
        className: 'ds-color-selector ds-color-selector--' + variant +
          (props.className ? ' ' + props.className : ''),
        style: { gap: spacing + 'px' },
        role: 'radiogroup',
      },
      items
    );
  }

  ColorSelector.OPTION_COLORS = OPTION_COLORS;
  ColorSelector.DEFAULT_OPTIONS = DEFAULT_OPTIONS;
  return ColorSelector;
})();
