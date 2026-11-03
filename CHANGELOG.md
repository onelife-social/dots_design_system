## X.X.X Pending
* DotsTopBar showGradient (Figma TopBar Background=False · showGradient): with hideBackground, a bgBase → transparent gradient behind the bar, 18 px taller and visual only (web: showGradient).
* DotsAlert card on bgContainerPrimary, as in Figma (was bgContainerSecondary): lighter in light theme, darker in dark.
* Web: DotsAlert with showScrim declares aria-modal, and DotsActionSheet is a modal dialog named by its title.
* Web: FeatureItem iconColor (as in Dart), and the DotsIcon catalog catches up with the Dart enum: ic-envelope, ic-cake, ic-calendar--clock, ic-fireworks, ic-play-paper-plane, ic-sport-football, ic-work, ic-order and ic-qr-scan-v2 (`npm run gen:icons`).
* Web: DotsIconButton ariaLabel and DotsTopBar backAriaLabel, the accessible names of icon buttons (no default: the app translates them).
* DotsTextField: semanticsLabel, autocorrect, enableSuggestions, autofillHints and textInputAction (web: ariaLabel, autoCorrect, spellCheck, autoComplete, enterKeyHint); a translatable clearSemanticsLabel (web: clearAriaLabel, no English fallback); the clear button takes taps over 44 × 44 around its 16 px circle; with alignCenter the text no longer moves when it appears.
* DotsIconButtonVariant floating, so a Claude Design canvas can pick the floating look (`variant="floating"`); the web variant prop is no longer deprecated.
* DotsColors borderSurface (Figma Styles/Floating/borderSurface), token only: paint it with overlay blend on its own layer.
* DotsTextField container (defaultContainer 44 / big 52) and textSize (bodyDefault / bodyLarge / titleH6 / titleH5), as Figma's textField.
* DotsListsItem labelStyle variant (regular / bold) for rows whose label is what the user scans for.
* Replace soft_edge_blur with DotsBottomEdgeBlur (BackdropFilter-based) in ProductCard, AlbumGroupCard and EventGroupCard to fix Impeller Android misrendering.
* Product card component.
* Container component.
* Icon component.
* Icon button component.
* Top bar component.
* Menu component.

## 1.0.0
* Theme colors and typography.
* Button component.
