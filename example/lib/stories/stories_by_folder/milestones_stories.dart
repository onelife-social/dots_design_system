import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get milestonesStories => [
      Story(
        name: 'Milestones/Milestone Card',
        description: 'Demo page for Milestone Card',
        builder: (context) => MilestoneCard(
          width: context.knobs.slider(label: 'Width', initial: 220, min: 100, max: 400),
          imageProvider: CachedNetworkImageProvider(
            context.knobs.text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
          ),
          defaultImage: CachedNetworkImageProvider(
            context.knobs
                .text(label: 'Default Image URL', initial: 'https://picsum.photos/250?image=9'),
          ),
          title: context.knobs.text(label: 'Title', initial: 'Primeros pasos'),
          date: context.knobs.text(label: 'Date', initial: '2 años y 1 mes'),
          showBadge: context.knobs.boolean(label: 'Show Badge?', initial: false),
          showEdit: context.knobs.boolean(label: 'Show Edit Button?', initial: false),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('On tap!')),
          ),
          onTapEdit: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('On tap! Edit btn')),
          ),
          badgeTypes: () {
            final badgeCount = context.knobs.sliderInt(
              label: 'Number of badges',
              initial: 2,
              min: 0,
              max: 3,
            );
            const allBadges = MilestoneBadgeType.values;
            if (badgeCount == 0) return <MilestoneBadgeType>[];
            return allBadges
                .take(badgeCount)
                .toList()
                .toList();
          }(),
          onBadgesTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('On tap! Badges')),
          ),
        ),
      ),
      Story(
        name: 'Milestones/Milestones List',
        description: 'Demo page for Milestones List',
        builder: (context) {
          final List<dynamic> list = [
            'FEB 2026',
            MilestoneCard(
              width: 244,
              imageProvider: CachedNetworkImageProvider('https://picsum.photos/250?image=1'),
              defaultImage: CachedNetworkImageProvider('https://picsum.photos/250?image=5'),
              title: 'Primeros pasos',
              date: '2 años y 1 mes',
              showBadge: false,
              showEdit: false,
            ),
            'DIC 2025',
            MilestoneCard(
              width: 244,
              imageProvider: CachedNetworkImageProvider('https://picsum.photos/250?image=2'),
              defaultImage: CachedNetworkImageProvider('https://picsum.photos/250?image=5'),
              title: 'Primeros pasos',
              date: '2 años y 1 mes',
              showBadge: false,
              showEdit: false,
            ),
            MilestoneCard(
              width: 244,
              imageProvider: CachedNetworkImageProvider('https://picsum.photos/250?image=3'),
              defaultImage: CachedNetworkImageProvider('https://picsum.photos/250?image=5'),
              title: 'Primeros pasos',
              date: '2 años y 1 mes',
              showBadge: false,
              showEdit: false,
            ),
            'JUL 2025',
            MilestoneCard(
              width: 244,
              imageProvider: CachedNetworkImageProvider('https://picsum.photos/250?image=4'),
              defaultImage: CachedNetworkImageProvider('https://picsum.photos/250?image=5'),
              title: 'Primeros pasos',
              showBadge: false,
              showEdit: false,
            ),
            MilestoneCard(
              width: 244,
              imageProvider: CachedNetworkImageProvider('https://picsum.photos/250?image=5'),
              defaultImage: CachedNetworkImageProvider('https://picsum.photos/250?image=5'),
              title: 'Primeros pasos asdf asdf asdf asdf asdf asdf asdf asdf dfgh dfgh dfgh ',
              date: '2 años y 1 mes',
              showBadge: false,
              showEdit: true,
            ),
            MilestoneCard(
              width: 244,
              imageProvider: CachedNetworkImageProvider('https://picsum.photos/250?image=6'),
              defaultImage: CachedNetworkImageProvider('https://picsum.photos/250?image=5'),
              title: 'Primeros pasos asdf fasdf asdf asdf asdf asdf dfgh dfgh dfgh dfgh',
              limitTitle: true,
              date: '2 años y 1 mes',
              showBadge: false,
              showEdit: true,
            ),
          ];

          return MilestonesList(list: list, seed: 1);
        },
      ),
    ];
