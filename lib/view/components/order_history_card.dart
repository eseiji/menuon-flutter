import 'package:flutter/material.dart';
import 'package:menu_on/services/products.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../models/ProductTeste.dart';
/* import 'package:shop_app/models/Cart.dart'; */

/* import '../../../constants.dart'; */

import '../../models/Cart.dart';

class OrderHistoryCard extends StatefulWidget {
  final Map<String, dynamic> order_history;
  const OrderHistoryCard({
    Key? key,
    required this.order_history,
  }) : super(key: key);

  @override
  State<OrderHistoryCard> createState() => _OrderHistoryCardState();
}

class _OrderHistoryCardState extends State<OrderHistoryCard> {
  // final _products = Products();
  // late Map<String, dynamic> productInfo;
  // Future<Map<String, dynamic>> getProductInfo() async {
  //   // print('widget.product');
  //   // print(widget.product);
  //   final response = await _products.getProduct(widget.product['productId']);

  //   if (response != null) {
  //     return response;
  //   } else {
  //     return Future.error('Nenhum produto foi encontrado.');
  //   }
  // }

  // caso tenha usuário ou company na SharedPreferences, ir para o menu direto

  // final Cart cart;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xFF252A34),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nº ${widget.order_history["id_order"]}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Total: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              " R\$${widget.order_history['total']}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // CircleAvatar(
                    //   radius: 15,
                    //   backgroundColor: Color(0xff94d500),
                    //   child: Center(
                    //     child: IconButton(
                    //       icon: Icon(
                    //         Icons.check_circle,
                    //         color: Colors.black,
                    //         size: 30,
                    //       ),
                    //       onPressed: () {
                    //         print('object');
                    //       },
                    //     ),
                    //   ),
                    // ),
                    widget.order_history['status'] == 0
                        ? const Icon(
                            Icons.pending,
                            color: Colors.white,
                            size: 30,
                          )
                        : const Icon(
                            Icons.check_circle,
                            color: Colors.lightGreenAccent,
                            size: 30,
                          )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
