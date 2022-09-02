import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final String imgSrc;
  const ItemImage({
    Key? key,
    required this.imgSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child:
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(8), // Image border
          //   child: SizedBox.fromSize(
          //     size: Size.fromRadius(70), // Image radius
          //     child: Image.network("https://${imgSrc}"),
          //   ),
          // )
          Image.network(
        "https://${imgSrc}",
        height: size.height * 0.25,
        width: double.infinity,
        // it cover the 25% of total height
        // fit: BoxFit.fill,
      ),
    );
  }
}
