import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get alertStories => [
      Story(
        name: 'Alerts/Alert',
        description: 'Demo page for Alert',
        builder: (context) {
          String textfieldContent = '';

          final selectorItemList = List.generate(
            3,
            (i) => DotsListItemModel(
              label: 'Section name ${i + 1}',
              image: NetworkImage('https://picsum.photos/250?image=9'),
              variant: DotsListsItemVariant.selector,
            ),
          );

          return StatefulBuilder(
            builder: (context, setState) {
              final variant = context.knobs.options<DotsAlertVariant>(
                label: 'Variant',
                initial: DotsAlertVariant.noButtons,
                options:
                    DotsAlertVariant.values.map((v) => Option(label: v.name, value: v)).toList(),
              );

              final iconData = context.knobs.options<DotsIconData>(
                label: 'Icon',
                initial: DotsIconData.ai,
                options: DotsIconData.values
                    .map((item) => Option(label: item.name, value: item))
                    .toList(),
              );

              final title = context.knobs.text(
                label: 'Title',
                initial: 'Título',
              );
              final message = context.knobs.text(
                label: 'Message',
                initial:
                    'Descripción debe ser relevante y tener relación con el flujo que interrumpe.',
              );

              final mainButtonText = context.knobs.text(
                label: 'Main Button Text',
                initial: 'Acción',
              );
              final secondaryButtonText = context.knobs.text(
                label: 'Secondary Button Text',
                initial: 'Cancelar',
              );

              final inputHint = context.knobs.text(
                label: 'Input Hint',
                initial: 'Input content',
              );
              final showCloseButton = context.knobs.boolean(
                label: 'Show close button',
                initial: true,
              );
              final iconImage = NetworkImage(context.knobs
                  .text(label: 'Icon Image URL', initial: ''));

              switch (variant) {
                case DotsAlertVariant.oneButton:
                  return DotsAlert.oneButton(
                    iconData: iconData,
                    title: title,
                    message: message,
                    mainButtonText: mainButtonText,
                    mainButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Main button tapped!')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                    iconImage: iconImage,
                  );

                case DotsAlertVariant.twoHorizontalButtons:
                  return DotsAlert.twoHorizontalButtons(
                    iconData: iconData,
                    title: title,
                    message: message,
                    mainButtonText: mainButtonText,
                    mainButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Main button tapped!')),
                      );
                    },
                    secondaryButtonText: secondaryButtonText,
                    secondaryButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Secondary button tapped!')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                    iconImage: iconImage,
                  );
                case DotsAlertVariant.twoHorizontalButtonsDestructive:
                  return DotsAlert.twoHorizontalButtonsDestructive(
                    iconData: iconData,
                    title: title,
                    message: message,
                    mainButtonText: mainButtonText,
                    mainButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Main button tapped!')),
                      );
                    },
                    secondaryButtonText: secondaryButtonText,
                    secondaryButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Secondary button tapped!')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                    iconImage: iconImage,
                  );

                case DotsAlertVariant.twoVerticalButtons:
                  return DotsAlert.twoVerticalButtons(
                    iconData: iconData,
                    title: title,
                    message: message,
                    mainButtonText: mainButtonText,
                    mainButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Main button tapped!')),
                      );
                    },
                    secondaryButtonText: secondaryButtonText,
                    secondaryButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Secondary button tapped!')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                  );

                case DotsAlertVariant.input:
                  return DotsAlert.input(
                    iconData: iconData,
                    title: title,
                    onInputChanged: (value) => setState(() => textfieldContent = value),
                    inputHint: inputHint,
                    mainButtonText: mainButtonText,
                    mainButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Main button tapped! - Text: $textfieldContent')),
                      );
                    },
                    secondaryButtonText: secondaryButtonText,
                    secondaryButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Secondary button tapped!')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                    iconImage: iconImage,
                  );

                case DotsAlertVariant.selector:
                  return DotsAlert.selector(
                    iconData: iconData,
                    title: title,
                    message: message,
                    selectorItemList: [
                      for (int i = 0; i < selectorItemList.length; i++)
                        DotsListItemModel(
                          label: selectorItemList[i].label,
                          image: selectorItemList[i].image,
                          variant: selectorItemList[i].variant,
                          onTap: () {
                            setState(() {
                              selectorItemList[i] = DotsListItemModel(
                                label: selectorItemList[i].label,
                                image: selectorItemList[i].image,
                                variant:
                                    selectorItemList[i].variant == DotsListsItemVariant.radioButton
                                        ? DotsListsItemVariant.selector
                                        : DotsListsItemVariant.radioButton,
                              );
                            });
                          },
                        ),
                    ],
                    mainButtonText: mainButtonText,
                    mainButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Main button tapped! - Selected: ${selectorItemList.where((item) => item.variant == DotsListsItemVariant.radioButton).map((item) => item.label).join(', ')}',
                          ),
                        ),
                      );
                    },
                    secondaryButtonText: secondaryButtonText,
                    secondaryButtonOnTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Secondary button tapped!')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                    iconImage: iconImage,
                  );

                case DotsAlertVariant.noButtons:
                  return DotsAlert.noButtons(
                    iconData: iconData,
                    title: title,
                    message: message,
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Close button tapped!')),
                      );
                    },
                    showCloseButton: showCloseButton,
                    iconImage: iconImage,
                  );
              }
            },
          );
        },
      ),
    ];
