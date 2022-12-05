import 'package:flutter/material.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'components/appBarTeste.dart';
import 'components/app_bar.dart';
import 'components/menu_body.dart';

import "dart:async";
import 'dart:convert' as convert;

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var formKey = GlobalKey<FormState>();
  // final firestore = FirebaseFirestore.instance;

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
    // fontFamily: 'OpenSans',
  );

  final kLabelStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    // fontFamily: 'OpenSans',
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
      // appBar: const AppBarStateless(),
      appBar: const AppBarComponent(),
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
        // padding: EdgeInsets.zero,
        children: [
          Container(
            height: 65,
            decoration: const BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //     color: Color(0xff181920),
                //     spreadRadius: 10,
                //     blurRadius: 7,
                //     offset: Offset(0, 3), // changes position of shadow
                //   )
                // ],
                // border: Border(
                //   bottom: BorderSide(color: Color(0xFF7F7F7F)),
                // ),
                ),
            child: DrawerHeader(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Color(0xFF5767FE),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.wineGlass,
                      color: Colors.white,
                      size: 25,
                    ),
                    // Icon(
                    //   // FontAwesomeIcons.martiniGlass,
                    //   FontAwesomeIcons.wineGlassEmpty,
                    //   color: Colors.white,
                    // ),
                  ],
                ),
                title: const Text(
                  'MENU ON',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              // Text(
              //   'MENU ON',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 20,
              //   ),
              // ),
            ),
          ),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                FaIcon(
                  FontAwesomeIcons.receipt,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
            title: const Text(
              'Meus pedidos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            onTap: () => Navigator.popAndPushNamed(context, '/order_history'),
          ),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                FaIcon(
                  FontAwesomeIcons.rightFromBracket,
                  color: Colors.white,
                  size: 16,
                )
              ],
            ),
            title: const Text(
              'Sair',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            onTap: () => signout(context),
          )
        ],
      ),
    );
  }
}
