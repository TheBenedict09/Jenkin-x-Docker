import 'package:fapp3/services/auth/firebase_auth_provider.dart';

import 'auth_provider.dart';
import 'auth_user.dart';

class AuthService extends AuthProvider {
  final AuthProvider provider;

  AuthService({required this.provider});

  factory AuthService.firebase() =>
      AuthService(provider: FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailverification() => provider.sendEmailverification();

  @override
  Future<void> initialize() => provider.initialize();
}
