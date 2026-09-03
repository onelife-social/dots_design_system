import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// Provisioning state of the game a [DotsGameCard] represents.
enum DotsGameCardStatus {
  /// Access is still being prepared: the action reads as progress, not a tap.
  processing,

  /// Provisioning failed for good; the action leads to support.
  error,

  /// The panel is ready.
  active;

  bool get isProcessing => this == DotsGameCardStatus.processing;
}

/// Card for a purchased game, one per access (Figma 11574:5112).
///
/// Matches [AlbumGroupCard] large in width and corner so both read as the same
/// family down a home feed; the height follows the content, since the title and
/// the description wrap differently per locale.
class DotsGameCard extends StatelessWidget {
  const DotsGameCard({
    super.key,
    required this.status,
    required this.image,
    required this.badgeText,
    required this.title,
    required this.description,
    required this.actionText,
    this.onActionTap,
    this.progressIndicator,
  });

  /// Which of the three variants to render.
  final DotsGameCardStatus status;

  /// Game artwork, drawn inside a [_imageWidth] x [_imageHeight] box.
  final Widget image;

  /// Badge copy — `PREPARANDO`, `NO DISPONIBLE`, `ACTIVO`.
  final String badgeText;

  final String title;

  final String description;

  /// Button copy, or the progress label while [status] is
  /// [DotsGameCardStatus.processing].
  final String actionText;

  /// Ignored while [status] is [DotsGameCardStatus.processing]: that variant
  /// reports progress and takes no tap.
  final VoidCallback? onActionTap;

  /// Leading spinner for [DotsGameCardStatus.processing]. The package ships no
  /// indeterminate spinner — [SpinnerRound] is determinate — so the host passes
  /// its own.
  final Widget? progressIndicator;

  static const double _padding = 20;
  static const double _blockGap = 18;
  static const double _contentGap = 10;
  static const double _contentPadding = 16;
  static const double _imageWidth = 138;
  static const double _imageHeight = 100;
  static const double _actionHeight = 44;
  static const double _actionGap = 8;

  /// Figma's `defaultShadow` style, which is NOT `theme.styles.defaultShadow`:
  /// the token in code is 0x1A000000 blur 20 at (0, 6), the design ships
  /// 0x14000000 blur 10 at (0, 5). Following the design until they converge.
  static const BoxShadow _shadow = BoxShadow(
    color: Color(0x14000000),
    offset: Offset(0, 5),
    blurRadius: 10,
  );

  @override
  Widget build(BuildContext context) {
    final DotsTheme theme = context.dotsTheme;

    return Container(
      width: kAlbumLargeCardSize,
      // Not DotsDecoratedBox: its squircle branch clips the child, and the
      // child is what paints the shadow, so the shadow would be clipped away.
      decoration: ShapeDecoration(
        color: theme.colors.bgStrong,
        shape: dotsSquircleBorder(theme.styles.squircle52),
        shadows: const [_shadow],
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: _imageWidth, height: _imageHeight, child: image),
            const SizedBox(height: _blockGap),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _contentPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BadgeLabel(
                    content: badgeText,
                    size: BadgeLabelSize.medium,
                    variant: _badgeVariant,
                  ),
                  const SizedBox(height: _contentGap),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: theme.typo.secondary.title02H4.copyWith(
                      color: theme.colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: _contentGap),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: theme.typo.main.bodyDefaultRegular.copyWith(
                      color: theme.colors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: _blockGap),
            _action(theme),
          ],
        ),
      ),
    );
  }

  BadgeLabelVariant get _badgeVariant => switch (status) {
    DotsGameCardStatus.processing => BadgeLabelVariant.secondary,
    DotsGameCardStatus.error => BadgeLabelVariant.warningMaterial,
    DotsGameCardStatus.active => BadgeLabelVariant.greenMaterial,
  };

  Widget _action(DotsTheme theme) {
    if (!status.isProcessing) {
      return DotsMainButton(
        content: actionText,
        size: DotsMainButtonSize.large,
        expand: false,
        onTap: onActionTap,
      );
    }

    return SizedBox(
      height: _actionHeight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (progressIndicator != null) ...[
            progressIndicator!,
            const SizedBox(width: _actionGap),
          ],
          Text(
            actionText,
            style: theme.typo.main.bodyDefaultMedium.copyWith(
              color: theme.colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
