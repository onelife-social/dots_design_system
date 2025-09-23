import 'package:flutter/widgets.dart';

class DotsColorsModel {
  // Base
  final Color bgBase;
  final Color bgBaseContrast;
  final Color bgBaseGradientStart;

  // Container
  final Color bgContainerPrimary;
  final Color bgContainerSecondary;
  final Color bgContainerSecondaryOnBackground;
  final Color bgContainerTertiary;
  final Color bgAlert;
  final Color bgStrong;

  // Prime Tag
  final Color bgToastLight;

  // Buttons
  final Color bgSecondaryBtn;
  final Color bgFloatingBtn;
  final Color bgFloatingActive;
  final Color bgFloatingBase;
  final Color bgBtnImage;
  final Color bgBtnDisabled;

  // Components
  final Color bgChip;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textQuarternary;
  final Color textDisabled;

  // Label
  final Color labelPrimary;
  final Color labelSecondary;
  final Color labelAlwaysWhite;

  // Semantic
  final Color labelHighlight;
  final Color bgHighlight;
  final Color labelDestructive;
  final Color bgDestructive;
  final Color labelActive;
  final Color labelInactive;
  final Color bgActive;

  // Miscellaneous

  final Color misc100;
  final Color misc200;
  final Color misc300;
  final Color misc400;
  final Color misc500;
  final Color misc600;
  final Color misc700;
  final Color misc800;
  final Color misc900;
  final Color misc1000;
  final Color misc1100;

  // Wedding

  final Color wedding001;
  final Color wedding002;
  final Color wedding003;
  final Color wedding004;
  final Color wedding005;
  final Color wedding006;
  final Color wedding007;
  final Color wedding008;
  final Color wedding009;
  final Color wedding010;

  // Birthday

  final Color birthday001;
  final Color birthday002;
  final Color birthday003;
  final Color birthday004;
  final Color birthday005;
  final Color birthday006;
  final Color birthday007;
  final Color birthday008;
  final Color birthday009;
  final Color birthday010;

  // Celebration

  final Color celebration001;
  final Color celebration002;
  final Color celebration003;
  final Color celebration004;
  final Color celebration005;
  final Color celebration006;
  final Color celebration007;
  final Color celebration008;
  final Color celebration009;
  final Color celebration010;

  // Other

  final Color other001;
  final Color other002;
  final Color other003;
  final Color other004;
  final Color other005;
  final Color other006;
  final Color other007;
  final Color other008;
  final Color other009;
  final Color other010;

  // Couple

  final Color couple001;
  final Color couple002;
  final Color couple003;
  final Color couple004;
  final Color couple005;
  final Color couple006;
  final Color couple007;
  final Color couple008;
  final Color couple009;
  final Color couple010;

  // Children

  final Color child001;
  final Color child002;
  final Color child003;
  final Color child004;
  final Color child005;
  final Color child006;
  final Color child007;
  final Color child008;
  final Color child009;
  final Color child010;

  // Family

  final Color family001;
  final Color family002;
  final Color family003;
  final Color family004;
  final Color family005;
  final Color family006;
  final Color family007;
  final Color family008;
  final Color family009;
  final Color family010;

  // Friends

  final Color friends001;
  final Color friends002;
  final Color friends003;
  final Color friends004;
  final Color friends005;
  final Color friends006;
  final Color friends007;
  final Color friends008;
  final Color friends009;
  final Color friends010;

  // Individual

  final Color individual001;
  final Color individual002;
  final Color individual003;
  final Color individual004;
  final Color individual005;
  final Color individual006;
  final Color individual007;
  final Color individual008;
  final Color individual009;
  final Color individual010;

  // Work

  final Color work001;
  final Color work002;
  final Color work003;
  final Color work004;
  final Color work005;
  final Color work006;
  final Color work007;
  final Color work008;
  final Color work009;
  final Color work010;

  // Class

  final Color class001;
  final Color class002;
  final Color class003;
  final Color class004;
  final Color class005;
  final Color class006;
  final Color class007;
  final Color class008;
  final Color class009;
  final Color class010;

