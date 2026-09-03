import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/widgets.dart';

import '../../theme/styles/types/dots_style_squircle.dart';

/// Squircle [ShapeBorder] for a `theme.styles.squircleNN` token.
///
/// Exported so hosts get Figma's corner smoothing without taking a direct
/// dependency on `figma_squircle`: the package is an implementation detail of
/// this design system.
///
/// Pass [side] to stroke the shape. Paint that border through
/// `foregroundDecoration` rather than `decoration` whenever the box holds
/// artwork — a background border is painted before the children and the
/// artwork covers it.
ShapeBorder dotsSquircleBorder(
  DotsStyleSquircle squircle, {
  BorderSide side = BorderSide.none,
}) {
  return SmoothRectangleBorder(
    side: side,
    borderRadius: SmoothBorderRadius(
      cornerRadius: squircle.radius,
      cornerSmoothing: squircle.cornerSmoothing,
    ),
  );
}
