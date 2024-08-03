// ignore: file_names
import 'package:fapp3/constants/routes.dart';
import 'package:fapp3/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Verify_Email extends StatefulWidget {
  const Verify_Email({super.key});

  @override
  State<Verify_Email> createState() => _Verify_EmailState();
}

// ignore: camel_case_types
class _Verify_EmailState extends State<Verify_Email> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: Column(
          children: [
            const Text('We\'ve have sent a verification email.'),
            const Text('If not received?'),
            FloatingActionButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailverification();
              },
              child: const Text('Send Verification email again'),
            ),
            TextButton(
              onPressed: () {
                AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text('Restart'),
            )
          ],
        ),
      ),
    );
  }
}
