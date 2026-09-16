// DotsPlanningItem — port of lib/src/components/planning/ (dots_planning_item.dart +
// dots_planning_info_item.dart + dots_planning_row_builder.dart) (Dart = source of truth).
import { useState } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

/** Mirror of the Dart class DotsPlanningInfoItem */
export interface DotsPlanningInfoItem {
  /** Real icon name (assets/icons) — Dart DotsIconData */
  icon?: string;
  /** Row text. Rows without icon or without text are not painted */
  text?: string;
  /** Underline (only the location row) — Dart `underline` (default false) */
  underline?: boolean;
}

export interface DotsPlanningItemProps {
  /** Section image URL — Dart `sectionImage`. Default: default_section_planning.webp (data URI) */
  sectionImage?: string;
  /** Section title (bodyLargeMedium) — Dart `mainText` */
  mainText: string;
  /** Collapsed icon — Dart `mainIcon` (default 'ic-chevron-down') */
  mainIcon?: string;
  /** Expanded icon — Dart `mainIconActive` (default 'ic-chevron-up') */
  mainIconActive?: string;
  /** Main row, always visible — Dart `mainItem` */
  mainItem?: DotsPlanningInfoItem;
  /** Rows visible only when expanded — Dart `subItems` (default []) */
  subItems?: DotsPlanningInfoItem[];
  /** Initial state (uncontrolled). Tap toggles. Default false */
  defaultExpanded?: boolean;
  /** Controlled state: when given, the component does not manage the toggle internally */
  expanded?: boolean;
  /** Toggle notification with the next state (useful in controlled mode) */
  onToggle?: (expanded: boolean) => void;
  className?: string;
}

// DotsPlanningItemRow (dots_planning_row_builder.dart): skips rows without icon or without text
function row(item: DotsPlanningInfoItem | undefined, key: string | number) {
  if (!item || !item.icon || item.text == null || !String(item.text).trim()) return null;
  return (
    <span className="ds-planning-item__row" key={key}>
      <span className="ds-planning-item__row-icon" aria-hidden>
        <DotsIcon name={item.icon} size={16} color="var(--label-primary)" />
      </span>
      <span className={`ds-planning-item__row-text${item.underline ? ' is-underline' : ''}`}>{item.text}</span>
    </span>
  );
}

export function DotsPlanningItem(props: DotsPlanningItemProps) {
  const [internal, setInternal] = useState(!!props.defaultExpanded);
  const controlled = props.expanded != null;
  const expanded = controlled ? !!props.expanded : internal;

  function toggle() {
    props.onToggle?.(!expanded);
    if (!controlled) setInternal(!expanded);
  }

  // Dart: mainIcon/mainIconActive default chevronDown/chevronUp
  const chevron = expanded ? props.mainIconActive || 'ic-chevron-up' : props.mainIcon || 'ic-chevron-down';
  const subItems = props.subItems ?? [];

  return (
    <div className={`ds-planning-item${props.className ? ` ${props.className}` : ''}`} onClick={toggle}>
      {/* _PlanningImage: DotsSquircleImage 52 squircle16, default default_section_planning.webp */}
      <span className="ds-planning-item__img" style={props.sectionImage ? { backgroundImage: `url(${props.sectionImage})` } : undefined} />
      <span className="ds-planning-item__col">
        {/* _PlanningTitle: bodyLargeMedium textPrimary + DotsIcon 20 textQuarternary */}
        <span className="ds-planning-item__title-row">
          <span className="ds-planning-item__title">{props.mainText}</span>
          <span className="ds-planning-item__chevron" aria-hidden>
            <DotsIcon name={chevron} size={20} color="var(--text-quarternary)" />
          </span>
        </span>
        {props.mainItem ? row(props.mainItem, 'main') : null}
        {/* _PlanningAnimatedSwitcher (200ms easeOut/easeIn, slide -0.1 + fade) */}
        <span className={`ds-planning-item__sub${expanded ? ' is-expanded' : ''}`}>
          <span className="ds-planning-item__sub-inner">{subItems.map((it, i) => row(it, i))}</span>
        </span>
      </span>
    </div>
  );
}
