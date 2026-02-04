import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get milestonesStories => [
      Story(
        name: 'Milestones/Suggested Milestone',
        description: 'Demo page for Suggested Milestone',
        builder: (context) => SizedBox(),
      ),
      Story(
        name: 'Milestones/Milestone Card',
        description: 'Demo page for Milestone Card',
        builder: (context) => MilestoneCard(
          width: context.knobs.slider(label: 'Width', initial: 220, min: 100, max: 400),
          imageProvider: CachedNetworkImageProvider(
            context.knobs.text(label: 'Image URL', initial: 'https://picsum.photos/250?image=9'),
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
        ),
      ),
      Story(
        name: 'Milestones/Milestones List',
        description: 'Demo page for Milestones List',
        builder: (context) => SizedBox(),
      ),
    ];
