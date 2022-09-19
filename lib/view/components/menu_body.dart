import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menu_on/view/details/details-screen.dart';
// import 'package:shop_app/constants.dart';
// import 'package:shop_app/models/Product.dart';
// import 'package:shop_app/screens/details/details_screen.dart';
// import '../../models/ProductMenu.dart';

import '../../constants.dart';
import '../../models/ProductTeste.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../product_detail/details_screen.dart';
// import 'categories.dart';
import 'category_item.dart';
import 'item_card2.dart';
import 'dart:convert' as convert;
import 'package:menu_on/services/categories.dart';

class MenuBody extends StatefulWidget {
  const MenuBody({Key? key}) : super(key: key);

  @override
  State<MenuBody> createState() => _MenuBodyState();
}

class _MenuBodyState extends State<MenuBody> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestore = FirebaseFirestore.instance;

  // final testeCtrl = TextEditingController();
  String testeCtrl = '';
  late Future<Map<String, dynamic>> company;
  final _categories = Categories();

  // void getCompany() async {
  //   print('getCompany');
  //   final prefs = await SharedPreferences.getInstance();
  //   final companyPrefs = prefs.getString('company');
  //   if (companyPrefs != null) {
  //     var companyJson = convert.jsonDecode(companyPrefs);
  //     getCategories(companyJson['id_company']);
  //     company = companyJson;
  //   }
  // }

  Future<Map<String, dynamic>> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final companyPrefs = prefs.getString('company');

    if (companyPrefs != null) {
      var companyJson = convert.jsonDecode(companyPrefs);
      // company = companyJson;
      final response =
          await _categories.getCategories(companyJson['id_company']);
      if (response['categories'] != null) {
        return response;
      } else {
        return Future.error('Nenhuma categoria foi encontrada.');
      }
    } else {
      return Future.error('Nenhuma categoria foi encontrada.');
    }
  }

  // void felipe(String carlos) {
  //   print(carlos);
  //   setState(() {
  //     testeCtrl = carlos;
  //   });
  // }

  // List<String> categories = ["Entradas", "Bebidas", "Sobremesas"];
  int selectedIndex = 0;
  String category = 'entradas';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff181920),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 0.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF252A34),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const TextField(
              // onChanged: (value) => felipe(value),
              style: TextStyle(color: Colors.white),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
            child: SizedBox(
              height: 35,
              child: FutureBuilder(
                  future: getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final Map<String, dynamic> data =
                          snapshot.data as Map<String, dynamic>;
                      final List<dynamic> categories = data['categories'];
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) =>
                            buildCategory(index, categories[index]['name']),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          //     child: StreamBuilder<QuerySnapshot>(
          //       stream: firestore
          //           .collection('cardapio')
          //           .doc(widget.company)
          //           .collection(category)
          //           .snapshots(),
          //       builder: (_, snapshot) {
          //         if (!snapshot.hasData) {
          //           return const Center(
          //             child: CircularProgressIndicator(),
          //           );
          //         }
          //         if (snapshot.hasError) {
          //           return const Text('Erro ao carregar o cardápio.');
          //         }
          //         return GridView.builder(
          //           itemCount: snapshot.data!.docs.length,
          //           gridDelegate:
          //               const SliverGridDelegateWithFixedCrossAxisCount(
          //             crossAxisCount: 2,
          //             mainAxisSpacing: kDefaultPaddin,
          //             crossAxisSpacing: kDefaultPaddin,
          //             childAspectRatio: 0.75,
          //           ),
          //           itemBuilder: (context, index) {
          //             return ItemCard(
          //               ProductModel.fromMap(
          //                 snapshot.data!.docs[index].id,
          //                 snapshot.data!.docs[index].data()
          //                     as Map<String, dynamic>,
          //               ),
          //               press: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                     builder: (context) {
          //                       return DetailsScreen2(
          //                         widget.company,
          //                         ProductModel.fromMap(
          //                           snapshot.data!.docs[index].id,
          //                           snapshot.data!.docs[index].data()
          //                               as Map<String, dynamic>,
          //                         ),
          //                       );
          //                     },
          //                   ),
          //                 );
          //               },
          //             );
          //           },
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildCategory(int index, String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          // category = categories[index].toLowerCase();
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              category as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: selectedIndex == index ? kTextLightColor : kTextColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: kDefaultPaddin / 4,
              ), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index
                  ? const Color.fromARGB(255, 77, 75, 75)
                  : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}

// FutureBuilder(
//       future: getCompany(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           final error = snapshot.error;
//           return Center(child: Text('$error'));
//         } else if (snapshot.hasData) {
//           final String repo = snapshot.data as String;
//           return FutureBuilder(
//             future: buscarCorPersonalizada(repo),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 final error = snapshot.error;
//                 return Center(child: Text('$error'));
//               } else if (snapshot.hasData) {
//                 final String repo2 = snapshot.data as String;
//                 return Scaffold(
//                   extendBody: true,
//                   appBar: appBar(context, repo, repo2),
//                   body: MenuBody(company: repo),
//                   // bottomNavigationBar: const BottomBar(),
//                 );
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           );
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
