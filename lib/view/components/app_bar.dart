import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void signout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();

  Navigator.of(context).pushNamed('/login');
}

AppBar appBar(context) {
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
              // color: Color.fromARGB(255, 255, 255, 255),
              color: Color(0xFF5767FE),
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          )
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () => signout(context),
        icon: Icon(Icons.logout_rounded),
      ),
      IconButton(
        onPressed: () => Get.toNamed('/cart'),
        icon: Icon(Icons.shopping_basket_rounded),
      )
    ],
  );
}
