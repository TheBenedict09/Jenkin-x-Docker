import 'package:fapp3/constants/routes.dart';
import 'package:fapp3/services/auth/auth_exceptions.dart';
import 'package:fapp3/services/auth/auth_service.dart';
import 'package:fapp3/utilities/showErrorDialog.dart';
import 'package:flutter/material.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.title});

  final String title;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('Login'),
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
                final email = _email.text;
                final password = _password.text;
                try {
                  await AuthService.firebase()
                      .logIn(email: email, password: password);
                  // ignore: use_build_context_synchronously
                  final user = AuthService.firebase().currentUser;
                  if (user?.isEmailVerified ?? false) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute,
                      (route) => false,
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmail,
                      (route) => false,
                    );
                  }
                } on InvalidEmailAuthException {
                   // ignore: use_build_context_synchronously
                   await onError(
                      context,
                      'Invalid Credentials',
                    );
                }
                on WrongPasswordAuthException{
                   // ignore: use_build_context_synchronously
                   await onError(
                      context,
                      'Wrong Password',
                    );
                }
                on GenericAuthException{
                   // ignore: use_build_context_synchronously
                   await onError(
                      context,
                      'Authentication error',
                    );
                }
                 
              },
              child: const Text('Login')),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, registerRoute, (route) => false);
            },
            child: const Text('Not Registered? Click here...'),
          )
        ],
      ),
    );
  }
}
