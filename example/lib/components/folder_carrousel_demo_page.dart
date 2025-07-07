import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class FolderCarrouselDemoPage extends StatelessWidget {
  const FolderCarrouselDemoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FolderCarrousel(
      buttons: [
        BtnFolder(
          text: 'Search',
          icon: DotsIconData.search,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
          isSelected: true,
        ),
        BtnFolder(
          text: 'All',
          icon: DotsIconData.archive,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
        ),
        BtnFolder(
          text: 'Favorites',
          icon: DotsIconData.cake,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
        ),
        BtnFolder(
          text: 'Work',
          icon: DotsIconData.weddingRings,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
        ),
        BtnFolder(
          text: 'Personal',
          icon: DotsIconData.heart,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
        ),
        BtnFolder(
          text: 'Weddings',
          icon: DotsIconData.star,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
        ),
        BtnFolder(
          text: 'Trips',
          icon: DotsIconData.album,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
        ),
        BtnFolder(
          text: 'Friends',
          icon: DotsIconData.friends,
          onPressed: () {},
          iconSelectedColor: DotsColors.light.gradientInitialLinealGreen,
        ),
      ],
    );
  }
}
