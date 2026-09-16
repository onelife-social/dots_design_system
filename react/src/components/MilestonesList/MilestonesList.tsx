// MilestonesList — port of lib/src/components/milestones/milestones_list.dart (Dart = source of truth).
import { isValidElement, useLayoutEffect, useMemo, useRef, useState, type ReactElement } from 'react';
import { BadgeMilestone } from '../BadgeMilestone/BadgeMilestone';
import { MilestoneCard, type MilestoneCardProps } from '../MilestoneCard/MilestoneCard';

/**
 * string ⇒ BadgeMilestone ghost · object ⇒ MilestoneCard props · or an already built element.
 * A built element is laid out as a badge (17px) when its type is `BadgeMilestone` and as a card
 * (326px) otherwise. The list's fixed card width (244.5px, aspect 3:4) is authoritative: a
 * `MilestoneCardProps.width` is ignored so every card stays aligned on the path.
 */
export type MilestonesListItem = string | MilestoneCardProps | ReactElement;

export interface MilestonesListProps {
  /** Items in vertical order — Dart `list` (List<String | MilestoneCard>) */
  list: MilestonesListItem[];
  /** Seed of the path (20–34 gaps between cards and x-pattern alternation) — Dart `seed` (default 1) */
  seed?: number;
  /** Fixed width in px; when omitted the container is measured and observed (ResizeObserver; centerX = width/2) */
  width?: number;
  className?: string;
}

// Dart constants
const CARD_HEIGHT = 326;
const BADGE_HEIGHT = 17;
const TAIL_EXTENSION = 64;
const CARD_WIDTH = (CARD_HEIGHT * 3) / 4; // MilestoneCard aspect 3:4 → 244.5
const PATTERN_1 = [0, -23, 37, 16, -38];
const PATTERN_2 = [0, -38, 37, -39, 29, 37];
const BEND = 20;

interface Point {
  x: number;
  y: number;
}

// Deterministic PRNG (mulberry32) — functional mirror of Dart's Random(seed)
// (same seed ⇒ same layout across renders; sequence ≠ bit for bit with Dart)
function rng(seed: number) {
  let a = seed >>> 0;
  return function () {
    a |= 0;
    a = (a + 0x6d2b79f5) | 0;
    let t = Math.imul(a ^ (a >>> 15), 1 | a);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

function isCard(item: MilestonesListItem) {
  if (typeof item === 'string') return false;
  // A pre-built BadgeMilestone element gets the badge spacing, any other element is a card
  if (isValidElement(item)) return item.type !== BadgeMilestone;
  return true;
}

function itemHeight(item: MilestonesListItem) {
  return isCard(item) ? CARD_HEIGHT : BADGE_HEIGHT;
}

// gap = random 20–34 between cards, 64 between badge and card (or vice versa)
function verticalSpacing(curr: MilestonesListItem, next: MilestonesListItem, rand: () => number) {
  const gap = isCard(curr) && isCard(next) ? 20 + Math.floor(rand() * 15) : 64;
  return itemHeight(curr) / 2 + gap + itemHeight(next) / 2;
}

function layout(list: MilestonesListItem[], seed: number, centerX: number) {
  const rand = rng(seed);
  // Dart assumes the first item is always a badge (badgeHeight / 2); the web list accepts any order,
  // so the first center sits at half of the first item's real height (a leading card is not clipped
  // by the overflow-hidden container).
  const topPadding = list.length ? itemHeight(list[0]) / 2 : BADGE_HEIGHT / 2;
  const bottomPadding = CARD_HEIGHT / 2 + TAIL_EXTENSION; // Dart: last item is always a card + tail
  const count = list.length;

  // x patterns: starts with pattern1, then alternates randomly
  const xs: number[] = [];
  let pattern = PATTERN_1;
  while (xs.length < count) {
    for (let k = 0; k < pattern.length && xs.length < count; k++) xs.push(pattern[k]);
    pattern = rand() < 0.5 ? PATTERN_1 : PATTERN_2;
  }

  const points: Point[] = [];
  let y = topPadding;
  let total = topPadding;
  for (let i = 0; i < count; i++) {
    points.push({ x: centerX + xs[i], y });
    if (i < count - 1) {
      const sp = verticalSpacing(list[i], list[i + 1], rand);
      y += sp;
      total += sp;
    }
  }
  total += bottomPadding;
  // Tail: extends the line as if there were a last ghost card
  if (count > 0) points.push({ x: centerX + xs[count - 1], y: y + CARD_HEIGHT / 2 + TAIL_EXTENSION });
  return { points, totalHeight: total };
}

// _BezierTimelinePainter: quadratics with the control point at the midpoint ± bend 20
function pathD(points: Point[]) {
  if (!points.length) return '';
  let d = `M ${points[0].x} ${points[0].y}`;
  for (let i = 1; i < points.length; i++) {
    const prev = points[i - 1];
    const curr = points[i];
    const dir = curr.x - prev.x >= 0 ? 1 : -1;
    const cx = (prev.x + curr.x) / 2 + BEND * dir;
    const cy = (prev.y + curr.y) / 2;
    d += ` Q ${cx} ${cy} ${curr.x} ${curr.y}`;
  }
  return d;
}

function renderItem(item: MilestonesListItem) {
  // Dart: BadgeMilestone(content, variant: ghost)
  if (typeof item === 'string') return <BadgeMilestone content={item} variant="ghost" />;
  if (isValidElement(item)) return item; // already built element
  // MilestoneCard props object — the list's width wins over item.width (see MilestonesListItem)
  return <MilestoneCard {...(item as MilestoneCardProps)} width={CARD_WIDTH} />;
}

export function MilestonesList(props: MilestonesListProps) {
  const list = props.list ?? [];
  const seed = props.seed ?? 1;
  const ref = useRef<HTMLDivElement>(null);
  const [measured, setMeasured] = useState(props.width || 0);
  const width = props.width || measured || 375;

  useLayoutEffect(() => {
    if (props.width) return;
    const el = ref.current;
    if (!el) return;
    const measure = () => setMeasured(el.clientWidth);
    measure();
    // Re-layout when the container itself resizes (a window listener misses layout-driven changes)
    if (typeof ResizeObserver === 'undefined') return;
    const observer = new ResizeObserver(measure);
    observer.observe(el);
    return () => observer.disconnect();
  }, [props.width]);

  const lay = useMemo(() => layout(list, seed, width / 2), [list, seed, width]);

  return (
    <div ref={ref} className={`ds-milestones-list${props.className ? ` ${props.className}` : ''}`} style={{ height: `${lay.totalHeight}px` }}>
      <svg className="ds-milestones-list__line" width="100%" height={lay.totalHeight} viewBox={`0 0 ${width} ${lay.totalHeight}`} fill="none" aria-hidden>
        {/* Dotted: r1 circles every 8px (lineWidth 2, lineDotsSpacing 8, labelSecondary) */}
        <path d={pathD(lay.points)} stroke="var(--label-secondary)" strokeWidth={2} strokeDasharray="0.1 8" strokeLinecap="round" />
      </svg>
      {list.map((item, i) => (
        <span key={i} className="ds-milestones-list__item" style={{ left: `${lay.points[i].x}px`, top: `${lay.points[i].y}px` }}>
          {renderItem(item)}
        </span>
      ))}
    </div>
  );
}
