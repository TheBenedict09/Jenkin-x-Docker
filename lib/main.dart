import 'package:fapp3/constants/routes.dart';
import 'package:fapp3/pages/Verify_Email.dart';
import 'package:fapp3/pages/loginpage.dart';
import 'package:fapp3/pages/notes_page.dart';
import 'package:fapp3/pages/registerpage.dart';
import 'package:fapp3/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'dart:developer' as devtools show log;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        loginRoute: (context) => const LoginView(title: ""),
        registerRoute: (context) => const RegisterView(title: ""),
        notesRoute: (context) => const Notes_View(),
        verifyEmail: (context) => const Verify_Email(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  devtools.log('Email is verified');
                  return const Notes_View();
                } else {
                  devtools.log(user.toString());
                  return const Verify_Email();
                }
              } else {
                return const RegisterView(title: " ");
              }

            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
