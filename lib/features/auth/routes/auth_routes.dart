import 'package:flutter/widgets.dart';
import 'package:rumo/features/auth/create_account/create_account_screen.dart';
import 'package:rumo/features/auth/login/login_screen.dart';

class AuthRoutes {
  static const String createAccount = '/create-account';
  static const String login = '/login';

  static final Map<String, Widget Function(BuildContext)> routes = {
    createAccount: (context) =>  CreateAccountScreen(),
    login: (context) => const LoginScreen(),
  };
}