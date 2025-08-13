import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rumo/core/asset_images.dart';

class StarRating extends StatefulWidget {
  // função callback será chamada sempre que o usário mudar a nota
  final void Function(double rating) onRatingChanged;

  const StarRating({required this.onRatingChanged, super.key});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  final double size = 32; // tamanho da estrela
  double rating = 0; // nota de 0 a 5

  // essa função atualiza o estado com a nova nota e chama o callback para informar ao widget pai
  void setRating(double newRating) {
    setState(() {
      rating = newRating;
    });
    widget.onRatingChanged(rating);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = []; // lista de estrelas que será exibida na tela
    // loop para gerar as 5 estrelas
    for (var i = 1; i <= 5; i++) {
      // cada estrela é envolvida por um GestureDetector para detectar toques
      stars.add(
        GestureDetector(
          // onTapDown está detectando se o toque foi na esquerda ou direita da estrela
          onTapDown: (details) {
            double dx = details.localPosition.dx;
            double half = size / 2;
            if (dx <= half) {
              setRating(i - 0.5); // esquerda = metade da estrala
            } else {
              setRating(i.toDouble()); // direita = estrela cheia
            }
          },
          // cria uma animação suave
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: rating),
            duration: Duration(milliseconds: 150),
            // builder decide qual ícone usar de acordo com o valor
            builder: (context, value, _) {
              String asset = AssetImages.iconStar;
              if (value >= i) {
                asset = AssetImages.iconStar;
              } else if (value >= i - 0.5) {
                asset = AssetImages.iconHalfStar;
              } else {
                asset = AssetImages.iconStar;
              }
              // renderiza o SVG da estrela com cor amarela se estiver preenchida (value >= i) ou sem cor se estiver vazia
              return SvgPicture.asset(
                asset,
                width: size,
                height: size,
                colorFilter: value >= i
                    ? ColorFilter.mode(Color(0xFFFFCB45), BlendMode.srcIn)
                    : null,
              );
            },
          ),
        ),
      );
    }
    // exibe as estrelas em uma linha centralizada
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: stars);
  }
}