import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class UsersList extends StatefulWidget {
  /// The list of all members information.
  final List<MemberInfo> members;

  /// Label for the creator item.
  final String creatorLabel;

  /// Label for the admin item.
  final String adminLabel;

  /// Callback when a friend item is tapped.
  final void Function(String?)? memberOnTap;

  /// Label for the participant text fields.
  final String textfieldLabel;

  /// Controllers for the participant text fields.
  final List<TextEditingController> textControllers;

  /// Callback for text changes in the participant text fields.
  final void Function(String?) textOnFocusLost;

  /// Label for the "add participant" button.
  final String addParticipantLabel;

  /// Callback when the "add participant" button is tapped.
  final void Function(String?) addParticipantOnTap;

  /// Label for the "add friend" button.
  final String addFriendLabel;

  /// Callback when the "add friend" button is tapped.
  final void Function(String?) addFriendOnTap;

  const UsersList({
    super.key,
    required this.members,
    required this.creatorLabel,
    required this.adminLabel,
    required this.memberOnTap,
    required this.textfieldLabel,
    required this.textControllers,
    required this.textOnFocusLost,
    required this.addParticipantLabel,
    required this.addParticipantOnTap,
    required this.addFriendLabel,
    required this.addFriendOnTap,
  });

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    int textfieldIndex = 0;
    final items = List.generate(widget.members.length, (index) {
      final member = widget.members[index];

      // Creator
      if (index == 0) {
        return UsersItemList.label(
          data: member.userInfoData,
          label: widget.creatorLabel,
        );
      }

      switch (member.memberType) {
        case MemberType.creator:
          return const Offstage(); // This case is already handled above

        // Admin
        case MemberType.admin:
          return UsersItemList.label(
            data: member.userInfoData,
            label: widget.adminLabel,
          );

        // Friends
        case MemberType.friend:
          return UsersItemList.main(
            id: member.id!,
            data: member.userInfoData,
            onTap: widget.memberOnTap!,
          );

        // Aliases
        case MemberType.alias:
          textfieldIndex++;
          final controller = widget.textControllers[textfieldIndex - 1]
            ..text = member.userInfoData.name;

          return UsersItemList.textfield(
            id: member.id!,
            label: widget.textfieldLabel,
            textController: controller,
            onTap: widget.memberOnTap!,
            onFocusLost: widget.textOnFocusLost,
          );
      }
    });

    if (widget.members.length > 1) {
      final int numAliases = widget.members.where((m) => m.memberType == MemberType.alias).length;
      items.addAll([
        // Possible textfields
        for (int i = textfieldIndex; i <= widget.textControllers.length - numAliases; i++)
          UsersItemList.textfield(
            id: null,
            label: widget.textfieldLabel,
            textController: widget.textControllers[i],
            onTap: widget.memberOnTap!,
            onFocusLost: widget.textOnFocusLost,
          ),
      ]);
    }

    items.addAll([
      // Add new participant button
      UsersItemList.button(
        label: widget.addParticipantLabel,
        icon: DotsIconData.add,
        onTap: widget.addParticipantOnTap,
      ),

      // Add new friend button
      UsersItemList.button(
        label: widget.addFriendLabel,
        icon: DotsIconData.user,
        onTap: widget.addFriendOnTap,
      ),
    ]);

    return Container(
      decoration: BoxDecoration(
        color: theme.colors.bgContainerSecondaryOnBackground,
        borderRadius: BorderRadius.circular(26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: items.length,
        separatorBuilder: (_, __) => Divider(
          color: theme.colors.labelSecondary.dotsWithOpacity(0.3),
          thickness: 0.2,
        ),
        itemBuilder: (_, index) => items[index],
      ),
    );
  }
}
