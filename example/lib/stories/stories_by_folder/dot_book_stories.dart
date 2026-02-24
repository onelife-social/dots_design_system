import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum DotBookStoryTextColorOption { white, bone, sand, olive, ice, rose, natural, graphite, black }

Color _dotBookStoryTextColor(
  BuildContext context,
  DotBookCoverType variant,
  DotBookStoryTextColorOption option,
) {
  final theme = context.dotsTheme;

  if (variant == DotBookCoverType.linen) {
    return theme.colors.labelAlwaysWhite;
  }

  switch (option) {
    case DotBookStoryTextColorOption.white:
      return theme.colors.textDotbookWhite;
    case DotBookStoryTextColorOption.bone:
      return theme.colors.textDotbookBone;
    case DotBookStoryTextColorOption.sand:
      return theme.colors.textDotbookSand;
    case DotBookStoryTextColorOption.ice:
      return theme.colors.textDotbookIce;
    case DotBookStoryTextColorOption.olive:
      return theme.colors.textDotbookOlive;
    case DotBookStoryTextColorOption.rose:
      return theme.colors.textDotbookRose;
    case DotBookStoryTextColorOption.natural:
      return theme.colors.labelAlwaysWhite;
    case DotBookStoryTextColorOption.graphite:
      return theme.colors.labelAlwaysWhite;
    case DotBookStoryTextColorOption.black:
      return theme.colors.labelAlwaysWhite;
  }
}

String _max30(String value) {
  if (value.length <= 30) {
    return value;
  }

  return value.substring(0, 30);
}

String? _max30Nullable(String? value) {
  if (value == null) {
    return null;
  }

  return _max30(value);
}

