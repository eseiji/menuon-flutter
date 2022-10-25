import 'package:flutter/material.dart';
import 'package:menu_on/models/ProductTeste.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:menu_on/services/orders.dart';

import 'dart:convert' as convert;
/* import 'package:flutter_svg/flutter_svg.dart'; */
/* import 'package:shop_app/components/default_button.dart'; */

/* import '../../../constants.dart'; */

import '../../components/default_button.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _orders = Orders();

    Future<String> getOrderProducts() async {
      final prefs = await SharedPreferences.getInstance();
      var orderProducts = prefs.getString('order_products');
      print(orderProducts);
      return orderProducts as String;
    }

    Future<void> postProducts() async {
      await _orders.postOrder(total, status, id_table, id_customer)
    }

    // Future<String> getProducts() async {
    //   final prefs = await SharedPreferences.getInstance();
    //   // product = {'idProduct': widget.idProduct, 'numOfItems': numOfItems};
    //   order_products = prefs.getString('order_products') as String;
    //   print('order_products');
    //   print(order_products);
    //   return order_products;
    //   // return convert.jsonDecode(order_products);
    // }

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        // color: const Color(0xff181920),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: getOrderProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> orderProductsParsed =
                        convert.jsonDecode(snapshot.data as String);
                    double total = 0;
                    String formattedPrice;
                    for (var e in orderProductsParsed) {
                      {
                        if (e['unitPrice'] != null && e['numOfItems'] != null) {
                          formattedPrice =
                              (e['unitPrice'] as String).replaceAll("\$", '');
                          total = total +
                              (double.parse(formattedPrice) *
                                  (e['numOfItems'] as int));
                        }
                      }
                      ;
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Total:\n",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: "R\$ $total",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF5767FE),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 15.0,
                              )
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Finalizar pedido',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Nenhum produto encontrado',
                          style: TextStyle(color: Colors.white)),
                    );
                  } else {
                    return const Center(
                      child: Text('Nenhum produto encontrado'),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