  // Team

  final Color team001;
  final Color team002;
  final Color team003;
  final Color team004;
  final Color team005;
  final Color team006;
  final Color team007;
  final Color team008;
  final Color team009;
  final Color team010;

  // Hobby

  final Color hobby001;
  final Color hobby002;
  final Color hobby003;
  final Color hobby004;
  final Color hobby005;
  final Color hobby006;
  final Color hobby007;
  final Color hobby008;
  final Color hobby009;
  final Color hobby010;

  // Shadow

  final Color shadowPrimary;

  // Gradient
  final Color gradientInitialLineal;
  final Color gradientFinalLineal;
  final Color gradientInitialLinealGreen;
  final Color gradientFinalLinealGreen;
  final Color gradientInitialLinealPurple;
  final Color gradientFinalLinealPurple;
  final Color gradientInitialPremiumHeader;
  final Color gradientMiddlePremiumHeader;

  //generics
  final Color transparent;

  //border
  final Color borderAlert;
  final Color borderLabel;
  final Color borderGlass;
  final Color borderButton;

  // Fills
  final Color fillSecondary;

  // Premium
  final Color textPremiumStart;
  final Color textPremiumEnd;
  final Color textPremiumPlusStart;
  final Color textPremiumPlusEnd;

  const DotsColorsModel({
    required this.bgBase,
    required this.bgBaseContrast,
    required this.bgBaseGradientStart,
    required this.bgContainerPrimary,
    required this.bgContainerSecondary,
    required this.bgContainerSecondaryOnBackground,
    required this.bgContainerTertiary,
    required this.bgSecondaryBtn,
    required this.bgFloatingBtn,
    required this.bgBtnImage,
    required this.bgBtnDisabled,
    required this.bgToastLight,
    required this.bgChip,
    required this.bgAlert,
    required this.bgStrong,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textQuarternary,
    required this.textDisabled,
    required this.labelPrimary,
    required this.labelSecondary,
    required this.labelHighlight,
    required this.labelAlwaysWhite,
    required this.bgHighlight,
    required this.labelDestructive,
    required this.bgDestructive,
    required this.labelActive,
    required this.labelInactive,
    required this.bgActive,
    required this.bgFloatingBase,
    required this.bgFloatingActive,
    required this.misc100,
    required this.misc200,
    required this.misc300,
    required this.misc400,
    required this.misc500,
    required this.misc600,
    required this.misc700,
    required this.misc800,
    required this.misc900,
    required this.misc1000,
    required this.misc1100,
    required this.shadowPrimary,
    required this.wedding001,
    required this.wedding002,
    required this.wedding003,
    required this.wedding004,
    required this.wedding005,
    required this.wedding006,
    required this.wedding007,
    required this.wedding008,
    required this.wedding009,
    required this.wedding010,
    required this.birthday001,
    required this.birthday002,
    required this.birthday003,
    required this.birthday004,
    required this.birthday005,
    required this.birthday006,
    required this.birthday007,
    required this.birthday008,
    required this.birthday009,
    required this.birthday010,
    required this.celebration001,
    required this.celebration002,
    required this.celebration003,
    required this.celebration004,
    required this.celebration005,
    required this.celebration006,
    required this.celebration007,
    required this.celebration008,
    required this.celebration009,
    required this.celebration010,
    required this.other001,
    required this.other002,
    required this.other003,
    required this.other004,
    required this.other005,
    required this.other006,
    required this.other007,
    required this.other008,
    required this.other009,
    required this.other010,
    required this.couple001,
    required this.couple002,
    required this.couple003,
    required this.couple004,
    required this.couple005,
    required this.couple006,
    required this.couple007,
    required this.couple008,
    required this.couple009,
    required this.couple010,
    required this.child001,
    required this.child002,
    required this.child003,
    required this.child004,
    required this.child005,
    required this.child006,
    required this.child007,
    required this.child008,
    required this.child009,
    required this.child010,
    required this.family001,
    required this.family002,
    required this.family003,
    required this.family004,
    required this.family005,
    required this.family006,
    required this.family007,
    required this.family008,
    required this.family009,
    required this.family010,
    required this.friends001,
    required this.friends002,
    required this.friends003,
    required this.friends004,
    required this.friends005,
    required this.friends006,
    required this.friends007,
    required this.friends008,
    required this.friends009,
    required this.friends010,
    required this.individual001,
    required this.individual002,
    required this.individual003,
    required this.individual004,
    required this.individual005,
    required this.individual006,
    required this.individual007,
    required this.individual008,
    required this.individual009,
    required this.individual010,
    required this.work001,
    required this.work002,
    required this.work003,
    required this.work004,
    required this.work005,
    required this.work006,
    required this.work007,
    required this.work008,
    required this.work009,
    required this.work010,
    required this.class001,
    required this.class002,
    required this.class003,
    required this.class004,
    required this.class005,
    required this.class006,
    required this.class007,
    required this.class008,
    required this.class009,
    required this.class010,
    required this.team001,
    required this.team002,
    required this.team003,
    required this.team004,
    required this.team005,
    required this.team006,
    required this.team007,
    required this.team008,
    required this.team009,
    required this.team010,
    required this.hobby001,
    required this.hobby002,
    required this.hobby003,
    required this.hobby004,
    required this.hobby005,
    required this.hobby006,
    required this.hobby007,
    required this.hobby008,
    required this.hobby009,
    required this.hobby010,
    required this.gradientInitialLineal,
    required this.gradientFinalLineal,
    required this.gradientInitialLinealGreen,
    required this.gradientFinalLinealGreen,
    required this.gradientInitialLinealPurple,
    required this.gradientFinalLinealPurple,
    required this.gradientInitialPremiumHeader,
    required this.gradientMiddlePremiumHeader,
    required this.transparent,
    required this.borderAlert,
    required this.borderLabel,
    required this.borderGlass,
    required this.borderButton,
    required this.fillSecondary,
    required this.textPremiumStart,
    required this.textPremiumEnd,
    required this.textPremiumPlusStart,
    required this.textPremiumPlusEnd,
  });

