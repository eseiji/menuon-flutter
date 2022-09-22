import 'package:flutter/material.dart';

class TitlePriceRating extends StatelessWidget {
  final String preco;
  final String nome;
  final dynamic tamanho;
  const TitlePriceRating({
    Key? key,
    required this.preco,
    required this.nome,
    required this.tamanho,
  }) : super(key: key);

  String formatSize(dynamic size) {
    String result;
    if (num.tryParse('$size') != null) {
      if (size >= 1000 && size > 0) {
        size = (size / 1000).round();
        result = "${size}L";
      } else if (size > 0 && size < 1000) {
        result = "${tamanho}ml";
      } else {
        result = nome;
      }
    } else {
      result = "$tamanho";
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    nome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formatSize(tamanho),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          priceTag(context, preco),
        ],
      ),
    );
  }

  ClipPath priceTag(BuildContext context, String price) {
    return ClipPath(
      clipper: PricerCliper(),
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(vertical: 15),
        height: 66,
        width: 65,
        color: Color(0xFF5767FE),
        // color: Colors.white,
        child: Text(
          "R\$ $price",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class PricerCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double ignoreHeight = 20;
    path.lineTo(0, size.height - ignoreHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - ignoreHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
