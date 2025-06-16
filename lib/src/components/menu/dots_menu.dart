import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsMenu<T> extends StatefulWidget {
  const DotsMenu({
    super.key,
    required this.mainItem,
    required this.subitems,
    this.defaultSelectedItemId,
  });

  /// Main item that will be displayed at the top of the menu.
  final DotsMenuItemModel<T> mainItem;

  /// List of subitems that will be displayed in the menu.
  final List<DotsMenuItemModel<T>> subitems;

  final T? defaultSelectedItemId;

  @override
  State<DotsMenu> createState() {
    return _DotsMenuState<T>();
  }
}

class _DotsMenuState<T> extends State<DotsMenu<T>> {
  List<DotsMenuItemModel<T>> stack = [];

  late DotsMenuItemModel<T> selectedItem;

  @override
  void initState() {
    selectedItem = widget.mainItem.copyWith(subItems: widget.subitems);
    selectDefaultItem();
    super.initState();
  }

  void selectDefaultItem() {
    final defaultItemId = widget.defaultSelectedItemId;
    final initialSelectedItem = selectedItem;
    if (defaultItemId == null || initialSelectedItem.id == defaultItemId) return;
    final stack = getStackByDefaultItemBySubitems(initialSelectedItem.subItems);
    if (stack.isNotEmpty) {
      selectedItem = stack.removeLast();
      this.stack = [initialSelectedItem, ...stack];
    }
  }

  List<DotsMenuItemModel<T>> getStackByDefaultItemBySubitems(List<DotsMenuItemModel<T>> subItems) {
    final defaultItemId = widget.defaultSelectedItemId;
    for (final item in subItems) {
      if (item.id == defaultItemId) {
        return [item];
      } else if (item.subItems.isNotEmpty) {
        final stack = getStackByDefaultItemBySubitems(item.subItems);
        if (stack.isNotEmpty) {
          return [item, ...stack];
        }
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 700),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            axisAlignment: -1,
            sizeFactor: animation,
            child: child,
          ),
        );
      },
      child: _DotsMenuContainer(
        key: ValueKey(selectedItem.id),
        isInitialItem: stack.isEmpty,
        mainItem: selectedItem,
        onTapMainItem: () {
          if (stack.isNotEmpty) {
            setState(() {
              selectedItem = stack.removeLast();
            });
          }
        },
        onTapItem: (DotsMenuItemModel<T> item) {
          if (item.subItems.isNotEmpty) {
            setState(() {
              stack.add(selectedItem);
              selectedItem = item;
            });
          }
        },
      ),
    );
  }
}

class _DotsMenuContainer<T> extends StatelessWidget {
  const _DotsMenuContainer({
    super.key,
    required this.isInitialItem,
    required this.mainItem,
    required this.onTapItem,
    required this.onTapMainItem,
  });
  final bool isInitialItem;
  final DotsMenuItemModel<T> mainItem;

  final Function() onTapMainItem;
  final Function(DotsMenuItemModel<T> item) onTapItem;
  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Container(
      width: 204,
      padding: EdgeInsets.all(8.0),
      decoration:
          BoxDecoration(color: theme.colors.bgBaseContrast, borderRadius: DotsBorderRadius.r20),
      child: _MenuContainerScrollable(
          isScrollable: mainItem.subItems.length > 7,
          header: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MenuItem(
                item: mainItem,
                isExpanded: true,
                onTapItem: () {
                  onTapMainItem();
                },
                isInitialItem: isInitialItem,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Divider(
                  height: 4,
                  color: theme.colors.labelSecondary,
                  indent: 8,
                  endIndent: 8,
                  thickness: 0.5,
                ),
              ),
            ],
          ),
          list: Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: mainItem.subItems
                  .map(
                    (item) => _MenuItem(
                      item: item,
                      isExpanded: false,
                      onTapItem: () {
                        onTapItem(item);
                      },
                    ),
                  )
                  .toList())),
    );
  }
}

class _MenuContainerScrollable extends StatelessWidget {
  const _MenuContainerScrollable(
      {required this.isScrollable, required this.header, required this.list});

  final bool isScrollable;
  final Widget header;
  final Widget list;

  @override
  Widget build(BuildContext context) {
    if (isScrollable) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 336),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            header,
            Expanded(child: SingleChildScrollView(child: list)),
          ],
        ),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          header,
          list,
        ],
      );
    }
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem(
      {required this.item,
      required this.isExpanded,
      required this.onTapItem,
      this.isInitialItem = false});
  final DotsMenuItemModel item;
  final bool isExpanded;
  final bool isInitialItem;
  final Function() onTapItem;

  DotsIconData? get leftIcon {
    if (item.selected) {
      return DotsIconData.check;
    }
    if (item.subItems.isNotEmpty && !isInitialItem) {
      if (isExpanded) {
        return DotsIconData.chevronDown;
      }
      return DotsIconData.chevronRight;
    }
    return null;
  }

  Color? iconColorOverride(DotsTheme theme) {
    if (item.isDelete) {
      return theme.colors.labelDestructive;
    }
    if (item.selected) {
      return theme.colors.labelHighlight;
    }
    return null;
  }

  Color? textColorOverride(DotsTheme theme) {
    if (item.isDelete) {
      return theme.colors.labelDestructive;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final leftIcon = this.leftIcon;
    final rightIcon = item.icon;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: DotsBorderRadius.r12,
        highlightColor: theme.colors.bgContainerSecondary,
        splashColor: theme.colors.bgContainerSecondary,
        focusColor: theme.colors.bgContainerSecondary,
        onTap: () {
          item.onTap?.call();
          onTapItem();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: DotsBorderRadius.r12,
          ),
          padding: EdgeInsets.all(8.0)
              .add(item.details != null ? EdgeInsets.only(bottom: 2) : EdgeInsets.zero),
          child: Row(
            spacing: 6,
            children: [
              leftIcon != null
                  ? DotsIcon(
                      iconData: leftIcon,
                      size: 14,
                      color: iconColorOverride(theme) ?? theme.colors.textPrimary,
                    )
                  : SizedBox(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.label,
                      style: theme.typo.main.labelSmallMedium
                          .copyWith(color: textColorOverride(theme)),
                    ),
                    if (item.details != null)
                      Text(
                        item.details!,
                        style: theme.typo.main.labelSmallRegular
                            .copyWith(color: textColorOverride(theme) ?? theme.colors.textTertiary),
                      ),
                  ],
                ),
              ),
              rightIcon != null
                  ? DotsIcon(
                      iconData: rightIcon,
                      size: 16,
                      color: iconColorOverride(theme) ?? theme.colors.labelPrimary,
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
