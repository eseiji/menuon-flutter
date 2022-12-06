import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final String? imgSrc;
  const ItemImage({
    Key? key,
    required this.imgSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0), // Image border
          child: Image.network(
            "https://$imgSrc",
            width: 180,
          ),
        )
        //     ClipRRect(
        //   borderRadius: BorderRadius.circular(80.0),
        //   child: Image.network(
        //     "https://${imgSrc}",
        //     height: size.height * 0.25,
        //     width: double.infinity,
        //     fit: BoxFit.fitHeight,
        //   ),
        // ),
        //     Image.network(
        //   "https://${imgSrc}",
        //   height: size.height * 0.25,
        //   width: double.infinity,
        //   // fit: BoxFit.fill,
        // ),
        );
  }
}
