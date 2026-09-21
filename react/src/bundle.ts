// Entry of the Claude Design bundle (built by scripts/build-bundle.mjs).
// Exposes the TSX (ported) components on the global namespace shared with the legacy
// components, which the build concatenates after this from ../tool/design_sync/_src.
import * as components from './index';

const NAMESPACE = 'DotsDesignSystem_9e41da';
const w = window as unknown as Record<string, Record<string, unknown>>;
Object.assign((w[NAMESPACE] ||= {}), components);
