import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menu_on/view/details/details-screen.dart';
// import 'package:shop_app/constants.dart';
// import 'package:shop_app/models/Product.dart';
// import 'package:shop_app/screens/details/details_screen.dart';
// import '../../models/ProductMenu.dart';

import '../../constants.dart';
import '../../models/ProductTeste.dart';
import '../product_detail/details_screen.dart';
import 'categories.dart';
import 'category_item.dart';
import 'item_card2.dart';

class MenuBody extends StatefulWidget {
  const MenuBody({Key? key, required this.company}) : super(key: key);

  final String company;

  @override
  State<MenuBody> createState() => _MenuBodyState();
}

class _MenuBodyState extends State<MenuBody> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestore = FirebaseFirestore.instance;

  // final testeCtrl = TextEditingController();
  String testeCtrl = '';

  void felipe(String carlos) {
    print(carlos);
    setState(() {
      testeCtrl = carlos;
    });
  }

  List<String> categories = ["Entradas", "Bebidas", "Sobremesas"];
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
            child: TextField(
              onChanged: (value) => felipe(value),
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) => buildCategory(index),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('cardapio')
                    .doc(widget.company)
                    .collection(category)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text('Erro ao carregar o cardápio.');
                  }
                  return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
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
                          snapshot.data!.docs[index].id,
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>,
                        ),
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailsScreen2(
                                  widget.company,
                                  ProductModel.fromMap(
                                    snapshot.data!.docs[index].id,
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          category = categories[index].toLowerCase();
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
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
