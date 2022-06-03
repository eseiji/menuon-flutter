import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:menu_on/view/login.view.dart';

import '../models/Product.dart';
import '../models/ProductMenu.dart';
import 'components/app_bar.dart';
import 'components/bottom_bar.dart';
import 'components/category_item.dart';
import 'components/menu_body.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

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

  void signout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    // final arguments = (ModalRoute.of(context)!.settings.arguments);
    // final arguments = ModalRoute.of(context)!.settings.arguments;
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    print(arguments);
    final enterprise = arguments['enterprise'];
    // final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    return Scaffold(
      extendBody: true,
      appBar: appBar(context, enterprise),
      // AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: const Color(0xFF5767FE),
      //   title: Container(
      //     child: Row(
      //       children: const [
      //         Icon(FontAwesomeIcons.wineGlassAlt),
      //         SizedBox(width: 5.0),
      //         Text(
      //           'MENU ON',
      //           style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.logout),
      //       tooltip: 'Sair',
      //       onPressed: () => signout(context),
      //     ),
      //   ],
      // ),
      body: MenuBody(),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Product? product;
  final Function? press;
  const ItemCard({
    Key? key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: 180,
          width: 160,
          decoration: BoxDecoration(
            color: const Color(0xFF252A34),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text('PRODUTO'),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20 / 4),
          child: Text(
            'Flutter app',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const Text(
          'R\$ 50',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/*Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 0.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF252A34),
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(
                //   color: const Color(0xFF252A34),
                // ),
              ),
              child: const TextField(
                // onChanged: onChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Pesquisar",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CategoryItem(
                    title: "Combos",
                    isActive: true,
                    press: () {},
                  ),
                  CategoryItem(
                    title: "Bebidas",
                    press: () {},
                  ),
                  CategoryItem(
                    title: "Sobremesas",
                    press: () {},
                  ),
                  CategoryItem(
                    title: "Porções",
                    press: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: demoProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(),
              ),
            ),
            // ItemCard(),
          ],
        ),
      ), */


// SingleChildScrollView(
                        //   scrollDirection: Axis.vertical,
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: <Widget>[
                        //           ItemCard(
                        //             svgSrc: "assets/icons/burger_beer.svg",
                        //             title: "Burger & Beer",
                        //             shopName: "MacDonald's",
                        //             press: () {
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) {
                        //                     return LoginPage();
                        //                     // return DetailsScreen();
                        //                   },
                        //                 ),
                        //               );
                        //             },
                        //           ),
                        //           ItemCard(
                        //             svgSrc: "assets/icons/chinese_noodles.svg",
                        //             title: "Chinese & Noodles",
                        //             shopName: "Wendys",
                        //             press: () {},
                        //           ),
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: <Widget>[
                        //           ItemCard(
                        //             svgSrc: "assets/icons/burger_beer.svg",
                        //             title: "Burger & Beer",
                        //             shopName: "MacDonald's",
                        //             press: () {
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) {
                        //                     return LoginPage();
                        //                     // return DetailsScreen();
                        //                   },
                        //                 ),
                        //               );
                        //             },
                        //           ),
                        //           ItemCard(
                        //             svgSrc: "assets/icons/chinese_noodles.svg",
                        //             title: "Chinese & Noodles",
                        //             shopName: "Wendys",
                        //             press: () {},
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),