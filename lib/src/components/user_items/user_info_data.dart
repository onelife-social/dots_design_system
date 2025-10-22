import 'package:flutter/material.dart';

class UserInfoData {
  /// The image provider to display the profile image.
  final ImageProvider? imageProvider;

  /// Text to display in the alias image.
  final String? aliasLabelImageText;

  /// The name of the user to display in the component.
  final String name;

  /// The details to display in the component.
  final String? details;

  /// Callback for image load error.
  final void Function(Object exception, StackTrace? stackTrace)? imageOnError;

  const UserInfoData({
    this.imageProvider,
    this.aliasLabelImageText,
    required this.name,
    this.details,
    this.imageOnError,
  });
}

enum MemberType {
  creator,
  admin,
  friend,
  alias,
  ;

  bool get isCreator => this == MemberType.creator;
  bool get isAdmin => this == MemberType.admin;
  bool get isFriend => this == MemberType.friend;
  bool get isAlias => this == MemberType.alias;
}

class MemberInfo {
  /// The unique identifier of the user.
  final String? id;

  /// The user information data.
  final UserInfoData userInfoData;

  /// The type of user.
  final MemberType memberType;

  const MemberInfo({
    this.id,
    required this.userInfoData,
    required this.memberType,
  });
}
