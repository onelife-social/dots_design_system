// `inert` across React majors. React 19 knows the attribute and wants the boolean; React 18 (a
// declared peer) treats it as an unknown attribute and drops a boolean `true`, but renders the
// empty string. Both majors render `inert=""` / `inert` correctly in the DOM. Internal helper.
import { version } from 'react';

const REACT_MAJOR = parseInt(version, 10) || 0;

/** Props to spread for an inert subtree; nothing when `on` is false (never renders inert="false"). */
export function inertProps(on: boolean): Record<string, unknown> {
  if (!on) return {};
  return REACT_MAJOR >= 19 ? { inert: true } : { inert: '' };
}
