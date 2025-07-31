import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavItem extends StatelessWidget {
  final String icon;
  final String label;
  final int index;
  final bool selected;
  final void Function(int index) onSelectItem;
  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.onSelectItem,
    required this.selected,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    /*final activeColor = Theme.of(context).primaryColor;
    //final inactiveColor = Color(0xFF757575);*/
    final color = selected ? Color(0xFF4E61F6) : Color(0xFF757575);
    return InkWell(
      onTap: () => onSelectItem(index),
      // borda da sombra
      borderRadius: BorderRadius.circular(24),
      // padding para a sombra
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
        ),
      ),
    );
  }
}
