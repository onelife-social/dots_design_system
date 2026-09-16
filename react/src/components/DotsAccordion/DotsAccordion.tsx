// DotsAccordion — port of lib/src/components/accordion/dots_accordion.dart (Dart = source of truth).
import { useState, type CSSProperties, type ReactNode } from 'react';
import { DotsIcon } from '../DotsIcon/DotsIcon';

export interface DotsAccordionSection {
  /** Header title — bodyLargeMedium textPrimary */
  title: string;
  /** Expanded content — Dart `content` (Widget) */
  content?: ReactNode;
  /** Icon name (asset ic-…) left of the title — Dart `leadingIcon` */
  leadingIcon?: string;
  /** Initially open */
  expanded?: boolean;
}

export interface DotsAccordionProps {
  /** Accordion sections */
  sections: DotsAccordionSection[];
  /** Only one section open at a time (default true) */
  singleOpen?: boolean;
  /** Expand animation duration in ms — Dart `animationDuration` (default 180) */
  animationDuration?: number;
  /** 16px horizontal padding on headers and content (default true) */
  addHorizontalPadding?: boolean;
  /** Web extension: notifies the toggle of a section */
  onToggle?: (index: number, expanded: boolean) => void;
}

function Divider() {
  // DotsDivider — two 1px lines (labelSecondary + bgStrong), opacity 0.6, radius 1000
  return (
    <div className="ds-accordion__divider">
      <div className="ds-accordion__divider-l1" />
      <div className="ds-accordion__divider-l2" />
    </div>
  );
}

export function DotsAccordion(props: DotsAccordionProps) {
  const sections = props.sections || [];
  const singleOpen = props.singleOpen !== false;
  const duration = props.animationDuration ?? 180;
  const addHPad = props.addHorizontalPadding !== false;

  const [state, setState] = useState<boolean[] | null>(null);
  const expanded = state && state.length === sections.length ? state : sections.map((s) => !!s?.expanded);

  function toggle(index: number) {
    const next = expanded.map((v, i) => {
      if (singleOpen) return i === index ? !v : false;
      return i === index ? !v : v;
    });
    setState(next);
    props.onToggle?.(index, next[index]);
  }

  const children: ReactNode[] = [];
  for (let i = 0; i < sections.length; i++) {
    const s = sections[i] || ({} as DotsAccordionSection);
    if (i > 0) children.push(<Divider key={`div-${i}`} />);
    children.push(
      <div
        key={`sec-${i}`}
        className={`ds-accordion__section${expanded[i] ? ' is-expanded' : ''}`}
        style={{ '--ds-accordion-duration': `${duration}ms` } as CSSProperties}
      >
        <div className="ds-accordion__header" role="button" aria-expanded={!!expanded[i]} onClick={() => toggle(i)}>
          {s.leadingIcon ? <DotsIcon name={s.leadingIcon} size={20} color="var(--text-tertiary)" className="ds-accordion__leading" /> : null}
          <span className="ds-accordion__title">{s.title}</span>
          <DotsIcon name="ic-chevron-down" size={16} color="var(--text-tertiary)" className="ds-accordion__chevron" />
        </div>
        {/* AnimatedSize → grid-template-rows 0fr→1fr with transition */}
        <div className="ds-accordion__collapse">
          <div className="ds-accordion__collapse-inner">
            <div className="ds-accordion__content">{s.content}</div>
          </div>
        </div>
      </div>,
    );
  }

  return <div className={`ds-accordion${addHPad ? ' ds-accordion--hpad' : ''}`}>{children}</div>;
}
