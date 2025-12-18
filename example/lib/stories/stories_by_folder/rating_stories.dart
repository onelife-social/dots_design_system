import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get ratingStories => [
      Story(
        name: 'Rating/stars',
        description: 'Demo page for Rating stars',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsRatingStar(
            text: context.knobs.text(label: 'Title', initial: 'Title'),
            variant: context.knobs.options<RatingIconVariant>(
              label: 'Variant',
              initial: RatingIconVariant.disabled,
              options: RatingIconVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
          ),
        ),
      ),
      Story(
        name: 'Rating/star row',
        description: 'Demo page for Rating star row',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: StatefulBuilder(
            builder: (context, setState) {
              return _RatingStarRowStory(
                leftText: context.knobs.text(label: 'Left Text', initial: 'Very Unsatisfied'),
                rightText: context.knobs.text(label: 'Right Text', initial: 'Very Satisfied'),
                isSmall: context.knobs.boolean(label: 'Compact Layout', initial: false),
              );
            },
          ),
        ),
      ),   
];

class _RatingStarRowStory extends StatefulWidget {
  final String leftText;
  final String rightText;
  final bool isSmall;

  const _RatingStarRowStory({
    required this.leftText,
    required this.rightText,
    required this.isSmall,
  });

  @override
  State<_RatingStarRowStory> createState() => _RatingStarRowStoryState();
}

class _RatingStarRowStoryState extends State<_RatingStarRowStory> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return DotsRatingStarRow(
      starLabels: List.generate(10, (i) => (i + 1).toString()),
      leftText: widget.leftText,
      rightText: widget.rightText,
      selectedIndex: selectedIndex,
      compact: widget.isSmall,
      onStarTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}