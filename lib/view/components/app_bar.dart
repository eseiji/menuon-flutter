import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_on/services/define_company.dart';
import 'package:shared_preferences/shared_preferences.dart';

void signout(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('company');
  await auth.signOut();

  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
}

AppBar appBar(context, company, color) {
  var t = int.parse(color);
  return AppBar(
    backgroundColor: const Color(0xff181920),
    elevation: 2,
    centerTitle: true,
    title: RichText(
      text: TextSpan(
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: '$company',
            style: TextStyle(
              // color: Color.fromARGB(255, 255, 255, 255),
              color: Color(t),
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
        icon: Icon(Icons.logout, size: 20),
      ),
      // IconButton(
      //   onPressed: () => Get.toNamed(
      //     '/cart',
      //     arguments: {'company': company},
      //   ),
      //   icon: Icon(Icons.shopping_basket_rounded),
      // )
    ],
  );
}
