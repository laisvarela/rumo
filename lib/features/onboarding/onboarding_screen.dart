import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rumo/core/asset_images.dart';
import 'package:rumo/features/auth/routes/auth_routes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Box que fica contido os botões
      bottomSheet: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              // Botão Criar conta
              SizedBox(
                width: double.maxFinite,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AuthRoutes.createAccount);
                  },
                  child: Text(
                    'Criar conta',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // Botão Entrar
              SizedBox(
                width: double.maxFinite,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AuthRoutes.login);
                  },
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Container que fica contido o logo e a imagem do personagem
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetImages.logo,
                width: 112,
                height: 44,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcATop),
              ),
              SizedBox(height: 52),
              Image.asset(AssetImages.onboardingCharacter),
            ],
          ),
        ),
      ),
    );
  }
}
