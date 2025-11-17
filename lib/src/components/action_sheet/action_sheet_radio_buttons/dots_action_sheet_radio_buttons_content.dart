import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetRadioButtonsContent extends StatefulWidget {
  final Widget? topWidget;
  final String title;
  final String subtitle;
  final List<RadioCardIcons> items;
  final String? buttonLabel;
  final Function()? onTapButton;
  final double maxSheetHeight;

  const DotsActionSheetRadioButtonsContent({
    super.key,
    this.topWidget,
    required this.title,
    required this.subtitle,
    required this.items,
    this.buttonLabel,
    this.onTapButton,
    required this.maxSheetHeight,
  });

  @override
  State<DotsActionSheetRadioButtonsContent> createState() => _DotsActionSheetRadioButtonsContentState();
}

class _DotsActionSheetRadioButtonsContentState extends State<DotsActionSheetRadioButtonsContent> {
  bool _showTopFade = false;
  bool _showBottomFade = false;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _evaluateFades());
  }

  @override
  void didUpdateWidget(covariant DotsActionSheetRadioButtonsContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _evaluateFades());
    }
  }

  void _onScroll() => _evaluateFades();

  void _evaluateFades() {
    if (!mounted) return;

    if (!_controller.hasClients) return;

    final max = _controller.position.maxScrollExtent;
    final offset = _controller.offset;
    final hasOverflow = max > 0.0;
    final showTop = hasOverflow && offset > 0.5;
    final showBottom = hasOverflow && offset < (max - 0.5);

    if (showTop != _showTopFade || showBottom != _showBottomFade) {
      setState(() {
        _showTopFade = showTop;
        _showBottomFade = showBottom;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final isSmall = context.isSmallScreen;
    final sheetFixedSmall = 480.0;

    return DotsMainContainer(
      backgroundColor: theme.colors.bgBaseContrast,
      radius: 32,
      height: isSmall ? sheetFixedSmall : null,
      forceHeight: isSmall,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              widget.topWidget,
              widget.title,
              widget.subtitle,
            ),
            const SizedBox(height: 16),
            Flexible(
              fit: FlexFit.loose,
              child: _ScrollableListWithFades(
                controller: _controller,
                items: widget.items,
                theme: theme,
                showTop: _showTopFade,
                showBottom: _showBottomFade,
                maxHeight: isSmall ? sheetFixedSmall - 160 : widget.maxSheetHeight - 160,
              ),
            ),
            if (widget.buttonLabel != null) ...[
              const SizedBox(height: 20),
              _Footer(widget.buttonLabel, widget.onTapButton),
            ],
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Widget? topWidget;
  final String title;
  final String subtitle;

  const _Header(
    this.topWidget,
    this.title,
    this.subtitle,
  );

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (topWidget != null) ...[
          topWidget!,
          const SizedBox(height: 16),
        ],
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              spacing: 4,
              children: [
                Text(
                  title,
                  style: theme.typo.secondary.title02H5,
                  textAlign: TextAlign.center,
                ),
                Text(
                  subtitle,
                  style: theme.typo.main.labelDefaultRegular,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final String? buttonLabel;
  final Function()? onTapButton;

  const _Footer(
    this.buttonLabel,
    this.onTapButton,
  );

  @override
  Widget build(BuildContext context) {
    if (buttonLabel == null) return const SizedBox.shrink();
    return DotsMainButton(
      content: buttonLabel!,
      variant: DotsMainButtonVariant.main,
      size: DotsMainButtonSize.mainAction,
      onTap: onTapButton,
    );
  }
}

class _ScrollableListWithFades extends StatelessWidget {
  final ScrollController controller;
  final List<RadioCardIcons> items;
  final DotsTheme theme;
  final bool showTop;
  final bool showBottom;
  final double maxHeight;

  const _ScrollableListWithFades({
    required this.controller,
    required this.items,
    required this.theme,
    required this.showTop,
    required this.showBottom,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Stack(
        children: [
          ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: items,
              ),
            ),
          ),
          if (showTop)
            Align(
              alignment: Alignment.topCenter,
              child: IgnorePointer(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.2, 1.0],
                      colors: [
                        theme.colors.bgBaseContrast,
                        theme.colors.bgBaseContrast.dotsWithOpacity(0.7),
                        theme.colors.bgBaseContrast.dotsWithOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (showBottom)
            Align(
              alignment: Alignment.bottomCenter,
              child: IgnorePointer(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0.0, 0.2, 1.0],
                      colors: [
                        theme.colors.bgBaseContrast,
                        theme.colors.bgBaseContrast.dotsWithOpacity(0.7),
                        theme.colors.bgBaseContrast.dotsWithOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

