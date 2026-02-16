import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

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
        name: 'DotBook Components/DotBook cover',
        description: 'Demo page for DotBook cover',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DotBookCover(
              variant: context.knobs.options(
                label: 'Cover variant',
                initial: DotBookCoverType.linen,
                options: const [
                  Option(label: 'Linen', value: DotBookCoverType.linen),
                  Option(label: 'Printed Square', value: DotBookCoverType.printedSquare),
                  Option(label: 'Printed Circle', value: DotBookCoverType.printedCircle),
                ],
              ),
              color: context.knobs.options(
                label: 'Cover color',
                initial: DotBookCoverColor.white,
                options: const [
                  Option(label: 'White', value: DotBookCoverColor.white),
                  Option(label: 'Stone', value: DotBookCoverColor.stone),
                  Option(label: 'Charcoal', value: DotBookCoverColor.charcoal),
                  Option(label: 'Cloud', value: DotBookCoverColor.cloud),
                  Option(label: 'Olive', value: DotBookCoverColor.olive),
                  Option(label: 'Peach', value: DotBookCoverColor.peach),
                  Option(label: 'Sand', value: DotBookCoverColor.sand),
                  Option(label: 'Beige Craft', value: DotBookCoverColor.beigeCraft),
                ],
              ),
              bottomText: context.knobs.text(label: 'Bottom text', initial: 'My DotBook'),
              onOverlayTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Overlay tapped')),
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
            ),
          ),
        ),
      ),
      Story(
        name: 'DotBook Components/DotBook titles editor',
        description: 'Demo page for DotBook titles editor',
        builder: (context) => ColoredBox(
          color: context.dotsTheme.colors.bgContainerSecondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DotBookTitlesEditor(
              width: 300,
              height: 150,
              variant: context.knobs.options(
                label: 'Editor variant',
                initial: DotBookTitlesEditorVariant.defaultVariant,
                options: const [
                  Option(label: 'Default', value: DotBookTitlesEditorVariant.defaultVariant),
                  Option(label: 'Printed Square', value: DotBookTitlesEditorVariant.printedSquare),
                ],
              ),
              title: context.knobs.text(label: 'Title', initial: 'My DotBook'),
              date: context.knobs.text(label: 'Date', initial: 'June 2024'),
            ),
          ),
        ),
      ),
    ];
