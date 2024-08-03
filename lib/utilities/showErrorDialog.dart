import 'package:flutter/material.dart';

Future<bool> onError(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK')),
        ],
      );
    },
  ).then((value) => value ?? false);
}