List<Story> get dotBookStories => [
      Story(
        name: 'DotBook Components/page control',
        description: 'Demo page for Page control',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PageControl(
              count: context.knobs.sliderInt(
                label: 'Dot count',
                initial: 5,
                max: 10,
                min: 0,
              ),
              activeIndex: context.knobs.sliderInt(
                label: 'Active dot index',
                initial: 0,
                max: 9,
                min: 0,
              ),
            ),
          ),
        ),
      ),
      Story(
        name: 'DotBook Components/image placeholder',
        description: 'Demo page for Image placeholder',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DotBookImagePlaceholder(
              media: const Image(
                image: NetworkImage('https://picsum.photos/250?image=3'),
                fit: BoxFit.cover,
              ),
              badgeText: context.knobs.text(label: 'Badge text', initial: '19 x 25 cm'),
              badgeIcon: context.knobs.options<DotsIconData?>(
                label: 'Badge Icon',
                initial: null,
                options: [
                  const Option(label: 'None', value: null),
                  ...DotsIconData.values
                      .map((item) => Option(label: item.name, value: item))
                      .toList(),
                ],
              ),
              onBackPressed: context.knobs.boolean(
                label: 'Show back button',
                initial: true,
              )
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('On tap!')),
                      );
                    }
                  : null,
            ),
          ),
        ),
      ),
      Story(
        name: 'DotBook Components/book feature text item',
        description: 'Demo page for book feature text item',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BookFeatureTextItem(
              icon: DotsIconData.star,
              title: context.knobs.text(label: 'Title', initial: 'High quality paper'),
              description: context.knobs.text(
                label: 'Description',
                initial:
                    'Our books are made with high quality paper that ensures durability and a pleasant reading experience.',
              ),
            ),
          ),
        ),
      ),
      Story(
        name: 'DotBook Components/toggle buttons',
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
        name: 'DotBook Components/Feature card',
        description: 'Demo page for book feature text item',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotBookFeatureCard(
            imageCard: NetworkImage('https://picsum.photos/250?image=3'),
            title: context.knobs.text(label: 'Title', initial: 'High quality paper'),
            description: context.knobs.text(
              label: 'Description',
              initial:
                  'Our books are made with high quality paper that ensures durability and a pleasant reading experience.',
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Card tapped')),
              );
            },
          ),
        ),
      ),
      Story(
        name: 'DotBook Components/Testimonial card',
        description: 'Demo page for book feature text item',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotBookTestimonialCard(
            imageCard: NetworkImage(context.knobs
                .text(label: 'Testimonial image', initial: 'https://picsum.photos/250?image=9')),
            imageProfile: NetworkImage(context.knobs
                .text(label: 'Profile image', initial: 'https://picsum.photos/250?image=10')),
            title: context.knobs.text(label: 'Title', initial: 'John Doe'),
            description: context.knobs.text(
              label: 'Description',
              initial:
                  'I absolutely love this book! The quality is amazing and it has become my go-to for all my reading needs.',
            ),
            username: context.knobs.text(label: 'Username', initial: '@johndoe'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Card tapped')),
              );
            },
          ),
        ),
      ),
      Story(
        name: 'DotBook Components/Delivery card',
        description: 'Demo page for book delivery card',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: DotBookDeliveryCard(
            image: NetworkImage(context.knobs
                .text(label: 'Delivery image', initial: 'https://picsum.photos/250?image=11')),
            imageWidth: context.knobs.slider(label: 'Image width', initial: 53, min: 20, max: 200),
            title: context.knobs.text(label: 'Title', initial: 'Delivery Information'),
            standarText: context.knobs.text(
              label: 'Standard delivery text',
              initial: 'Standard Delivery',
            ),
            standarDate: context.knobs.text(
              label: 'Standard delivery date',
              initial: 'Estimated delivery: 5-7 business days',
            ),
            expressText: context.knobs.text(
              label: 'Express delivery text',
              initial: 'Express Delivery',
            ),
            expressDate: context.knobs.text(
              label: 'Express delivery date',
              initial: 'Estimated delivery: 1-2 business days',
            ),
          ),
        ),
      ),
      Story(
        name: 'DotBook Components/DotBook cover',
        description: 'Demo page for DotBook cover',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Builder(builder: (context) {
              final variant = context.knobs.options(
                label: 'Cover variant',
                initial: DotBookCoverType.linen,
                options: const [
                  Option(label: 'Linen', value: DotBookCoverType.linen),
                  Option(label: 'Printed Square', value: DotBookCoverType.printedSquare),
                  Option(label: 'Printed Circle', value: DotBookCoverType.printedCircle),
                ],
              );
              final colorOption = context.knobs.options(
                label: 'Text color preset',
                initial: DotBookStoryTextColorOption.white,
                options: const [
                  Option(label: 'White', value: DotBookStoryTextColorOption.white),
                  Option(label: 'Bone', value: DotBookStoryTextColorOption.bone),
                  Option(label: 'Sand', value: DotBookStoryTextColorOption.sand),
                  Option(label: 'Ice', value: DotBookStoryTextColorOption.ice),
                  Option(label: 'Olive', value: DotBookStoryTextColorOption.olive),
                  Option(label: 'Rose', value: DotBookStoryTextColorOption.rose),
                  Option(label: 'Natural', value: DotBookStoryTextColorOption.natural),
                  Option(label: 'Graphite', value: DotBookStoryTextColorOption.graphite),
                  Option(label: 'Black', value: DotBookStoryTextColorOption.black),
                ],
              );

              return DotBookCover(
                variant: variant,
                containerWidth: MediaQuery.sizeOf(context).width,
                mainImage: context.knobs.options<ImageProvider>(
                  label: 'Main image asset',
                  initial: AssetImage(ImagesPaths.dotbookCoverLinenWhite),
                  options: [
                    Option(
                      label: 'Linen Natural',
                      value: AssetImage(ImagesPaths.dotbookCoverLinenWhite),
                    ),
                    Option(
                      label: 'Linen Graphite',
                      value: AssetImage(ImagesPaths.dotbookCoverLinenStone),
                    ),
                    Option(
                      label: 'Linen Black',
                      value: AssetImage(ImagesPaths.dotbookCoverLinenCharcoal),
                    ),
                    Option(
                      label: 'Printed White',
                      value: AssetImage(ImagesPaths.dotbookCoverPrintedWhite),
                    ),
                    Option(
                      label: 'Printed Ice',
                      value: AssetImage(ImagesPaths.dotbookCoverPrintedCloud),
                    ),
                    Option(
                      label: 'Printed Olive',
                      value: AssetImage(ImagesPaths.dotbookCoverPrintedOlive),
                    ),
                    Option(
                      label: 'Printed Rose',
                      value: AssetImage(ImagesPaths.dotbookCoverPrintedPeach),
                    ),
                    Option(
                      label: 'Printed Bone',
                      value: AssetImage(ImagesPaths.dotbookCoverPrintedSand),
                    ),
                    Option(
                      label: 'Printed Sand',
                      value: AssetImage(ImagesPaths.dotbookCoverPrintedBeigeCraft),
                    ),
                  ],
                ),
                textColor: _dotBookStoryTextColor(context, variant, colorOption),
                dotsTitle: context.knobs.text(label: 'Bottom text', initial: 'DotBook'),
                editorTitle: _max30(
                  context.knobs.text(
                    label: 'Editor title',
                    initial: 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                  ),
                ),
                editorSubtitle: _max30Nullable(
                  context.knobs.nullable.text(
                    label: 'Editor subtitle',
                    initial: 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                  ),
                ),
                isEditingMode: context.knobs.boolean(
                  label: 'Is editing mode',
                  initial: false,
                ),
                isCreateMode: context.knobs.boolean(
                  label: 'Is create mode',
                  initial: false,
                ),
                createprogress: context.knobs
                    .sliderInt(
                      label: 'Create progress',
                      initial: 50,
                      min: 0,
                      max: 100,
                    )
                    .toString(),
                onOverlayTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Overlay tapped')),
                  );
                },
                onEditingBorderTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Border tapped')),
                  );
                },
                overlayImage: context.knobs.boolean(
                  label: 'Use overlay image',
                  initial: true,
                )
                    ? NetworkImage(
                        context.knobs.text(
                          label: 'Overlay image',
                          initial: 'https://picsum.photos/600/900?image=22',
                        ),
                      )
                    : null,
              );
            }),
          ),
        ),
      ),
      Story(
        name: 'DotBook Components/DotBook text editor',
        description: 'Demo page for DotBook text editor',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Builder(builder: (context) {
              final coverVariant = context.knobs.options(
                label: 'Cover variant',
                initial: DotBookCoverType.linen,
                options: const [
                  Option(label: 'Linen', value: DotBookCoverType.linen),
                  Option(label: 'Printed Square', value: DotBookCoverType.printedSquare),
                  Option(label: 'Printed Circle', value: DotBookCoverType.printedCircle),
                ],
              );
              final colorOption = context.knobs.options(
                label: 'Editor text color preset',
                initial: DotBookStoryTextColorOption.white,
                options: const [
                  Option(label: 'White', value: DotBookStoryTextColorOption.white),
                  Option(label: 'Bone', value: DotBookStoryTextColorOption.bone),
                  Option(label: 'Sand', value: DotBookStoryTextColorOption.sand),
                  Option(label: 'Ice', value: DotBookStoryTextColorOption.ice),
                  Option(label: 'Olive', value: DotBookStoryTextColorOption.olive),
                  Option(label: 'Rose', value: DotBookStoryTextColorOption.rose),
                  Option(label: 'Natural', value: DotBookStoryTextColorOption.natural),
                  Option(label: 'Graphite', value: DotBookStoryTextColorOption.graphite),
                  Option(label: 'Black', value: DotBookStoryTextColorOption.black),
                ],
              );

              return DotBookTextEditor(
                width: 300,
                height: 150,
                title: context.knobs.text(label: 'Text', initial: 'My DotBook'),
                subtitle: context.knobs.nullable.text(label: 'Subtitle', initial: 'A great book'),
                xtraInfo: context.knobs.nullable.text(label: 'Extra info', initial: '20 x 30 cm'),
                variant: context.knobs.options(
                  label: 'Text editor variant',
                  initial: DotBookCoverType.printedSquare,
                  options: const [
                    Option(label: 'Printed Square', value: DotBookCoverType.printedSquare),
                    Option(label: 'Printed Circle', value: DotBookCoverType.printedCircle),
                    Option(label: 'Linen', value: DotBookCoverType.linen),
                  ],
                ),
                coverVariant: coverVariant,
                textColor: _dotBookStoryTextColor(context, coverVariant, colorOption),
                coverImageWidth: 323,
                coverImageHeight: 415,
              );
            }),
          ),
        ),
      ),
      Story(
        name: 'DotBook Components/DotBook Price Summary',
        description: 'Demo page for DotBook Price Summary',
        builder: (context) => Builder(
          builder: (context) {
            int quantity = 1;
            final minQuantity = 1;
            final maxQuantity = 5;

            return StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: DotbookPriceSummary(
                    imageProvider: NetworkImage('https://picsum.photos/250?image=9'),
                    title: 'Tu Dotbook',
                    quantityLabel: 'Cantidad',
                    quantity: quantity,
                    minQuantity: minQuantity,
                    maxQuantity: maxQuantity,
                    onDecrement: () {
                      if (quantity <= minQuantity) return;
                      setState(() => quantity--);
                    },
                    onIncrement: context.knobs.boolean(
                      label: 'Add input?',
                      initial: true,
                    )
                        ? () {
                            if (quantity >= maxQuantity) return;
                            setState(() => quantity++);
                          }
                        : null,
                    products: {
                      'Dotbook Printed Cover': '29,95€',
                      '100 páginas extra (x0,90€)': '90,00€',
                      'Impuestos (IVA)': '12,14€',
                    },
                    totalLabel: 'Total',
                    taxesIncludedLabel: '(IVA incluido)',
                    totalPrice: '132,09€',
                  ),
                );
              },
            );
          },
        ),
      ),
    ];
