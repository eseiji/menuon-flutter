import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:menu_on/view/login.view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/Product.dart';
import '../models/ProductMenu.dart';
import 'components/app_bar.dart';
import 'components/bottom_bar.dart';
import 'components/category_item.dart';
import 'components/menu_body.dart';

import 'package:menu_on/services/define_company.dart';

import "dart:async";
import 'dart:convert' as convert;

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;

  // late String company = '';
  late String color = '';
  late Future<String> company;

  String email = '';
  String senha = '';

  double? spaceBtw = 5;
  double? sizeBox = 50.0;

  final kDefaultBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      width: 1,
      color: Color(0xFF5767FE),
    ),
  );

  final kHintTextStyle = const TextStyle(
    color: Colors.white54,
    fontFamily: 'OpenSans',
  );

  final kLabelStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  final kBoxDecorationStyle = BoxDecoration(
    color: const Color(0xFF252A34),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  // GET PRODUCTS & GET CATEGORIES ======================================================================================================

  Future<String> getCategories() async {
    print('getCategories');
    // FirebaseAuth auth = FirebaseAuth.instance;

    // late String company = '';
    final prefs = await SharedPreferences.getInstance();
    // print('JA PASSOU');
    // final arguments = (ModalRoute.of(context)?.settings.arguments ??
    //     <String, dynamic>{}) as Map;

    final company = prefs.getString('company');
    if (company != null) {
      print(convert.jsonDecode(company));
      return company;
    } else {
      return 'company';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: _drawer(context),
      appBar: appBar(context),
      body: const MenuBody(),
    );
  }

  void signout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      width: 230,
      elevation: 5,
      backgroundColor: const Color(0xff181920),
      // backgroundColor: const Color(0xFF252A34),
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(
              Icons.receipt_long_rounded,
              color: Colors.white,
            ),
            title: Text(
              'Pedidos',
              style: GoogleFonts.roboto(),
              // TextStyle(
              //   color: Colors.white,
              //   fontWeight: FontWeight.bold,
              // ),
            ),
            onTap: () => Navigator.popAndPushNamed(context, '/order_history'),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ),
            title: const Text(
              'Sair',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => signout(context),
          )
        ],
      ),
    );
  }
}
