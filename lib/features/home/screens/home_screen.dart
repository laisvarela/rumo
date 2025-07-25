import 'package:flutter/material.dart';
import 'package:rumo/features/onboarding/routes/onboarding_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
              title: Text('Home Page'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),

            SizedBox(
              width: double.maxFinite,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    OnboardingRoutes.onboardingScreen,
                  );
                },
                child: Text('Sair'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
