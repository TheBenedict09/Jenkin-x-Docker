import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;

  const AuthUser({required this.isEmailVerified});

  // Factory is a constructor
  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified);

  static firebase() {}
}
