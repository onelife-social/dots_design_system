## X.X.X Pending
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
