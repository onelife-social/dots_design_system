// DotsMapPin — port of lib/src/components/map_pin/dots_map_pin.dart (Dart = source of truth).
// Figma Chronicle `MapPin` (11714:3302): a bgStrong drop with a friends008 → labelDestructive gradient circle and
// the pin glyph, over a ground shadow. The paths and filters keep the coordinates of Figma's export (52 × 60, with
// room for the shadows), moved into the 46 × 55 box that the component clips to.
import { useId, type CSSProperties } from 'react';

export interface DotsMapPinProps {
  /** Accessible name (e.g. the venue's name) — Dart `semanticsLabel`. Without it, or with an empty one, the marker is decorative */
  ariaLabel?: string;
  /** Extra CSS class */
  className?: string;
  /** Inline style (e.g. `transform: translateY(3.46px)` to put the tip on a bottom-centre anchor) */
  style?: CSSProperties;
}

/** Box of the marker — Dart `DotsMapPin.size` */
export const dotsMapPinSize = { width: 46, height: 55 } as const;

/** Where the marker points, from the top-left of its box: centred, 3.46 px above the bottom edge — Dart `DotsMapPin.anchor` */
export const dotsMapPinAnchor = { x: 23, y: 51.5421 } as const;

export function DotsMapPin(props: DotsMapPinProps) {
  // Ids of the filters and the gradient, unique per marker so several can share a map
  const id = `ds-map-pin${useId().replace(/[^\w-]/g, '')}`;
  const a11y = props.ariaLabel ? { role: 'img', 'aria-label': props.ariaLabel } : { 'aria-hidden': true };

  return (
    <svg
      className={`ds-map-pin${props.className ? ` ${props.className}` : ''}`}
      width={dotsMapPinSize.width}
      height={dotsMapPinSize.height}
      viewBox="0 0 46 55"
      fill="none"
      style={props.style}
      {...a11y}
    >
      <g transform="translate(-3 -2.45789)">
        <g filter={`url(#${id}-ground)`}>
          <ellipse className="ds-map-pin__ground" cx="26" cy="53.9945" rx="8.11157" ry="1.42621" />
        </g>
        <g filter={`url(#${id}-drop)`}>
          <path
            className="ds-map-pin__surface"
            fillRule="evenodd"
            clipRule="evenodd"
            d="M26 4C37.598 4 47 13.402 47 25C47 32.4447 43.1261 38.9846 37.284 42.7139C35.0454 44.1429 32.8337 45.6948 31.2655 47.8383L27.1961 53.4007C27.0612 53.5858 26.8821 53.7369 26.6739 53.8412C26.4657 53.9455 26.2346 54 26 54C25.7654 54 25.5343 53.9455 25.3261 53.8412C25.1179 53.7369 24.9388 53.5858 24.8039 53.4007L20.7345 47.8383C19.1663 45.6948 16.9546 44.1429 14.7159 42.7139C8.87394 38.9846 5 32.4447 5 25C5 13.402 14.402 4 26 4Z"
          />
        </g>
        <path
          fill={`url(#${id}-circle)`}
          d="M44.4448 25C44.4448 14.8133 36.1869 6.55542 26.0002 6.55542C15.8136 6.55542 7.55566 14.8133 7.55566 25C7.55566 35.1867 15.8136 43.4446 26.0002 43.4446C36.1869 43.4446 44.4448 35.1867 44.4448 25Z"
        />
        <path
          className="ds-map-pin__surface"
          d="M29.8849 19.4339C29.8849 21.251 28.6417 22.7842 26.9497 23.2103V29.752C26.9497 32.8183 26.414 34.4653 25.9988 34.4653C25.575 34.4653 25.0392 32.8051 25.0392 29.752V23.2103C23.345 22.7732 22.115 21.251 22.115 19.4339C22.115 17.2852 23.8392 15.5347 25.9988 15.5347C28.1607 15.5347 29.8849 17.2852 29.8849 19.4339ZM23.5573 18.3053C23.5573 19.0267 24.1775 19.6446 24.8857 19.6446C25.6158 19.6446 26.214 19.0267 26.214 18.3053C26.214 17.5862 25.6158 16.977 24.8857 16.977C24.1775 16.977 23.5573 17.5862 23.5573 18.3053Z"
        />
      </g>
      <defs>
        {/* Ground shadow: layer blur 3 */}
        <filter id={`${id}-ground`} x="14.8884" y="49.5683" width="22.2231" height="8.85242" filterUnits="userSpaceOnUse" colorInterpolationFilters="sRGB">
          <feFlood floodOpacity="0" result="BackgroundImageFix" />
          <feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape" />
          <feGaussianBlur stdDeviation="1.5" />
        </filter>
        {/* Drop shadow of the drop: y 1, blur 5, black 10% */}
        <filter id={`${id}-drop`} x="0" y="0" width="52" height="60" filterUnits="userSpaceOnUse" colorInterpolationFilters="sRGB">
          <feFlood floodOpacity="0" result="BackgroundImageFix" />
          <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha" />
          <feOffset dy="1" />
          <feGaussianBlur stdDeviation="2.5" />
          <feComposite in2="hardAlpha" operator="out" />
          <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0" />
          <feBlend mode="normal" in2="BackgroundImageFix" result="dropShadow" />
          <feBlend mode="normal" in="SourceGraphic" in2="dropShadow" result="shape" />
        </filter>
        <linearGradient id={`${id}-circle`} x1="26.0002" y1="6.55542" x2="26.0002" y2="43.4446" gradientUnits="userSpaceOnUse">
          <stop className="ds-map-pin__gradient-start" />
          <stop className="ds-map-pin__gradient-end" offset="1" />
        </linearGradient>
      </defs>
    </svg>
  );
}
DotsMapPin.size = dotsMapPinSize;
DotsMapPin.anchor = dotsMapPinAnchor;
