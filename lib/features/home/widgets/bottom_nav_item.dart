import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavItem extends StatelessWidget {
  final String icon;
  final String label;
  final int currentSelectedIndex;
  final int index;
  final void Function(int index) onSelectItem; // função chamada quando o item é tocado
  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.currentSelectedIndex,
    required this.index,
    required this.onSelectItem,
    super.key,
  });

  // getter que retorna true se esse item for o selecionado
  bool get isSelected => currentSelectedIndex == index;

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).primaryColor;
    final inactiveColor = Color(0xFF757575);
    // InkWell detecta toques e mostra efeito visual
    return InkWell(
      // onTap chama a função e aplica bordas arredondas para o efeito do toque
      onTap: () => onSelectItem(index),
      borderRadius: BorderRadius.circular(24),
      // adiciona espaçamento e usa Column para empilhar ícone e texto verticalmente centralizados
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // renderiza o SVG com tamanho fixo e aplica cor
            SvgPicture.asset(
              icon,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                isSelected ? activeColor : inactiveColor,
                BlendMode.srcATop,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}