import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class MilestoneCard extends StatelessWidget {
  /// The width of the card.
  final double width;

  /// The image provider for the background image
  final ImageProvider imageProvider;

  /// Callback when an error occurs while loading the image.
  final ImageErrorWidgetBuilder? errorBuilder;

  /// Title of the card.
  final String? title;

  /// The date of the milestone.
  final String? date;

  /// Callback when the image is tapped.
  final VoidCallback? onTap;

  /// Whether to show the badge on the card.
  final bool showBadge;

  /// Whether to show the edit button on the card.
  final bool showEdit;

  /// Callback when the edit button is tapped.
  final VoidCallback? onTapEdit;

  const MilestoneCard({
    super.key,
    required this.width,
    required this.imageProvider,
    this.errorBuilder,
    this.title,
    this.date,
    this.onTap,
    this.showBadge = false,
    this.showEdit = false,
    this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final imageWidget = ClipSmoothRect(
      radius: SmoothBorderRadius(cornerRadius: 32, cornerSmoothing: 0.5),
      child: Image(
        image: imageProvider,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: errorBuilder,
      ),
    );

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: AspectRatio(
          aspectRatio: 3 / 4,
          child: DotsDecoratedBox(
            styleType: theme.styles.floatingBtnShadow,
            child: DotsDecoratedBox(
              styleType: theme.styles.squircle32,
              child: Stack(
                children: [
                  title?.isNotEmpty == true
                      ? _CardWithBlur(
                          imageWidget: imageWidget,
                        )
                      : imageWidget,

                  Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: DotsBorderRadius.r32,
                        side: BorderSide(
                          color: theme.colors.labelAlwaysWhite,
                          width: 3,
                        ),
                      ),
                    ),
                    child: _buildContent(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    Widget content = const SizedBox();
    if (title?.isNotEmpty == true) {
      content = _CardTitle(title: title!, date: date);
    } else if (showBadge) {
      content = const _CardBadge();
    } else if (showEdit) {
      content = _BtnEdit(onTap: onTapEdit);
    }

    return SizedBox.expand(child: content);
  }
}

class _CardWithBlur extends StatelessWidget {
  final Widget imageWidget;

  const _CardWithBlur({required this.imageWidget});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight.isFinite ? constraints.maxHeight : 0;
        final stop = h > 0 ? (108.0 / h).clamp(0.0, 1.0) : 0.0;
        return DotsLinearGradientBlur(
          sigma: 15,
          linearGradientBlur: LinearGradientBlur(
            values: const [1, 0],
            stops: [0, stop],
            start: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          tintColor: Colors.black.dotsWithOpacity(0.35),
          child: imageWidget,
        );
      },
    );
  }
}

class _CardTitle extends StatelessWidget {
  final String title;
  final String? date;

  const _CardTitle({
    required this.title,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 36, right: 36),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.typo.main.bodyLargeMedium.copyWith(
              color: theme.colors.labelAlwaysWhite,
            ),
          ),
          if (date?.isNotEmpty == true)
            Text(
              date!,
              textAlign: TextAlign.center,
              style: theme.typo.main.bodyDefaultRegular.copyWith(
                color: theme.colors.labelAlwaysWhite,
              ),
            ),
        ],
      ),
    );
  }
}

class _CardBadge extends StatelessWidget {
  const _CardBadge();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, right: 5),
        child: SvgPicture(
          AssetBytesLoader(
            'packages/dots_design_system/assets/images/milestones/badge-milestone-1.svg.vec',
          ),
        ),
      ),
    );
  }
}

class _BtnEdit extends StatelessWidget {
  final VoidCallback? onTap;

  const _BtnEdit({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, right: 5),
        child: DotsIconButton(
          icon: DotsIconData.pencil,
          backgroundColor: context.dotsTheme.colors.bgBtnImage,
          onTap: onTap,
        ),
      ),
    );
  }
}
