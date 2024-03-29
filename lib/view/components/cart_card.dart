import 'package:flutter/material.dart';
import 'package:menu_on/services/products.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../models/ProductTeste.dart';
/* import 'package:shop_app/models/Cart.dart'; */

/* import '../../../constants.dart'; */

import '../../models/Cart.dart';

class CartCard extends StatefulWidget {
  final Map<String, dynamic> product;
  const CartCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  final _products = Products();
  late Map<String, dynamic> productInfo;
  Future<Map<String, dynamic>> getProductInfo() async {
    // print('widget.product');
    // print(widget.product);
    final Map<String, dynamic> response;
    if (widget.product['productId'] != null) {
      response = await _products.getProduct(widget.product['productId']);
    } else {
      response = await _products.getProduct(widget.product['id_product']);
    }

    return response;
    // if (response != null) {
    //   return response;
    // } else {
    //   return Future.error('Nenhum produto foi encontrado.');
    // }
  }

  // caso tenha usuário ou company na SharedPreferences, ir para o menu direto

  // final Cart cart;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF252A34),
        borderRadius: BorderRadius.circular(15),
      ),
      child: FutureBuilder(
          future: getProductInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final Map<String, dynamic> data =
                  snapshot.data as Map<String, dynamic>;
              return Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 77,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            // color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "https://${data['image_url']}",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("R\$ ${data['price']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  )),
                              Text(
                                widget.product['numOfItems'] != null
                                    ? " x${widget.product['numOfItems']}"
                                    : " x${widget.product['sales']['quantity_sold']}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Expanded(
                child: SizedBox(
                    height: 75,
                    child: const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      ),
                    )),
              );
            }
          }),
    );
  }
}
