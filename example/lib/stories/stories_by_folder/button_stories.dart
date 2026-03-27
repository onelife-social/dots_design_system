import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/components/btn_folder_demo_page.dart';
import 'package:example/components/dots_icon_button_right_demo_page.dart';
import 'package:example/stories/helpers/color_knob_options.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get buttonStories => [
      Story(
        name: 'Buttons/Main button',
        description: 'Demo page for button',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsMainButton(
            content: context.knobs.text(label: 'Content', initial: 'Button text'),
            details: context.knobs.nullable.text(label: 'Details', initial: 'Details'),
            enabled: context.knobs.boolean(label: 'Enabled', initial: true),
            icon: context.knobs.nullable.options<DotsIconData>(
                label: 'Icon',
                initial: DotsIconData.trash,
                options: DotsIconData.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList()),
            size: context.knobs.options<DotsMainButtonSize>(
                label: 'Size',
                initial: DotsMainButtonSize.large,
                options: DotsMainButtonSize.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList()),
            variant: context.knobs.options<DotsMainButtonVariant>(
                label: 'Variant',
                initial: DotsMainButtonVariant.main,
                options: DotsMainButtonVariant.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList()),
            backgroundColor: knobColorSelector(context, 'Background color'),
            onTap: () {},
            expand: context.knobs.boolean(label: 'Expand', initial: true),
            iconPosition: context.knobs.options<DotsMainButtonIconPosition>(
              label: 'Icon position',
              initial: DotsMainButtonIconPosition.left,
              options: DotsMainButtonIconPosition.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList(),
            ),
            isLoading: context.knobs.boolean(label: 'Loading', initial: false),
            adaptPaddingForText:
                context.knobs.boolean(label: 'Adapt padding for text', initial: false),
          ),
        ),
      ),
      Story(
        name: 'Buttons/System button',
        description: 'Demo page for system button',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotsSystemButton(
            content: context.knobs.text(label: 'Content', initial: 'System button'),
            icon: context.knobs.nullable.options<DotsIconData>(
                label: 'Icon',
                initial: DotsIconData.draw,
                options: DotsIconData.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList()),
            size: context.knobs.options<DotsSystemButtonSize>(
                label: 'Size',
                initial: DotsSystemButtonSize.medium,
                options: DotsSystemButtonSize.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList()),
            variant: context.knobs.options<DotsSystemButtonVariant>(
                label: 'Variant',
                initial: DotsSystemButtonVariant.active,
                options: DotsSystemButtonVariant.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList()),
            onTap: () {},
          ),
        ),
      ),
      Story(
        name: 'Buttons/Icon button',
        description: 'Demo page for icon button',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: DotsIconButton(
              icon: context.knobs.options<DotsIconData>(
                  label: 'Icon',
                  initial: DotsIconData.trash,
                  options: DotsIconData.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              label:
                  context.knobs.nullable.text(label: 'Label', initial: 'Details', enabled: false),
              size: context.knobs.options<DotsIconButtonSize>(
                  label: 'Size',
                  initial: DotsIconButtonSize.large,
                  options: DotsIconButtonSize.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              variant: context.knobs.options<DotsIconButtonVariant>(
                  label: 'Variant',
                  initial: DotsIconButtonVariant.solid,
                  options: DotsIconButtonVariant.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              style: context.knobs.options<DotsIconButtonStyle>(
                  label: 'Style',
                  initial: DotsIconButtonStyle.defaultStyle,
                  options: DotsIconButtonStyle.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              state: context.knobs.options<DotsIconButtonState>(
                  label: 'State',
                  initial: DotsIconButtonState.defaultState,
                  options: DotsIconButtonState.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              direction: context.knobs.options<DotsIconButtonDirection>(
                  label: 'Direction',
                  initial: DotsIconButtonDirection.column,
                  options: DotsIconButtonDirection.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              tag: context.knobs.nullable.text(label: 'Tag', initial: '5', enabled: false),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('On tap!')),
              ),
            ),
          ),
        ),
      ),
      Story(
        name: 'Buttons/Icon Button Right',
        description: 'Demo page for Icon Button Right',
        builder: (context) => DotsIconButtonRightDemoPage(
          variant: context.knobs.options<DotsIconButtonRightVariant>(
              label: 'Variant',
              initial: DotsIconButtonRightVariant.primaryActive,
              options: DotsIconButtonRightVariant.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList()),
          icon: context.knobs.options<DotsIconData>(
              label: 'Icon',
              initial: DotsIconData.trash,
              options: DotsIconData.values
                  .map((item) => Option(label: item.name, value: item))
                  .toList()),
          label: context.knobs.text(label: 'Label', initial: 'Details'),
        ),
      ),
      Story(
        name: 'Buttons/Floating button',
        description: 'Demo page for floating button',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: DotsFloatingButton(
              content: context.knobs.text(label: 'Content', initial: 'Buscar'),
              icon: context.knobs.nullable.options<DotsIconData>(
                  label: 'Icon',
                  initial: DotsIconData.search,
                  options: DotsIconData.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              blur: context.knobs.boolean(label: 'Blur', initial: true),
              onTap: () {},
            ),
          ),
        ),
      ),
      Story(
        name: 'Buttons/Close button',
        description: 'Demo page for close button',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: DotsCloseButton(
              icon: context.knobs.options<DotsIconData>(
                  label: 'Icon',
                  initial: DotsIconData.cross,
                  options: DotsIconData.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              size: context.knobs.options<DotsCloseButtonSize>(
                  label: 'Size',
                  initial: DotsCloseButtonSize.medium,
                  options: DotsCloseButtonSize.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              variant: context.knobs.options<DotsCloseButtonVariant>(
                  label: 'Variant',
                  initial: DotsCloseButtonVariant.softContrast,
                  options: DotsCloseButtonVariant.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList()),
              onTap: () {},
            ),
          ),
        ),
      ),
      Story(
        name: 'Buttons/Capture button',
        description: 'Demo page for capture button (photo/video)',
        builder: (context) {
          final type = context.knobs.options<DotsCaptureButtonType>(
            label: 'Type',
            initial: DotsCaptureButtonType.photo,
            options: DotsCaptureButtonType.values
                .map((item) => Option(label: item.name, value: item))
                .toList(),
          );
          final maxTime = context.knobs.sliderInt(
            label: 'Max recording (s)',
            initial: 10,
            min: 5,
            max: 60,
          );
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: _CaptureButtonStory(
                type: type,
                maxTimeRecording: maxTime,
              ),
            ),
          );
        },
      ),
      Story(
        name: 'Buttons/Btn Folder',
        description: 'Demo page for Btn Folder',
        builder: (context) => BtnFolderDemoPage(
          text: context.knobs.text(label: 'Weddings', initial: 'Weddings'),
          iconColor: knobColorSelector(context, 'Selected color'),
          icon: DotsIcon(
            iconData: context.knobs.options<DotsIconData>(
              label: 'Icon',
              initial: DotsIconData.search,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
          ),
          isEditable: context.knobs.boolean(label: 'Editable', initial: false),
          showEditIcon: context.knobs.boolean(label: 'ShowEditIcon', initial: false),
        ),
      ),
      Story(
        name: 'Buttons/Radio button',
        description: 'Demo page for Radio Button',
        builder: (context) {
          bool isSelected = false;
          return StatefulBuilder(
            builder: (context, setState) {
              return InkWell(
                onTap: () {
                  setState(() => isSelected = !isSelected);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Toggle value changed to: $isSelected')),
                  );
                },
                child: DotsRadioButton(isSelected: isSelected),
              );
            },
          );
        },
      ),
      Story(
        name: 'Buttons/Toggle',
        description: 'Demo page for Toggle',
        builder: (context) {
          bool isSelected = false;
          return StatefulBuilder(
            builder: (context, setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DotsToggle(
                    isSelected: isSelected,
                    onChanged: (_) {
                      setState(() => isSelected = !isSelected);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Toggle value changed to: $isSelected')),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      Story(
        name: 'Buttons/Selector',
        description: 'Demo page for Selector',
        builder: (context) {
          bool isSelectedCheck = false, isSelectedNum = false;
          int timesTapped = 0;

          return StatefulBuilder(
            builder: (context, setState) {
              return DotsMainContainer(
                height: 100,
                width: 175,
                backgroundColor: context.dotsTheme.colors.bgContainerTertiary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() => isSelectedCheck = !isSelectedCheck);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Selector check variant value changed to: $isSelectedCheck',
                            ),
                          ),
                        );
                      },
                      child: DotsSelector.check(isSelected: isSelectedCheck),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!isSelectedNum) timesTapped++;
                          isSelectedNum = !isSelectedNum;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Selector number variant value changed to: $isSelectedNum',
                            ),
                          ),
                        );
                      },
                      child: DotsSelector.num(isSelected: isSelectedNum, number: timesTapped),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      Story(
        name: 'Buttons/Social Media Button',
        description: 'Demo page for Social Media Button',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: DotsSocialMediaButton(
              variant: context.knobs.options<DotsSocialMediaVariant>(
                label: 'Variant',
                initial: DotsSocialMediaVariant.instagram,
                options: DotsSocialMediaVariant.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              ),
              label: context.knobs.nullable.text(label: 'Label', initial: 'Share', enabled: false),
              size: context.knobs.options<DotsIconButtonSize>(
                label: 'Size',
                initial: DotsIconButtonSize.large,
                options: DotsIconButtonSize.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              ),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('On tap!')),
              ),
            ),
          ),
        ),
      ),
      Story(
        name: 'Buttons/Rich button',
        description: 'Demo page for Rich button',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: DotsRichButton(
              size: context.knobs.options<DotsRichButtonSize>(
                label: 'Size',
                initial: DotsRichButtonSize.large,
                options: DotsRichButtonSize.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              ),
              textSize: context.knobs.options<DotsRichButtonTextSize>(
                label: 'Text Size',
                initial: DotsRichButtonTextSize.large,
                options: DotsRichButtonTextSize.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              ),
              image: context.knobs.boolean(label: 'Show leading image?', initial: true)
                  ? NetworkImage('https://picsum.photos/250?image=9')
                  : null,
              icon: context.knobs.nullable.options<DotsIconData>(
                label: 'Icon',
                initial: DotsIconData.search,
                options: DotsIconData.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              ),
              iconColor: knobColorSelector(context, 'Icon color'),
              content: context.knobs.text(label: 'Content', initial: 'Button Content'),
              details: context.knobs.nullable.text(label: 'Details', initial: 'Details'),
              trailingText: context.knobs.nullable
                  .text(label: 'Trailing Text', initial: '0/4', enabled: false),
              onTap: () =>
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('On tap!'))),
            ),
          ),
        ),
      ),
      Story(
        name: 'Buttons/Toggle Buttons',
        description: 'Demo page for toggle buttons',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: DotBookToggleButton(
                    title: context.knobs.text(label: 'Left title', initial: 'Standard'),
                    subtitle:
                        context.knobs.nullable.text(label: 'Left subtitle', initial: '20 x 30 cm'),
                    isSelected: context.knobs.boolean(
                      label: 'Left selected',
                      initial: true,
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Left tapped')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DotBookToggleButton(
                    title: context.knobs.text(label: 'Right title', initial: 'Large'),
                    subtitle:
                        context.knobs.nullable.text(label: 'Right subtitle', initial: '30 x 40 cm'),
                    isSelected: context.knobs.boolean(
                      label: 'Right selected',
                      initial: false,
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Right tapped')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Story(
        name: 'Buttons/Input Stepper',
        description: 'Demo page for Input Stepper',
        builder: (context) => Builder(
          builder: (context) {
            final minValue = context.knobs.sliderInt(
              label: 'Min value',
              initial: 0,
              min: 0,
              max: 10,
            );
            final maxValue = context.knobs.sliderInt(
              label: 'Max value',
              initial: 10,
              min: 1,
              max: 20,
            );
            final safeMaxValue = maxValue < minValue ? minValue : maxValue;
            final initialValue = context.knobs.sliderInt(
              label: 'Initial value',
              initial: 1,
              min: 0,
              max: 20,
            );
            int value = initialValue.clamp(minValue, safeMaxValue).toInt();

            return StatefulBuilder(
              builder: (context, setState) {
                return DotsInputStepper(
                  value: value,
                  minValue: minValue,
                  maxValue: safeMaxValue,
                  onDecrement: () {
                    if (value <= minValue) return;
                    setState(() => value--);
                  },
                  onIncrement: () {
                    if (value >= safeMaxValue) return;
                    setState(() => value++);
                  },
                );
              },
            );
          },
        ),
      ),
    ];

class _CaptureButtonStory extends StatefulWidget {
  const _CaptureButtonStory({
    required this.type,
    required this.maxTimeRecording,
  });

  final DotsCaptureButtonType type;
  final int maxTimeRecording;

  @override
  State<_CaptureButtonStory> createState() => _CaptureButtonStoryState();
}

class _CaptureButtonStoryState extends State<_CaptureButtonStory> {
  late DotsCaptureButtonState _state;

  @override
  void initState() {
    super.initState();
    _state = DotsCaptureButtonState.active;
  }

  @override
  void didUpdateWidget(covariant _CaptureButtonStory oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {
      _state = DotsCaptureButtonState.active;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DotsCaptureButton(
      type: widget.type,
      state: _state,
      maxTimeRecording: widget.maxTimeRecording,
      onTakePicture: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Photo taken')),
      ),
      onStartRecording: () {
        setState(() => _state = DotsCaptureButtonState.recording);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recording started')),
        );
      },
      onStopRecording: () {
        setState(() => _state = DotsCaptureButtonState.active);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recording stopped')),
        );
      },
    );
  }
}
