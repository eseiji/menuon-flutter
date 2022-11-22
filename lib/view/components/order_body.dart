import 'package:flutter/material.dart';
/* import 'package:flutter_svg/svg.dart'; */

import '../../models/Cart.dart';
import 'cart_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String order_products;
  Future<String> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    // product = {'idProduct': widget.idProduct, 'numOfItems': numOfItems};
    order_products = prefs.getString('order_products') as String;
    // print('order_products');
    // print(order_products);
    return order_products;
    // return convert.jsonDecode(order_products);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.infinity,
      // width: double.infinity,
      color: const Color(0xff181920),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder(
            future: getProducts(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text('Nenhum produto encontrado',
                      style: TextStyle(color: Colors.white)),
                );
                // widthFactor: 30,
                // heightFactor: 30,

              }
              if (snapshot.hasError) {
                return const Text('Erro ao carregar os produtos.');
              }
              if (snapshot.hasData) {
                final List<dynamic> data = convert
                    .jsonDecode(snapshot.data as String) as List<dynamic>;
                print(data);
                // final List<dynamic> products = data['products'];
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(data[index]['productId'].toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          demoCarts.removeAt(index);
                          print('REMOVER DO CARRINHO');
                        });
                      },
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xff181920),
                          // color: Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: const [
                            Spacer(),
                            /* SvgPicture.asset("assets/icons/Trash.svg"), */
                          ],
                        ),
                      ),
                      child: CartCard(product: data[index]),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                  // widthFactor: 30,
                  // heightFactor: 30,
                );
              }
            },
          )
          // ListView.builder(
          //   itemCount: demoCarts.length,
          //   itemBuilder: (context, index) => Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 10),
          //     child: Dismissible(
          //       key: Key(demoCarts[index].product.id.toString()),
          //       direction: DismissDirection.endToStart,
          //       onDismissed: (direction) {
          //         setState(() {
          //           demoCarts.removeAt(index);
          //         });
          //       },
          //       background: Container(
          //         padding: const EdgeInsets.symmetric(horizontal: 20),
          //         decoration: BoxDecoration(
          //           color: const Color(0xff181920),
          //           // color: Color(0xFFFFE6E6),
          //           borderRadius: BorderRadius.circular(15),
          //         ),
          //         child: Row(
          //           children: const [
          //             Spacer(),
          //             /* SvgPicture.asset("assets/icons/Trash.svg"), */
          //           ],
          //         ),
          //       ),
          //       child: CartCard(cart: demoCarts[index]),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
