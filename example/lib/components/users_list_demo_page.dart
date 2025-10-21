import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class UsersListStory extends StatefulWidget {
  const UsersListStory({super.key});

  @override
  State<UsersListStory> createState() => _UsersListStoryState();
}

class _UsersListStoryState extends State<UsersListStory> {
  final List<MemberInfo> members = [];
  final Map<String, TextEditingController> textControllers = {};
  final Map<String, FocusNode> focusNodes = {};

  @override
  void initState() {
    super.initState();

    members.addAll([
      MemberInfo(
        userInfoData: UserInfoData(
          imageProvider: NetworkImage('https://picsum.photos/250?image=1'),
          name: 'Carlos',
        ),
        memberType: MemberType.creator,
      ),
      MemberInfo(
        userInfoData: UserInfoData(
          imageProvider: NetworkImage('https://picsum.photos/250?image=2'),
          name: 'Admin 1',
        ),
        memberType: MemberType.admin,
      ),
      MemberInfo(
        userInfoData: UserInfoData(
          imageProvider: NetworkImage('https://picsum.photos/250?image=3'),
          name: 'Admin 2',
        ),
        memberType: MemberType.admin,
      ),
      MemberInfo(
        id: '1',
        userInfoData: UserInfoData(
          imageProvider: NetworkImage('https://picsum.photos/250?image=4'),
          name: 'Ana Orduña',
          details: 'Amigo de Dots',
        ),
        memberType: MemberType.friend,
      ),
      MemberInfo(
        id: '2',
        userInfoData: UserInfoData(
          imageProvider: NetworkImage('https://picsum.photos/250?image=5'),
          name: 'Carlitos',
          details: 'Amigo de Dots',
        ),
        memberType: MemberType.friend,
      ),
      MemberInfo(
        id: '9999',
        userInfoData: UserInfoData(
          name: 'Andrea',
        ),
        memberType: MemberType.alias,
      ),
      MemberInfo(
        id: '3',
        userInfoData: UserInfoData(
          imageProvider: NetworkImage('https://picsum.photos/250?image=6'),
          name: 'Esther',
          details: 'Amigo de Dots',
        ),
        memberType: MemberType.friend,
      ),
    ]);

    for (final m in members.where((m) => m.memberType == MemberType.alias)) {
      final aliasId = m.id ?? tempId();
      textControllers[aliasId] = TextEditingController(text: m.userInfoData.name);
      focusNodes[aliasId] = FocusNode();
    }
  }

  String tempId() => DateTime.now().microsecondsSinceEpoch.toString();

  @override
  void dispose() {
    for (final c in textControllers.values) {
      c.dispose();
    }
    for (final f in focusNodes.values) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UsersList(
      members: members,
      creatorLabel: 'Creador',
      adminLabel: 'Admin',
      memberOnTap: (id) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Friend tapped: $id')),
        );
      },
      textfieldLabel: 'Nombre del participante...',
      textControllers: textControllers,
      focusNodes: focusNodes,
      textOnChanged: (id, value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Alias changed: $id -> $value')),
        );
      },
      addParticipantLabel: 'Añadir otro participante',
      addParticipantOnTap: (id) {
        if (textControllers.values.any((controller) => controller.text.trim().isEmpty)) return;

        final newId = tempId();
        setState(() {
          textControllers[newId] = TextEditingController(text: '');

          members.add(
            MemberInfo(
              id: newId,
              userInfoData: UserInfoData(name: ''),
              memberType: MemberType.alias,
            ),
          );
        });
      },
      addFriendLabel: 'Añadir amigo de Dots',
      addFriendOnTap: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped add friend')),
        );
      },
      showAddFriendButton: true,
    );
  }
}
