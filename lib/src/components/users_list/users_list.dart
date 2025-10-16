import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  final UsersItemList creator;
  final List<UsersItemList> users;
  final List<UsersItemList> aliases;

  const UsersList({
    super.key,
    required this.creator,
    required this.users,
    required this.aliases,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final items = <Widget>[
      UsersItemList.label(
        data: creator.data,
        label: creator.label,
      ),
      for (final u in users)
        UsersItemList.main(
          data: u.data,
          onTap: u.onTap!,
        ),
      for (final a in aliases)
        UsersItemList.main(
          data: a.data,
          onTap: a.onTap!,
        ),
      // _AddParticipantButton(),
      // _AddFriendButton(),
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
