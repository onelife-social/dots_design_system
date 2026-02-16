import 'package:dots_design_system/src/core/core_lib.dart';
import 'package:flutter/material.dart';

enum DotBookTitlesEditorVariant {
	defaultVariant,
	printedSquare,
}

class DotBookTitlesEditor extends StatelessWidget {
	final double width;
	final double height;
	final DotBookTitlesEditorVariant variant;

  /// Title text to display.
	final String title;

  /// Date text to display.
	final String date;

  /// Extra information text to display (only for printedSquare variant).
	final String xtraInfo;

  /// Callback when the editor is tapped.
  final Function()? onTap;

	const DotBookTitlesEditor({
		super.key,
		required this.width,
		required this.height,
		this.variant = DotBookTitlesEditorVariant.defaultVariant,
    required this.title,
    required this.date,
    this.xtraInfo = '',
    this.onTap,
	});

	@override
	Widget build(BuildContext context) {

		return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedRRectPainter(
          color: context.dotsTheme.colors.labelSecondary,
          radius: 16,
          strokeWidth: 2,
          dashLength: 10,
          dashGap: 2,
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: variant == DotBookTitlesEditorVariant.printedSquare
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              date,
                              style: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              xtraInfo,
                              style: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          date,
                          style: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
	}
}

class _DashedRRectPainter extends CustomPainter {
	final Color color;
	final double radius;
	final double strokeWidth;
	final double dashLength;
	final double dashGap;

	const _DashedRRectPainter({
		required this.color,
		required this.radius,
		required this.strokeWidth,
		required this.dashLength,
		required this.dashGap,
	});

	@override
	void paint(Canvas canvas, Size size) {
		final RRect rRect = RRect.fromRectAndRadius(
			Offset.zero & size,
			Radius.circular(radius),
		);
		final Path path = Path()..addRRect(rRect);

		final Paint paint = Paint()
			..color = color
			..style = PaintingStyle.stroke
			..strokeWidth = strokeWidth;

		for (final metric in path.computeMetrics()) {
			double distance = 0;
			while (distance < metric.length) {
				final double next = distance + dashLength;
				canvas.drawPath(
					metric.extractPath(distance, next.clamp(0, metric.length)),
					paint,
				);
				distance += dashLength + dashGap;
			}
		}
	}

	@override
	bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) {
		return color != oldDelegate.color ||
				radius != oldDelegate.radius ||
				strokeWidth != oldDelegate.strokeWidth ||
				dashLength != oldDelegate.dashLength ||
				dashGap != oldDelegate.dashGap;
	}
}
