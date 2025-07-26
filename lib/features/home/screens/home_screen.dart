import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rumo/core/asset_images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          // spaceAround tenta adicionar os objetos em espaços iguais
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              child: BottomNavItem(
                icon: AssetImages.iconMap,
                label: 'Mapa',
                selected: currentIndex == 0,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              child: BottomNavItem(
                icon: AssetImages.iconDiary,
                label: 'Diários',
                selected: currentIndex == 1,
              ),
            ),
            IconButton.filled(
              onPressed: () {},
              icon: SvgPicture.asset(
                AssetImages.iconAdd,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(Color(0xFF4E61F6), BlendMode.srcATop),
              ),
              style: IconButton.styleFrom(backgroundColor: Color(0xFFDDE1FF)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 2;
                });
              },
              child: BottomNavItem(
                icon: AssetImages.iconCompass,
                label: 'Explorar',
                selected: currentIndex == 2,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 3;
                });
              },
              child: BottomNavItem(
                icon: AssetImages.iconProfile,
                label: 'Perfil',
                selected: currentIndex == 3,
              ),
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (context) {
          return switch (currentIndex) {
            1 => Center(child: Text('Diários')),
            2 => Center(child: Text('Explorar')),
            3 => Center(child: Text('Perfil')),
            _ => Center(child: Text('Mapa')),
          };
        },
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool selected;
  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? Color(0xFF4E61F6) : Color(0xFF757575);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}
