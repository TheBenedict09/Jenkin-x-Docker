import 'package:fapp3/constants/routes.dart';
import 'package:fapp3/services/auth/auth_exceptions.dart';
import 'package:fapp3/services/auth/auth_service.dart';
import 'package:fapp3/utilities/showErrorDialog.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.title});

  final String title;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _password;
  late TextEditingController _email;
  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(hintText: 'Enter Email'),
          ),
          TextField(
            controller: _password,
            enableSuggestions: false,
            obscureText: true,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter Password'),
          ),
          TextButton(
              onPressed: () async {
                try {
                  final email = _email.text;
                  final password = _password.text;
                  await AuthService.firebase()
                      .createUser(email: email, password: password);
                  Navigator.of(context).pushNamed(verifyEmail);
                  AuthService.firebase().sendEmailverification();
                } on WeakPasswordAuthException {
                  // ignore: use_build_context_synchronously
                  await onError(context, 'Weak Password');
                } on EmailAlreadyInUseAuthException {
                  // ignore: use_build_context_synchronously
                  await onError(context, 'Email already in use');
                } on GenericAuthException {
                  // ignore: use_build_context_synchronously
                  await onError(context, "Failed to register");
                }
              },
              child: const Text('Register')),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, loginRoute, (route) => false);
              },
              child: const Text('Already Registered? Go to Login Page'))
        ],
      ),
    );
  }
}
