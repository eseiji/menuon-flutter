import 'package:flutter/material.dart';

AppBar appBar() {
  return AppBar(
    backgroundColor: const Color(0xff181920),
    elevation: 2,
    centerTitle: true,
    title: RichText(
      text: const TextSpan(
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: 'MENU ON',
            style: TextStyle(
              color: Color(0xFF5767FE),
            ),
          )
        ],
      ),
    ),
    actions: [
      IconButton(onPressed: () {}, icon: Icon(Icons.shopping_basket_rounded))
    ],
  );
}