  DotsColorsModel lerp(DotsColorsModel? other, double t) {
    return DotsColorsModel(
      bgBase: Color.lerp(bgBase, other?.bgBase, t) ?? bgBase,
      bgBaseContrast: Color.lerp(bgBaseContrast, other?.bgBaseContrast, t) ?? bgBaseContrast,
      bgBaseGradientStart:
          Color.lerp(bgBaseGradientStart, other?.bgBaseGradientStart, t) ?? bgBaseGradientStart,
      bgContainerPrimary:
          Color.lerp(bgContainerPrimary, other?.bgContainerPrimary, t) ?? bgContainerPrimary,
      bgContainerSecondary:
          Color.lerp(bgContainerSecondary, other?.bgContainerSecondary, t) ?? bgContainerSecondary,
      bgContainerSecondaryOnBackground: Color.lerp(
              bgContainerSecondaryOnBackground, other?.bgContainerSecondaryOnBackground, t) ??
          bgContainerSecondaryOnBackground,
      bgContainerTertiary:
          Color.lerp(bgContainerTertiary, other?.bgContainerTertiary, t) ?? bgContainerTertiary,
      bgSecondaryBtn: Color.lerp(bgSecondaryBtn, other?.bgSecondaryBtn, t) ?? bgSecondaryBtn,
      bgToastLight: Color.lerp(bgToastLight, other?.bgToastLight, t) ?? bgToastLight,
      bgFloatingBtn: Color.lerp(bgFloatingBtn, other?.bgFloatingBtn, t) ?? bgFloatingBtn,
      bgBtnImage: Color.lerp(bgBtnImage, other?.bgBtnImage, t) ?? bgBtnImage,
      bgBtnDisabled: Color.lerp(bgBtnDisabled, other?.bgBtnDisabled, t) ?? bgBtnDisabled,
      bgChip: Color.lerp(bgChip, other?.bgChip, t) ?? bgChip,
      bgAlert: Color.lerp(bgAlert, other?.bgAlert, t) ?? bgAlert,
      bgStrong: Color.lerp(bgStrong, other?.bgStrong, t) ?? bgStrong,
      textPrimary: Color.lerp(textPrimary, other?.textPrimary, t) ?? textPrimary,
      textSecondary: Color.lerp(textSecondary, other?.textSecondary, t) ?? textSecondary,
      textTertiary: Color.lerp(textTertiary, other?.textTertiary, t) ?? textTertiary,
      textQuarternary: Color.lerp(textQuarternary, other?.textQuarternary, t) ?? textQuarternary,
      textDisabled: Color.lerp(textDisabled, other?.textDisabled, t) ?? textDisabled,
      labelPrimary: Color.lerp(labelPrimary, other?.labelPrimary, t) ?? labelPrimary,
      labelSecondary: Color.lerp(labelSecondary, other?.labelSecondary, t) ?? labelSecondary,
      labelHighlight: Color.lerp(labelHighlight, other?.labelHighlight, t) ?? labelHighlight,
      labelAlwaysWhite:
          Color.lerp(labelAlwaysWhite, other?.labelAlwaysWhite, t) ?? labelAlwaysWhite,
      bgHighlight: Color.lerp(bgHighlight, other?.bgHighlight, t) ?? bgHighlight,
      labelDestructive:
          Color.lerp(labelDestructive, other?.labelDestructive, t) ?? labelDestructive,
      bgDestructive: Color.lerp(bgDestructive, other?.bgDestructive, t) ?? bgDestructive,
      labelActive: Color.lerp(labelActive, other?.labelActive, t) ?? labelActive,
      labelInactive: Color.lerp(labelInactive, other?.labelInactive, t) ?? labelInactive,
      bgActive: Color.lerp(bgActive, other?.bgActive, t) ?? bgActive,
      bgFloatingBase: Color.lerp(bgFloatingBase, other?.bgFloatingBase, t) ?? bgFloatingBase,
      bgFloatingActive:
          Color.lerp(bgFloatingActive, other?.bgFloatingActive, t) ?? bgFloatingActive,
      misc100: Color.lerp(misc100, other?.misc100, t) ?? misc100,
      misc200: Color.lerp(misc200, other?.misc200, t) ?? misc200,
      misc300: Color.lerp(misc300, other?.misc300, t) ?? misc300,
      misc400: Color.lerp(misc400, other?.misc400, t) ?? misc400,
      misc500: Color.lerp(misc500, other?.misc500, t) ?? misc500,
      misc600: Color.lerp(misc600, other?.misc600, t) ?? misc600,
      misc700: Color.lerp(misc700, other?.misc700, t) ?? misc700,
      misc800: Color.lerp(misc800, other?.misc800, t) ?? misc800,
      misc900: Color.lerp(misc900, other?.misc900, t) ?? misc900,
      misc1000: Color.lerp(misc1000, other?.misc1000, t) ?? misc1000,
      misc1100: Color.lerp(misc1100, other?.misc1100, t) ?? misc1100,
      shadowPrimary: Color.lerp(shadowPrimary, other?.shadowPrimary, t) ?? shadowPrimary,
      wedding001: Color.lerp(wedding001, other?.wedding001, t) ?? wedding001,
      wedding002: Color.lerp(wedding002, other?.wedding002, t) ?? wedding002,
      wedding003: Color.lerp(wedding003, other?.wedding003, t) ?? wedding003,
      wedding004: Color.lerp(wedding004, other?.wedding004, t) ?? wedding004,
      wedding005: Color.lerp(wedding005, other?.wedding005, t) ?? wedding005,
      wedding006: Color.lerp(wedding006, other?.wedding006, t) ?? wedding006,
      wedding007: Color.lerp(wedding007, other?.wedding007, t) ?? wedding007,
      wedding008: Color.lerp(wedding008, other?.wedding008, t) ?? wedding008,
      wedding009: Color.lerp(wedding009, other?.wedding009, t) ?? wedding009,
      wedding010: Color.lerp(wedding010, other?.wedding010, t) ?? wedding010,
      birthday001: Color.lerp(birthday001, other?.birthday001, t) ?? birthday001,
      birthday002: Color.lerp(birthday002, other?.birthday002, t) ?? birthday002,
      birthday003: Color.lerp(birthday003, other?.birthday003, t) ?? birthday003,
      birthday004: Color.lerp(birthday004, other?.birthday004, t) ?? birthday004,
      birthday005: Color.lerp(birthday005, other?.birthday005, t) ?? birthday005,
      birthday006: Color.lerp(birthday006, other?.birthday006, t) ?? birthday006,
      birthday007: Color.lerp(birthday007, other?.birthday007, t) ?? birthday007,
      birthday008: Color.lerp(birthday008, other?.birthday008, t) ?? birthday008,
      birthday009: Color.lerp(birthday009, other?.birthday009, t) ?? birthday009,
      birthday010: Color.lerp(birthday010, other?.birthday010, t) ?? birthday010,
      celebration001: Color.lerp(celebration001, other?.celebration001, t) ?? celebration001,
      celebration002: Color.lerp(celebration002, other?.celebration002, t) ?? celebration002,
      celebration003: Color.lerp(celebration003, other?.celebration003, t) ?? celebration003,
      celebration004: Color.lerp(celebration004, other?.celebration004, t) ?? celebration004,
      celebration005: Color.lerp(celebration005, other?.celebration005, t) ?? celebration005,
      celebration006: Color.lerp(celebration006, other?.celebration006, t) ?? celebration006,
      celebration007: Color.lerp(celebration007, other?.celebration007, t) ?? celebration007,
      celebration008: Color.lerp(celebration008, other?.celebration008, t) ?? celebration008,
      celebration009: Color.lerp(celebration009, other?.celebration009, t) ?? celebration009,
      celebration010: Color.lerp(celebration010, other?.celebration010, t) ?? celebration010,
      other001: Color.lerp(other001, other?.other001, t) ?? other001,
      other002: Color.lerp(other002, other?.other002, t) ?? other002,
      other003: Color.lerp(other003, other?.other003, t) ?? other003,
      other004: Color.lerp(other004, other?.other004, t) ?? other004,
      other005: Color.lerp(other005, other?.other005, t) ?? other005,
      other006: Color.lerp(other006, other?.other006, t) ?? other006,
      other007: Color.lerp(other007, other?.other007, t) ?? other007,
      other008: Color.lerp(other008, other?.other008, t) ?? other008,
      other009: Color.lerp(other009, other?.other009, t) ?? other009,
      other010: Color.lerp(other010, other?.other010, t) ?? other010,
      couple001: Color.lerp(couple001, other?.couple001, t) ?? couple001,
      couple002: Color.lerp(couple002, other?.couple002, t) ?? couple002,
      couple003: Color.lerp(couple003, other?.couple003, t) ?? couple003,
      couple004: Color.lerp(couple004, other?.couple004, t) ?? couple004,
      couple005: Color.lerp(couple005, other?.couple005, t) ?? couple005,
      couple006: Color.lerp(couple006, other?.couple006, t) ?? couple006,
      couple007: Color.lerp(couple007, other?.couple007, t) ?? couple007,
      couple008: Color.lerp(couple008, other?.couple008, t) ?? couple008,
      couple009: Color.lerp(couple009, other?.couple009, t) ?? couple009,
      couple010: Color.lerp(couple010, other?.couple010, t) ?? couple010,
      child001: Color.lerp(child001, other?.child001, t) ?? child001,
      child002: Color.lerp(child002, other?.child002, t) ?? child002,
      child003: Color.lerp(child003, other?.child003, t) ?? child003,
      child004: Color.lerp(child004, other?.child004, t) ?? child004,
      child005: Color.lerp(child005, other?.child005, t) ?? child005,
      child006: Color.lerp(child006, other?.child006, t) ?? child006,
      child007: Color.lerp(child007, other?.child007, t) ?? child007,
      child008: Color.lerp(child008, other?.child008, t) ?? child008,
      child009: Color.lerp(child009, other?.child009, t) ?? child009,
      child010: Color.lerp(child010, other?.child010, t) ?? child010,
      family001: Color.lerp(family001, other?.family001, t) ?? family001,
      family002: Color.lerp(family002, other?.family002, t) ?? family002,
      family003: Color.lerp(family003, other?.family003, t) ?? family003,
      family004: Color.lerp(family004, other?.family004, t) ?? family004,
      family005: Color.lerp(family005, other?.family005, t) ?? family005,
      family006: Color.lerp(family006, other?.family006, t) ?? family006,
      family007: Color.lerp(family007, other?.family007, t) ?? family007,
      family008: Color.lerp(family008, other?.family008, t) ?? family008,
      family009: Color.lerp(family009, other?.family009, t) ?? family009,
      family010: Color.lerp(family010, other?.family010, t) ?? family010,
      friends001: Color.lerp(friends001, other?.friends001, t) ?? friends001,
      friends002: Color.lerp(friends002, other?.friends002, t) ?? friends002,
      friends003: Color.lerp(friends003, other?.friends003, t) ?? friends003,
      friends004: Color.lerp(friends004, other?.friends004, t) ?? friends004,
      friends005: Color.lerp(friends005, other?.friends005, t) ?? friends005,
      friends006: Color.lerp(friends006, other?.friends006, t) ?? friends006,
      friends007: Color.lerp(friends007, other?.friends007, t) ?? friends007,
      friends008: Color.lerp(friends008, other?.friends008, t) ?? friends008,
      friends009: Color.lerp(friends009, other?.friends009, t) ?? friends009,
      friends010: Color.lerp(friends010, other?.friends010, t) ?? friends010,
      individual001: Color.lerp(individual001, other?.individual001, t) ?? individual001,
      individual002: Color.lerp(individual002, other?.individual002, t) ?? individual002,
      individual003: Color.lerp(individual003, other?.individual003, t) ?? individual003,
      individual004: Color.lerp(individual004, other?.individual004, t) ?? individual004,
      individual005: Color.lerp(individual005, other?.individual005, t) ?? individual005,
      individual006: Color.lerp(individual006, other?.individual006, t) ?? individual006,
      individual007: Color.lerp(individual007, other?.individual007, t) ?? individual007,
      individual008: Color.lerp(individual008, other?.individual008, t) ?? individual008,
      individual009: Color.lerp(individual009, other?.individual009, t) ?? individual009,
      individual010: Color.lerp(individual010, other?.individual010, t) ?? individual010,
      work001: Color.lerp(work001, other?.work001, t) ?? work001,
      work002: Color.lerp(work002, other?.work002, t) ?? work002,
      work003: Color.lerp(work003, other?.work003, t) ?? work003,
      work004: Color.lerp(work004, other?.work004, t) ?? work004,
      work005: Color.lerp(work005, other?.work005, t) ?? work005,
      work006: Color.lerp(work006, other?.work006, t) ?? work006,
      work007: Color.lerp(work007, other?.work007, t) ?? work007,
      work008: Color.lerp(work008, other?.work008, t) ?? work008,
      work009: Color.lerp(work009, other?.work009, t) ?? work009,
      work010: Color.lerp(work010, other?.work010, t) ?? work010,
      class001: Color.lerp(class001, other?.class001, t) ?? class001,
      class002: Color.lerp(class002, other?.class002, t) ?? class002,
      class003: Color.lerp(class003, other?.class003, t) ?? class003,
      class004: Color.lerp(class004, other?.class004, t) ?? class004,
      class005: Color.lerp(class005, other?.class005, t) ?? class005,
      class006: Color.lerp(class006, other?.class006, t) ?? class006,
      class007: Color.lerp(class007, other?.class007, t) ?? class007,
      class008: Color.lerp(class008, other?.class008, t) ?? class008,
      class009: Color.lerp(class009, other?.class009, t) ?? class009,
      class010: Color.lerp(class010, other?.class010, t) ?? class010,
      team001: Color.lerp(team001, other?.team001, t) ?? team001,
      team002: Color.lerp(team002, other?.team002, t) ?? team002,
      team003: Color.lerp(team003, other?.team003, t) ?? team003,
      team004: Color.lerp(team004, other?.team004, t) ?? team004,
      team005: Color.lerp(team005, other?.team005, t) ?? team005,
      team006: Color.lerp(team006, other?.team006, t) ?? team006,
      team007: Color.lerp(team007, other?.team007, t) ?? team007,
      team008: Color.lerp(team008, other?.team008, t) ?? team008,
      team009: Color.lerp(team009, other?.team009, t) ?? team009,
      team010: Color.lerp(team010, other?.team010, t) ?? team010,
      hobby001: Color.lerp(hobby001, other?.hobby001, t) ?? hobby001,
      hobby002: Color.lerp(hobby002, other?.hobby002, t) ?? hobby002,
      hobby003: Color.lerp(hobby003, other?.hobby003, t) ?? hobby003,
      hobby004: Color.lerp(hobby004, other?.hobby004, t) ?? hobby004,
      hobby005: Color.lerp(hobby005, other?.hobby005, t) ?? hobby005,
      hobby006: Color.lerp(hobby006, other?.hobby006, t) ?? hobby006,
      hobby007: Color.lerp(hobby007, other?.hobby007, t) ?? hobby007,
      hobby008: Color.lerp(hobby008, other?.hobby008, t) ?? hobby008,
      hobby009: Color.lerp(hobby009, other?.hobby009, t) ?? hobby009,
      hobby010: Color.lerp(hobby010, other?.hobby010, t) ?? hobby010,
      gradientInitialLineal: Color.lerp(gradientInitialLineal, other?.gradientInitialLineal, t) ??
          gradientInitialLineal,
      gradientFinalLineal:
          Color.lerp(gradientFinalLineal, other?.gradientFinalLineal, t) ?? gradientFinalLineal,
      gradientInitialLinealGreen:
          Color.lerp(gradientInitialLinealGreen, other?.gradientInitialLinealGreen, t) ??
              gradientInitialLinealGreen,
      gradientFinalLinealGreen:
          Color.lerp(gradientFinalLinealGreen, other?.gradientFinalLinealGreen, t) ??
              gradientFinalLinealGreen,
      gradientInitialLinealPurple:
          Color.lerp(gradientInitialLinealPurple, other?.gradientInitialLinealPurple, t) ??
              gradientInitialLinealPurple,
      gradientFinalLinealPurple:
          Color.lerp(gradientFinalLinealPurple, other?.gradientFinalLinealPurple, t) ??
              gradientFinalLinealPurple,
      gradientInitialPremiumHeader:
          Color.lerp(gradientInitialPremiumHeader, other?.gradientInitialPremiumHeader, t) ??
              gradientInitialPremiumHeader,
      gradientMiddlePremiumHeader:
          Color.lerp(gradientMiddlePremiumHeader, other?.gradientMiddlePremiumHeader, t) ??
              gradientMiddlePremiumHeader,
      transparent: Color.lerp(transparent, other?.transparent, t) ?? transparent,
      borderAlert: Color.lerp(borderAlert, other?.borderAlert, t) ?? borderAlert,
      borderLabel: Color.lerp(borderLabel, other?.borderLabel, t) ?? borderLabel,
      borderGlass: Color.lerp(borderGlass, other?.borderGlass, t) ?? borderGlass,
      borderButton: Color.lerp(borderButton, other?.borderButton, t) ?? borderButton,
      fillSecondary: Color.lerp(fillSecondary, other?.fillSecondary, t) ?? fillSecondary,
      textPremiumStart:
          Color.lerp(textPremiumStart, other?.textPremiumStart, t) ?? textPremiumStart,
      textPremiumEnd: Color.lerp(textPremiumEnd, other?.textPremiumEnd, t) ?? textPremiumEnd,
      textPremiumPlusStart:
          Color.lerp(textPremiumPlusStart, other?.textPremiumPlusStart, t) ?? textPremiumPlusStart,
      textPremiumPlusEnd:
          Color.lerp(textPremiumPlusEnd, other?.textPremiumPlusEnd, t) ?? textPremiumPlusEnd,
    );
  }
}
