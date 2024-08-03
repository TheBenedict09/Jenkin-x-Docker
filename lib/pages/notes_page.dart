import 'package:fapp3/constants/routes.dart';
import 'package:fapp3/enums/menu_action.dart';
import 'package:fapp3/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Notes_View extends StatefulWidget {
  const Notes_View({super.key});

  @override
  State<Notes_View> createState() => _Notes_ViewState();
}

// ignore: camel_case_types
class _Notes_ViewState extends State<Notes_View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final selected = await showLogOutDialog(context);
                  if (selected) {
                    await AuthService.firebase().logOut();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                    value: MenuAction.logout, child: Text('LogOut'))
              ];
            },
          )
        ],
      ),
      body: const Text('Hello World!!!'),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to Log Out'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Log Out'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
