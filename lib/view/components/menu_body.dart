import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menu_on/view/details/details-screen.dart';

import '../../constants.dart';
import '../../models/ProductTeste.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'category_item.dart';
import 'item_card2.dart';
import 'dart:convert' as convert;
import 'package:menu_on/services/categories.dart';
import 'package:menu_on/services/products.dart';

class MenuBody extends StatefulWidget {
  const MenuBody({Key? key}) : super(key: key);

  @override
  State<MenuBody> createState() => _MenuBodyState();
}

class _MenuBodyState extends State<MenuBody> {
  String testeCtrl = '';
  late Future<Map<String, dynamic>> company;
  final _categories = Categories();
  final _products = Products();
  String getProductsStatus = 'loading';
  String getCategoriesStatus = 'loading';

  Future<Map<String, dynamic>> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoryPrefs = prefs.getInt('category');
    final companyPrefs = prefs.getString('company');

    if (companyPrefs != null) {
      var companyJson = convert.jsonDecode(companyPrefs);
      // company = companyJson;
      final response =
          await _categories.getCategories(companyJson['id_company']);
      if (response['categories'] != null) {
        // print('getCategories');
        // setState(() {
        //   _category = response['categories'][0]['id_category'];
        // });
        if (categoryPrefs == null) {
          prefs.setInt('category', response['categories'][0]['id_category']);
        }
        return response;
      } else {
        return Future.error('Nenhuma categoria foi encontrada.');
      }
    } else {
      return Future.error('Nenhuma categoria foi encontrada.');
    }
  }

  Future<Map<String, dynamic>> getProducts() async {
    // setState(() {
    //   getProductsStatus = 'loading';
    // });
    getProductsStatus = 'loading';
    final prefs = await SharedPreferences.getInstance();
    final companyPrefs = prefs.getString('company');
    final categoryPrefs = prefs.getInt('category');
    int? selectedCategory;

    if (companyPrefs != null && categoryPrefs != null) {
      var companyJson = convert.jsonDecode(companyPrefs);
      selectedCategory = categoryPrefs;
      final response = await _products.getProducts(
          companyJson['id_company'], selectedCategory);
      if (response['products'] != null) {
        // setState(() {
        //   getProductsStatus = 'ready';
        // });
        getProductsStatus = 'ready';

        return response;
      } else {
        // return Future.error('Nenhum produto foi encontrado.');
        throw Exception();
      }
    } else {
      throw Exception();
    }
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff181920),
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
          Expanded(
            flex: 1,
            child: FutureBuilder(
                future: getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final Map<String, dynamic> data =
                        snapshot.data as Map<String, dynamic>;
                    final List<dynamic> categories = data['categories'];
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kDefaultPaddin),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 35,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, index) => buildCategory(
                                  index,
                                  categories[index]['name'],
                                  categories[index]['id_category']),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPaddin),
                              child: FutureBuilder(
                                future: getProducts(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData ||
                                      getProductsStatus == 'loading') {
                                    print('NAO TEM DADOS');
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                      widthFactor: 30,
                                      heightFactor: 30,
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return const Text(
                                        'Erro ao carregar os produtos.');
                                  }
                                  if (snapshot.hasData) {
                                    print('ENTROU');
                                    final Map<String, dynamic> data =
                                        snapshot.data as Map<String, dynamic>;
                                    final List<dynamic> products =
                                        data['products'];
                                    return GridView.builder(
                                      itemCount: products.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: kDefaultPaddin,
                                        crossAxisSpacing: kDefaultPaddin,
                                        childAspectRatio: 0.75,
                                      ),
                                      itemBuilder: (context, index) {
                                        return ItemCard(
                                          ProductModel.fromMap(
                                            products[index]
                                                as Map<String, dynamic>,
                                          ),
                                          press: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return DetailsScreen2(
                                                    ProductModel.fromMap(
                                                      products[index] as Map<
                                                          String, dynamic>,
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                      widthFactor: 30,
                                      heightFactor: 30,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                      widthFactor: 30,
                      heightFactor: 30,
                    );
                  }
                }),
          ),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          //     child: FutureBuilder(
          //       future: getProducts(),
          //       builder: (context, snapshot) {
          //         if (!snapshot.hasData || getProductsStatus == 'loading') {
          //           print('NAO TEM DADOS');
          //           return const Center(
          //             child: CircularProgressIndicator(),
          //             widthFactor: 30,
          //             heightFactor: 30,
          //           );
          //         }
          //         if (snapshot.hasError) {
          //           return const Text('Erro ao carregar os produtos.');
          //         }
          //         if (snapshot.hasData) {
          //           print('ENTROU');
          //           final Map<String, dynamic> data =
          //               snapshot.data as Map<String, dynamic>;
          //           final List<dynamic> products = data['products'];
          //           return GridView.builder(
          //             itemCount: products.length,
          //             gridDelegate:
          //                 const SliverGridDelegateWithFixedCrossAxisCount(
          //               crossAxisCount: 2,
          //               mainAxisSpacing: kDefaultPaddin,
          //               crossAxisSpacing: kDefaultPaddin,
          //               childAspectRatio: 0.75,
          //             ),
          //             itemBuilder: (context, index) {
          //               return ItemCard(
          //                 ProductModel.fromMap(
          //                   products[index] as Map<String, dynamic>,
          //                 ),
          //                 press: () {
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (context) {
          //                         return DetailsScreen2(
          //                           ProductModel.fromMap(
          //                             products[index] as Map<String, dynamic>,
          //                           ),
          //                         );
          //                       },
          //                     ),
          //                   );
          //                 },
          //               );
          //             },
          //           );
          //         } else {
          //           return const Center(
          //             child: CircularProgressIndicator(),
          //             widthFactor: 30,
          //             heightFactor: 30,
          //           );
          //         }
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildCategory(int index, String category, int idCategory) {
    return GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt('category', idCategory);
        setState(() {
          selectedIndex = index;
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
