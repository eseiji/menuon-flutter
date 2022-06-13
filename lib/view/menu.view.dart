import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:menu_on/view/login.view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Product.dart';
import '../models/ProductMenu.dart';
import 'components/app_bar.dart';
import 'components/bottom_bar.dart';
import 'components/category_item.dart';
import 'components/menu_body.dart';

import 'package:menu_on/services/define_company.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  
  late String company;

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

  void getCompany() async {
    final prefs = await SharedPreferences.getInstance();
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final companyFromSharedPref = prefs.getString('company');

    setState(() {
      if (arguments['company'] != null) {
        company = arguments['company'];
      } else {
        company = companyFromSharedPref!;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCompany();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: appBar(context, company),
      body: MenuBody(company: company),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
