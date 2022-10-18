import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_on/services/define_company.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

void signout(BuildContext context) async {
  // FirebaseAuth auth = FirebaseAuth.instance;
  final prefs = await SharedPreferences.getInstance();
  // await prefs.remove('company');
  // await prefs.remove('user');
  await prefs.clear();
  // await auth.signOut();

  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
}

Future<String> getCompany() async {
  final prefs = await SharedPreferences.getInstance();
  final companyPrefs = prefs.getString('company');

  if (companyPrefs != null) {
    var companyJson = convert.jsonDecode(companyPrefs);
    return companyJson['name'];
  } else {
    return Future.error('Nenhum produto foi encontrado.');
  }
}

AppBar appBar(context) {
  // var t = int.parse(color);
  return AppBar(
    backgroundColor: const Color(0xff181920),
    elevation: 2,
    centerTitle: true,
    title: FutureBuilder(
        future: getCompany(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final String company = snapshot.data as String;
            print(company);
            return RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: company,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      // color: Color(t),
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text('A Companhia não foi encontrada.');
          }
        }),
    actions: [
      IconButton(
        onPressed: () => signout(context),
        icon: Icon(Icons.logout, size: 20),
      ),
      IconButton(
        onPressed: () => Get.toNamed(
          '/cart',
          arguments: {'company': 'company'},
        ),
        icon: Icon(Icons.shopping_basket_rounded),
      )
    ],
  );
}
