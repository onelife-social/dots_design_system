// ColorSelector — port of lib/src/components/color_options/ (color_options.dart +
// color_selector.dart) unified in one API (Dart = source of truth).
// variant 'options'  → DotsColorOptionsRow  (DotsColorOption palette + check)
// variant 'selector' → DotsColorSelectorRow (free colors + highlight ring)
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** Dart enum DotsColorOption (the hex values live in dots_colors.dart) */
export type DotsColorOption =
  | 'textQuarternary'
  | 'couple005'
  | 'couple007'
  | 'friends001'
  | 'friends002'
  | 'friends005'
  | 'friends008'
  | 'friends010'
  | 'class005'
  | 'class009'
  | 'wedding002'
  | 'family001'
  | 'family004'
  | 'family006'
  | 'child001'
  | 'child002'
  | 'child006'
  | 'birthday003'
  | 'birthday007'
  | 'celebration002'
  | 'hobby001'
  | 'hobby002'
  | 'hobby004'
  | 'hobby005'
  | 'hobby009'
  | 'work005';

export type ColorSelectorVariant = 'options' | 'selector';

export interface ColorSelectorProps {
  /** 'options' = DotsColorOptionsRow (check when selected) · 'selector' = DotsColorSelectorRow (highlight ring). Default 'options' */
  variant?: ColorSelectorVariant;
  /**
   * Colors to show. In 'options': DotsColorOption names (default: the 15-color Dart
   * `colorOptions` palette). In 'selector': CSS colors (required).
   */
  colors?: Array<DotsColorOption | string>;
  /** Selected color (same value as in `colors`) */
  selected?: DotsColorOption | string;
  /** Called when a color is tapped — Dart `onColorSelected` */
  onColorSelected?: (color: string) => void;
  /** Diameter of each circle in px (default 32) */
  size?: number;
  /** Gap between circles in px (default: 18 in 'options', 12 in 'selector') */
  spacing?: number;
  /** Extra CSS class */
  className?: string;
}

// DotsColorOption → hex (dots_colors.dart; identical in light and dark).
// They do not exist as CSS tokens — documented exception (only textQuarternary is a token).
const OPTION_COLORS: Record<DotsColorOption, string> = {
  textQuarternary: 'var(--text-quarternary)',
  couple005: '#B66678',
  couple007: '#E55451',
  friends001: '#FAA25E',
  friends002: '#EE8062',
  friends005: '#F7954A',
  friends008: '#F5866B',
  friends010: '#F37C20',
  class005: '#F4BD24',
  class009: '#EFD58A',
  wedding002: '#E2C567',
  family001: '#77D98A',
  family004: '#9BC283',
  family006: '#8E9778',
  child001: '#82C8E5',
  child002: '#569AF8',
  child006: '#3E9ACB',
  birthday003: '#E483B3',
  birthday007: '#F38FA9',
  celebration002: '#6C7FCC',
  hobby001: '#CAB5FF',
  hobby002: '#9297EF',
  hobby004: '#C998C5',
  hobby005: '#B17DBD',
  hobby009: '#B175B1',
  work005: '#5579A9',
};

// DotsColorOptionsRow.colorOptions (Dart order)
const DEFAULT_OPTIONS: DotsColorOption[] = [
  'textQuarternary',
  'couple007',
  'friends002',
  'friends010',
  'friends005',
  'class005',
  'wedding002',
  'family006',
  'family004',
  'child006',
  'child002',
  'celebration002',
  'hobby009',
  'hobby004',
  'couple005',
];

function resolve(c: string) {
  return Object.prototype.hasOwnProperty.call(OPTION_COLORS, c) ? OPTION_COLORS[c as DotsColorOption] : c;
}

export function ColorSelector(props: ColorSelectorProps) {
  const variant: ColorSelectorVariant = props.variant === 'selector' ? 'selector' : 'options';
  const size = props.size == null ? 32 : +props.size;
  // Dart defaults: options spacing 18 · selector spacing 12
  const spacing = props.spacing == null ? (variant === 'selector' ? 12 : 18) : +props.spacing;
  const colors: string[] = Array.isArray(props.colors) && props.colors.length ? props.colors : variant === 'options' ? DEFAULT_OPTIONS : [];

  const items = colors.map((c, i) => {
    const isSelected = props.selected === c;
    const onClick = props.onColorSelected ? () => props.onColorSelected?.(c) : undefined;

    if (variant === 'selector') {
      // DotsColorSelectorRow._colorItem: labelHighlight ring 1.5 + shaded dot
      // (colorSelectorShadow) + inner black 25% border when selected.
      return (
        <button
          key={i}
          type="button"
          className={`ds-color-selector__swatch${isSelected ? ' is-selected' : ''}`}
          style={{ width: `${size}px`, height: `${size}px` }}
          onClick={onClick}
          aria-pressed={isSelected}
          aria-label={String(c)}
        >
          {/* backgroundColor (not the shorthand) — the colorSelectorShadow texture is the background-image (CSS) */}
          <span className="ds-color-selector__dot" style={{ backgroundColor: resolve(c) }} />
        </button>
      );
    }

    // DotsColorOptionsRow: circle with black 10% (1.5) / 25% (2) border + check
    return (
      <button
        key={i}
        type="button"
        className={`ds-color-selector__option${isSelected ? ' is-selected' : ''}`}
        style={{ width: `${size}px`, height: `${size}px`, backgroundColor: resolve(c) }}
        onClick={onClick}
        aria-pressed={isSelected}
        aria-label={String(c)}
      >
        {isSelected ? <DotsIcon name="ic-check-thick" size={size * 0.5} color="var(--label-always-white)" /> : null}
      </button>
    );
  });

  return (
    <div
      className={`ds-color-selector ds-color-selector--${variant}${props.className ? ` ${props.className}` : ''}`}
      style={{ gap: `${spacing}px` }}
      role="radiogroup"
    >
      {items}
    </div>
  );
}

/** DotsColorOption → CSS color map (dots_colors.dart) */
ColorSelector.OPTION_COLORS = OPTION_COLORS;
/** Default palette of the 'options' variant (Dart DotsColorOptionsRow.colorOptions) */
ColorSelector.DEFAULT_OPTIONS = DEFAULT_OPTIONS;
