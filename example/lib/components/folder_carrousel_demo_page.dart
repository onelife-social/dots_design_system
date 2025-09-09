import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class FolderCarrouselDemoPage extends StatelessWidget {
  const FolderCarrouselDemoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FolderCarrousel(
      showEditIcon: context.knobs.boolean(
        label: 'Show edit icon in buttons?',
        initial: false,
      ),
      buttonsData: [
        BtnFolderData(
          text: 'Search',
          icon: DotsIconData.search,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
          isSelected: true,
        ),
        BtnFolderData(
          text: 'All',
          icon: DotsIconData.archive,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
        ),
        BtnFolderData(
          text: 'Favorites',
          icon: DotsIconData.cake,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
        ),
        BtnFolderData(
          text: 'Work',
          icon: DotsIconData.weddingRings,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
        ),
        BtnFolderData(
          text: 'Personal',
          icon: DotsIconData.heart,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
        ),
        BtnFolderData(
          text: 'Weddings',
          icon: DotsIconData.star,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
          isEditable: true,
        ),
        BtnFolderData(
          text: 'Trips',
          icon: DotsIconData.album,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
          isEditable: true,
        ),
        BtnFolderData(
          text: 'Friends',
          icon: DotsIconData.friends,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
          isEditable: true,
        ),
      ],
    );
  }
}
