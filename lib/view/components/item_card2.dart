import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../models/ProductMenu.dart';

class ItemCard extends StatelessWidget {
  final Product? product;
  final Function()? press;
  const ItemCard({
    Key? key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF252A34),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(kDefaultPaddin),
                // For  demo we use fixed height  and width
                // Now we dont need them
                // height: 180,
                // width: 160,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  // color: product!.color,
                  // borderRadius: BorderRadius.circular(16),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Hero(
                  tag: "${product!.id}",
                  child: Image.asset(product!.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kDefaultPaddin / 4,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // products is out demo list
                    product!.title,
                    style: TextStyle(color: kTextLightColor),
                  ),
                  Text(
                    "\$${product!.price}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
