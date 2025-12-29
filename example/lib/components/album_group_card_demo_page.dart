import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class AlbumGroupCardDemoPage extends StatelessWidget {
  final ImageProvider imageProvider;
  final String title;
  final AlbumGroupCardVariant variant;
  final DotsIconData? tagIconData;
  final double blurSigma;
  final double edgeSize;
  final bool isBlocked;

  const AlbumGroupCardDemoPage({
    super.key,
    required this.imageProvider,
    required this.title,
    required this.variant,
    this.tagIconData,
    required this.blurSigma,
    required this.edgeSize,
    this.isBlocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return variant == AlbumGroupCardVariant.small
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AlbumGroupCard(
                  imageProvider: imageProvider,
                  title: title,
                  variant: variant,
                  tagIconData: tagIconData,
                  onTap: () {},
                  onError: (exception, stackTrace) {},
                  blurSigma: blurSigma,
                  edgeSize: edgeSize,
                  isBlocked: isBlocked,
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: AlbumGroupCard(
                  imageProvider: imageProvider,
                  title: title,
                  variant: variant,
                  tagIconData: tagIconData,
                  onTap: () {},
                  onError: (exception, stackTrace) {},
                  blurSigma: blurSigma,
                  edgeSize: edgeSize,
                  isBlocked: isBlocked,
                ),
              ),
            ],
          )
        : Column(
            children: [
              AlbumGroupCard(
                imageProvider: imageProvider,
                title: title,
                variant: variant,
                tagIconData: tagIconData,
                onTap: () {},
                onError: (exception, stackTrace) {},
                blurSigma: blurSigma,
                edgeSize: edgeSize,
                isBlocked: isBlocked,
              ),
              SizedBox(
                height: 20.0,
              ),
              AlbumGroupCard(
                imageProvider: imageProvider,
                title: title,
                variant: variant,
                tagIconData: tagIconData,
                onTap: () {},
                onError: (exception, stackTrace) {},
                blurSigma: blurSigma,
                edgeSize: edgeSize,
                isBlocked: isBlocked,
              ),
            ],
          );
  }
}
