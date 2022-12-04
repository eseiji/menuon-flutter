import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

void signout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

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

String getCurrentRoute(BuildContext context) {
  String? route = ModalRoute.of(context)!.settings.name;
  String title = '';
  switch (route) {
    case '/cart':
      title = 'Carrinho';
      break;
    case '/order_history':
      title = 'Meus pedidos';
      break;
    case '/order_history_details':
      title = 'Meus pedidos';
      break;
    default:
      title = '';
  }
  return title;
}

AppBar appBar(context) {
  return AppBar(
    backgroundColor: const Color(0xff181920),
    elevation: 2,
    centerTitle: true,
    title: FutureBuilder(
      future: getCompany(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final String company = snapshot.data as String;
          return RichText(
            text: TextSpan(
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: ModalRoute.of(context)!.settings.name == '/menu'
                      ? company
                      : getCurrentRoute(context),
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  // style: const TextStyle(
                  //   color: Colors.white,
                  //   fontWeight: FontWeight.bold,
                  //   fontSize: 19,
                  // ),
                )
              ],
            ),
          );
        } else {
          return const Text('A Companhia não foi encontrada.');
        }
      },
    ),
    actions: [
      ModalRoute.of(context)!.settings.name == '/menu'
          ? IconButton(
              onPressed: () => Get.toNamed(
                '/cart',
                arguments: {'company': 'company'},
              ),
              icon: const FaIcon(
                FontAwesomeIcons.basketShopping,
                color: Colors.white,
                size: 20,
              ),
              // const Icon(Icons.shopping_bag),
            )
          : Container()
    ],
  );
}
