import 'package:flutter/material.dart';
/* import 'package:shop_app/models/Cart.dart'; */

/* import '../../../constants.dart'; */

import '../../models/Cart.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF252A34),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(cart.product.images[0]),
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cart.product.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\$${cart.product.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: " x${cart.numOfItem}",
                      style: TextStyle(
                          color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
