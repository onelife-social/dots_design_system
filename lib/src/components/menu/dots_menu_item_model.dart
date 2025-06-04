import 'package:dots_design_system/dots_design_system.dart';

class DotsMenuItemModel<T> {
  final T id;
  final String label;
  final String? details;
  final DotsIconData? icon;
  final bool selected;
  final bool isDelete;
  final List<DotsMenuItemModel> subItems;
  final Function()? onTap;

  DotsMenuItemModel({
    required this.id,
    required this.label,
    this.details,
    this.icon,
    this.selected = false,
    this.isDelete = false,
    this.subItems = const [],
    this.onTap,
  });

  DotsMenuItemModel copyWith({
    T? id,
    String? label,
    String? details,
    DotsIconData? icon,
    bool? selected,
    bool? isDelete,
    List<DotsMenuItemModel>? subItems,
    Function()? onTap,
  }) {
    return DotsMenuItemModel(
      id: id ?? this.id,
      label: label ?? this.label,
      details: details ?? this.details,
      icon: icon ?? this.icon,
      selected: selected ?? this.selected,
      isDelete: isDelete ?? this.isDelete,
      subItems: subItems ?? this.subItems,
      onTap: onTap ?? this.onTap,
    );
  }
}
