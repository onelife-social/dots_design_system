import 'package:animate_do/animate_do.dart';
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
  final String? textfieldLabel;

  /// Controllers for the participant text fields.
  final Map<String, TextEditingController>? textControllers;

  /// Focus nodes for the participant text fields.
  final Map<String, FocusNode>? focusNodes;

  /// Callback for text changes in the participant text fields.
  final void Function(String?, String?)? textOnChanged;

  /// Label for the "add participant" button.
  final String? addParticipantLabel;

  /// Callback when the "add participant" button is tapped.
  final void Function(String?)? addParticipantOnTap;

  /// Label for the "add friend" button.
  final String? addFriendLabel;

  /// Callback when the "add friend" button is tapped.
  final void Function(String?)? addFriendOnTap;

  /// Whether to show the "add friend" button.
  final bool showAddFriendButton;

  /// Whether to apply the bounce in animation to text fields.
  final bool applyBounceIn;

  /// Whether the initialmembers can be modified.
  final bool canModifyMembers;

  /// Whether to autofocus on empty textfield.
  final bool autofocusOnEmpty;

  const UsersList({
    super.key,
    required this.members,
    required this.creatorLabel,
    required this.adminLabel,
    this.memberOnTap,
    this.textfieldLabel,
    this.textControllers,
    this.focusNodes,
    this.textOnChanged,
    this.addParticipantLabel,
    this.addParticipantOnTap,
    this.addFriendLabel,
    this.addFriendOnTap,
    this.showAddFriendButton = false,
    this.applyBounceIn = false,
    this.canModifyMembers = false,
    this.autofocusOnEmpty = true,
  });

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    if (widget.members.isEmpty) {
      return const SizedBox.shrink();
    }

    final items = List.generate(widget.members.length, (index) {
      final member = widget.members[index];

      // Creator
      if (index == 0) {
        return UsersItemList.label(
          id: member.id!,
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
            id: member.id!,
            data: member.userInfoData,
            label: widget.adminLabel,
            onTap: widget.memberOnTap,
          );

        // Friends
        case MemberType.friend:
          return UsersItemList.main(
            id: member.id!,
            data: member.userInfoData,
            onTap: widget.memberOnTap,
          );

        case MemberType.member:
          if (widget.canModifyMembers) {
            return UsersItemList.join(
              id: member.id!,
              data: member.userInfoData,
              onTap: widget.memberOnTap,
              iconSize: 22,
            );
          } else {
            return UsersItemList.basic(id: member.id!, data: member.userInfoData);
          }

        case MemberType.existingAlias:
          return UsersItemList.existingAlias(id: member.id!, data: member.userInfoData);

        // Aliases
        case MemberType.alias:
          final textController =
              widget.textControllers?[member.id] ??
              TextEditingController(text: member.userInfoData.name);
          if (widget.textControllers?[member.id] != null) {
            textController.text = member.userInfoData.name;
          }

          return UsersItemList.textfield(
            id: member.id!,
            label: widget.textfieldLabel ?? '',
            textController: textController,
            onTap: widget.memberOnTap,
            textOnChanged: widget.textOnChanged,
            focusNode: widget.focusNodes?[member.id],
            autofocusOnEmpty: widget.autofocusOnEmpty,
          );
      }
    });

    items.addAll([
      // Add new participant button
      if ((widget.addParticipantLabel?.isNotEmpty ?? false) && widget.addParticipantOnTap != null)
        UsersItemList.button(
          label: widget.addParticipantLabel!,
          icon: DotsIconData.add,
          onTap: widget.addParticipantOnTap,
        ),

      // Add new friend button
      if (widget.showAddFriendButton &&
          (widget.addFriendLabel?.isNotEmpty ?? false) &&
          widget.addFriendOnTap != null)
        UsersItemList.button(
          label: widget.addFriendLabel!,
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
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: items.length,
        separatorBuilder: (_, __) => DotsDivider(),
        itemBuilder: (_, index) {
          final item = items[index];
          return widget.applyBounceIn &&
                  item is UsersItemList &&
                  item.variant == UserItemListVariant.textfield &&
                  (item.textController?.text.trim().isEmpty ?? true)
              ? BounceIn(duration: const Duration(milliseconds: 1000), child: item)
              : item;
        },
      ),
    );
  }
}
