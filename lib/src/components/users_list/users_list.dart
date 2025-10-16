import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class UsersList extends StatefulWidget {
  /// The creator user item to display at the top of the list.
  final UsersItemList creator;

  /// The main list of user items.
  final List<UsersItemList> users;

  /// The list of alias user items.
  final List<UsersItemList> aliases;

  /// Label for the participant text field.
  final String textfieldLabel;

  /// Controller for the participant text field.
  final TextEditingController textController;

  /// Callback for text changes in the participant text field.
  final ValueChanged<String> textOnChanged;

  /// Label for the "add participant" button.
  final String addParticipantLabel;

  /// Label for the "add friend" button.
  final String addFriendLabel;

  /// Callback when the "add friend" button is tapped.
  final VoidCallback addFriendOnTap;

  const UsersList({
    super.key,
    required this.creator,
    required this.users,
    required this.aliases,
    required this.textfieldLabel,
    required this.textController,
    required this.textOnChanged,
    required this.addParticipantLabel,
    required this.addFriendLabel,
    required this.addFriendOnTap,
  });

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  bool showTextfield = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final items = <Widget>[
      // Creator
      UsersItemList.label(
        data: widget.creator.data!,
        label: widget.creator.label,
      ),

      // Users
      for (final u in widget.users)
        UsersItemList.main(
          data: u.data!,
          onTap: u.onTap!,
        ),

      // Aliases
      for (final a in widget.aliases)
        UsersItemList.main(
          data: a.data!,
          onTap: a.onTap!,
        ),

      // Textfield
      if (showTextfield)
        UsersItemList.textfield(
          label: widget.textfieldLabel,
          textController: widget.textController,
          textOnChanged: widget.textOnChanged,
          onTap: () => widget.textController.clear(),
        ),

      // Add new participant
      UsersItemList.button(
        label: widget.addParticipantLabel,
        icon: DotsIconData.add,
        onTap: () => setState(() => showTextfield = true),
      ),

      // Add new friend
      UsersItemList.button(
        label: widget.addFriendLabel,
        icon: DotsIconData.user,
        onTap: widget.addFriendOnTap,
      ),
    ];

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
