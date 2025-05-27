import 'package:flutter/painting.dart';

class DotsTypoModel {
  final DotsTypoMainModel main;
  final DotsTypoNumberModel number;
  final DotsTypoSecondaryModel secondary;

  const DotsTypoModel({
    required this.main,
    required this.number,
    required this.secondary,
  });

  DotsTypoModel lerp(DotsTypoModel? other, double t) {
    return DotsTypoModel(
      main: main.lerp(other?.main, t),
      number: number.lerp(other?.number, t),
      secondary: secondary.lerp(other?.secondary, t),
    );
  }
}

class DotsTypoMainModel {
  // Title
  final TextStyle titleH1;
  final TextStyle titleH2;
  final TextStyle titleH3;
  final TextStyle titleH4;
  final TextStyle titleH5;
  final TextStyle titleH6;

  // Body
  final TextStyle bodyLargeRegular;
  final TextStyle bodyLargeMedium;
  final TextStyle bodyLargeBold;
  final TextStyle bodyDefaultRegular;
  final TextStyle bodyDefaultMedium;
  final TextStyle bodyDefaultBold;

  // Label
  final TextStyle labelDefaultRegular;
  final TextStyle labelDefaultBold;
  final TextStyle labelSmallRegular;
  final TextStyle labelSmallMedium;

  DotsTypoMainModel({
    required this.titleH1,
    required this.titleH2,
    required this.titleH3,
    required this.titleH4,
    required this.titleH5,
    required this.titleH6,
    required this.bodyLargeRegular,
    required this.bodyLargeMedium,
    required this.bodyLargeBold,
    required this.bodyDefaultRegular,
    required this.bodyDefaultMedium,
    required this.bodyDefaultBold,
    required this.labelDefaultRegular,
    required this.labelDefaultBold,
    required this.labelSmallRegular,
    required this.labelSmallMedium,
  });

  DotsTypoMainModel lerp(DotsTypoMainModel? other, double t) {
    return DotsTypoMainModel(
      titleH1: TextStyle.lerp(titleH1, other?.titleH1, t) ?? titleH1,
      titleH2: TextStyle.lerp(titleH2, other?.titleH2, t) ?? titleH2,
      titleH3: TextStyle.lerp(titleH3, other?.titleH3, t) ?? titleH3,
      titleH4: TextStyle.lerp(titleH4, other?.titleH4, t) ?? titleH4,
      titleH5: TextStyle.lerp(titleH5, other?.titleH5, t) ?? titleH5,
      titleH6: TextStyle.lerp(titleH6, other?.titleH6, t) ?? titleH6,
      bodyLargeRegular:
          TextStyle.lerp(bodyLargeRegular, other?.bodyLargeRegular, t) ?? bodyLargeRegular,
      bodyLargeMedium:
          TextStyle.lerp(bodyLargeMedium, other?.bodyLargeMedium, t) ?? bodyLargeMedium,
      bodyLargeBold: TextStyle.lerp(bodyLargeBold, other?.bodyLargeBold, t) ?? bodyLargeBold,
      bodyDefaultRegular:
          TextStyle.lerp(bodyDefaultRegular, other?.bodyDefaultRegular, t) ?? bodyDefaultRegular,
      bodyDefaultMedium:
          TextStyle.lerp(bodyDefaultMedium, other?.bodyDefaultMedium, t) ?? bodyDefaultMedium,
      bodyDefaultBold:
          TextStyle.lerp(bodyDefaultBold, other?.bodyDefaultBold, t) ?? bodyDefaultBold,
      labelDefaultRegular:
          TextStyle.lerp(labelDefaultRegular, other?.labelDefaultRegular, t) ?? labelDefaultRegular,
      labelDefaultBold:
          TextStyle.lerp(labelDefaultBold, other?.labelDefaultBold, t) ?? labelDefaultBold,
      labelSmallRegular:
          TextStyle.lerp(labelSmallRegular, other?.labelSmallRegular, t) ?? labelSmallRegular,
      labelSmallMedium:
          TextStyle.lerp(labelSmallMedium, other?.labelSmallMedium, t) ?? labelSmallMedium,
    );
  }
}

class DotsTypoNumberModel {
  // Title
  final TextStyle numTitleH1;
  final TextStyle numTitleH2;
  final TextStyle numTitleH3;
  final TextStyle numTitleH4;
  final TextStyle numTitleH5;
  final TextStyle numTitleH6;

  // Body
  final TextStyle numBodyLarge;
  final TextStyle numBodyDefault;

  // Label
  final TextStyle numLabelDefault;
  final TextStyle numLabelSmall;

  DotsTypoNumberModel({
    required this.numTitleH1,
    required this.numTitleH2,
    required this.numTitleH3,
    required this.numTitleH4,
    required this.numTitleH5,
    required this.numTitleH6,
    required this.numBodyLarge,
    required this.numBodyDefault,
    required this.numLabelDefault,
    required this.numLabelSmall,
  });

  DotsTypoNumberModel lerp(DotsTypoNumberModel? other, double t) {
    return DotsTypoNumberModel(
      numTitleH1: TextStyle.lerp(numTitleH1, other?.numTitleH1, t) ?? numTitleH1,
      numTitleH2: TextStyle.lerp(numTitleH2, other?.numTitleH2, t) ?? numTitleH2,
      numTitleH3: TextStyle.lerp(numTitleH3, other?.numTitleH3, t) ?? numTitleH3,
      numTitleH4: TextStyle.lerp(numTitleH4, other?.numTitleH4, t) ?? numTitleH4,
      numTitleH5: TextStyle.lerp(numTitleH5, other?.numTitleH5, t) ?? numTitleH5,
      numTitleH6: TextStyle.lerp(numTitleH6, other?.numTitleH6, t) ?? numTitleH6,
      numBodyLarge: TextStyle.lerp(numBodyLarge, other?.numBodyLarge, t) ?? numBodyLarge,
      numBodyDefault: TextStyle.lerp(numBodyDefault, other?.numBodyDefault, t) ?? numBodyDefault,
      numLabelDefault:
          TextStyle.lerp(numLabelDefault, other?.numLabelDefault, t) ?? numLabelDefault,
      numLabelSmall: TextStyle.lerp(numLabelSmall, other?.numLabelSmall, t) ?? numLabelSmall,
    );
  }
}

class DotsTypoSecondaryModel {
  // Title
  final TextStyle title02H1;
  final TextStyle title02H2;
  final TextStyle title02H3;
  final TextStyle title02H4;
  final TextStyle title02H5;
  final TextStyle title02H6;

  const DotsTypoSecondaryModel({
    required this.title02H1,
    required this.title02H2,
    required this.title02H3,
    required this.title02H4,
    required this.title02H5,
    required this.title02H6,
  });

  DotsTypoSecondaryModel lerp(DotsTypoSecondaryModel? other, double t) {
    return DotsTypoSecondaryModel(
      title02H1: TextStyle.lerp(title02H1, other?.title02H1, t) ?? title02H1,
      title02H2: TextStyle.lerp(title02H2, other?.title02H2, t) ?? title02H2,
      title02H3: TextStyle.lerp(title02H3, other?.title02H3, t) ?? title02H3,
      title02H4: TextStyle.lerp(title02H4, other?.title02H4, t) ?? title02H4,
      title02H5: TextStyle.lerp(title02H5, other?.title02H5, t) ?? title02H5,
      title02H6: TextStyle.lerp(title02H6, other?.title02H6, t) ?? title02H6,
    );
  }
}
