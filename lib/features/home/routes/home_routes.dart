import 'package:flutter/widgets.dart';
import 'package:rumo/features/home/screens/home_screen.dart';
import 'package:rumo/features/home/screens/profile_screen.dart';

class HomeRoutes {
  static const String homeScreen = '/home';
  static const String profileScreen= '/profile';

  static final Map<String, Widget Function(BuildContext)> routes = {
    homeScreen: (context) => const HomeScreen(),
    profileScreen: (context) => const ProfileScreen(),
  };
}
