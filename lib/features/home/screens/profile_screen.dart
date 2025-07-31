import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rumo/core/asset_images.dart';
import 'package:rumo/features/onboarding/routes/onboarding_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Perfil",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1E1E),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.maxFinite,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xFFF5F5F5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Image.asset(AssetImages.profileAvatar),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32, bottom: 32),
                      child: Text(
                        'Toque para alterar a foto',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2C2C2C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 17),
            Column(
              spacing: 8,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nome:',
                    hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Color(0xFF767676),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    enabled: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Cidade:',
                    hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Color(0xFF767676),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    enabled: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.maxFinite,
              child: OutlinedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => BottomSheet(
                      constraints: BoxConstraints.expand(
                        width: double.maxFinite,
                        height: 261,
                      ),
                      onClosing: () {},
                      builder: (context) => Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 24,
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Sair da conta',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF303030),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                        GestureDetector(
                                          onTap: () => Navigator.of(context).pop(),
                                          child: Icon(Icons.close),
                                        ),
                                      
                                    ],
                                  ),

                                  
                                ],
                              ),
                            ),

                            SizedBox(height: 16),
                            Text(
                              'Tem certeza que deseja sair?',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF757575),
                              ),
                            ),
                            SizedBox(height: 32),
                            SizedBox(
                              width: double.maxFinite,
                              child: FilledButton(
                                onPressed: () {},
                                child: Text(
                                  'Permanecer na minha conta',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Center(
                              child: TextButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  if (context.mounted) {
                                    // (_) => false fecha todas as telas
                                    Navigator.popUntil(context, (_) => false);
                                    Navigator.pushNamed(
                                      context,
                                      OnboardingRoutes.onboardingScreen,
                                    );
                                  }
                                },
                                child: Text(
                                  'Sair da minha conta',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFEE443F),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Text(
                  "Sair",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4E61F6),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
