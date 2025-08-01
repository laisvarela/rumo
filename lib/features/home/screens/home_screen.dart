import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rumo/core/asset_images.dart';
import 'package:rumo/features/diary/screens/diary_screen.dart';
import 'package:rumo/features/user/screens/profile_screen.dart';
import 'package:rumo/features/home/widgets/bottom_nav_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  void onSelectItem(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /*bottomNavigationBar: BottomNavigationBar(
        // currentIndex indica qual item está selecionado no momento
        currentIndex: currentIndex,
        // onTap é chamado quando o usuário toca em um item da barra
        // onTap recebe o índice do item tocado.
        onTap: (index) {
          // setState atualiza a variável currentIndex com o novo índice
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined, size: 20),
            label: 'Mapa',
          ),
        ],
      ),*/
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFF3F3F3), width: 1)),
        ),
        child: BottomAppBar(
          color: Colors.white,
          child: Row(
            // spaceAround tenta adicionar os objetos em espaços iguais
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BottomNavItem(
                icon: AssetImages.iconMap,
                label: 'Mapa',
                index: 0,
                selected: currentIndex == 0,
                onSelectItem: onSelectItem,
              ),

              BottomNavItem(
                icon: AssetImages.iconDiary,
                label: 'Diários',
                index: 1,
                selected: currentIndex == 1,
                onSelectItem: onSelectItem,
              ),

              IconButton.filled(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AssetImages.iconAdd,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    Color(0xFF4E61F6),
                    BlendMode.srcATop,
                  ),
                ),
                style: IconButton.styleFrom(backgroundColor: Color(0xFFDDE1FF)),
              ),

              BottomNavItem(
                icon: AssetImages.iconCompass,
                label: 'Explorar',
                index: 2,
                selected: currentIndex == 2,
                onSelectItem: onSelectItem,
              ),

              BottomNavItem(
                icon: AssetImages.iconProfile,
                label: 'Perfil',
                index: 3,
                selected: currentIndex == 3,
                onSelectItem: onSelectItem,
              ),
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          return switch (currentIndex) {
            1 => DiariesScreen(),
            2 => Center(child: Text('Explorar')),
            3 => ProfileScreen(),
            _ => Center(child: Text('Mapa')),
          };
        },
      ),
    );
  }
}
