import 'package:flutter/material.dart';
import 'package:menu_on/models/ProductTeste.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:menu_on/services/orders.dart';

import 'dart:convert' as convert;
/* import 'package:flutter_svg/flutter_svg.dart'; */
/* import 'package:shop_app/components/default_button.dart'; */

/* import '../../../constants.dart'; */

import '../../components/default_button.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  @override
  String status = 'none';
  final _orders = Orders();
  Widget build(BuildContext context) {
    Future<String> getOrderProducts() async {
      final prefs = await SharedPreferences.getInstance();
      var orderProducts = prefs.getString('order_products');
      print(orderProducts);
      return orderProducts as String;
    }

    Future<void> postOrder() async {
      print(status);
      setState(() {
        status = 'pending';
      });
      print(status);
      // double total = 0;
      // String formattedPrice;
      // final prefs = await SharedPreferences.getInstance();
      // var orderProducts = prefs.getString('order_products');
      // List<dynamic> orderProductsParsed =
      //     convert.jsonDecode(orderProducts as String);

      // for (var e in orderProductsParsed) {
      //   {
      //     if (e['unitPrice'] != null && e['numOfItems'] != null) {
      //       formattedPrice = (e['unitPrice'] as String).replaceAll("\$", '');
      //       total = total +
      //           (double.parse(formattedPrice) * (e['numOfItems'] as int));
      //     }
      //   }
      // }
      // var orderResponse = await _orders.postOrder(total, 0, 1, 4, 1);
      setState(() {
        status = 'done';
      });
      print('status');
      print(status);
      // print(orderResponse);
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

    return SizedBox.expand(
      child: DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.2,
        maxChildSize: 0.6,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            height: 0.6,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 30,
            ),
            decoration: const BoxDecoration(
              color: Colors.black,
              // color: const Color(0xff181920),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
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
                            if (e['unitPrice'] != null &&
                                e['numOfItems'] != null) {
                              formattedPrice = (e['unitPrice'] as String)
                                  .replaceAll("\$", '');
                              total = total +
                                  (double.parse(formattedPrice) *
                                      (e['numOfItems'] as int));
                            }
                          }
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'R\$ $total',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Text.rich(
                            //   TextSpan(
                            //     text: "Total:\n",
                            //     style: const TextStyle(
                            //       fontSize: 16,
                            //       color: Colors.white,
                            //     ),
                            //     children: [
                            //       TextSpan(
                            //         text: "R\$ $total",
                            //         style: const TextStyle(
                            //             fontSize: 18,
                            //             color: Colors.white,
                            //             fontWeight: FontWeight.bold),
                            //       ),
                            //     ],
                            //   ),
                            // ),
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
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const DropdownButtonExample(),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                          // onPressed: () => status = 'done',
                          onPressed: () => postOrder(),
                          child: status == 'none'
                              ? const Text(
                                  'Finalizar pedido',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    // onPressed: () => status = 'done',
                    onPressed: () => postOrder(),
                    child: status == 'none'
                        ? const Text(
                            'Finalizar pedido',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    // Container(
    //   padding: const EdgeInsets.symmetric(
    //     vertical: 15,
    //     horizontal: 30,
    //   ),
    //   decoration: const BoxDecoration(
    //     color: Colors.black,
    //     // color: const Color(0xff181920),
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(30),
    //       topRight: Radius.circular(30),
    //     ),
    //   ),
    //   child: SafeArea(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         FutureBuilder(
    //             future: getOrderProducts(),
    //             builder: (context, snapshot) {
    //               if (snapshot.hasData) {
    //                 List<dynamic> orderProductsParsed =
    //                     convert.jsonDecode(snapshot.data as String);
    //                 double total = 0;
    //                 String formattedPrice;
    //                 for (var e in orderProductsParsed) {
    //                   {
    //                     if (e['unitPrice'] != null && e['numOfItems'] != null) {
    //                       formattedPrice =
    //                           (e['unitPrice'] as String).replaceAll("\$", '');
    //                       total = total +
    //                           (double.parse(formattedPrice) *
    //                               (e['numOfItems'] as int));
    //                     }
    //                   }
    //                   ;
    //                 }
    //                 return Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text.rich(
    //                       TextSpan(
    //                         text: "Total:\n",
    //                         style: const TextStyle(
    //                           fontSize: 16,
    //                           color: Colors.white,
    //                         ),
    //                         children: [
    //                           TextSpan(
    //                             text: "R\$ $total",
    //                             style: const TextStyle(
    //                                 fontSize: 18,
    //                                 color: Colors.white,
    //                                 fontWeight: FontWeight.bold),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     Container(
    //                       padding: const EdgeInsets.all(5),
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(15),
    //                         color: const Color(0xFF5767FE),
    //                         boxShadow: const [
    //                           BoxShadow(
    //                             color: Colors.black,
    //                             blurRadius: 15.0,
    //                           )
    //                         ],
    //                       ),
    //                       child: TextButton(
    //                         // onPressed: () => status = 'done',
    //                         onPressed: () => postOrder(),
    //                         child: status == 'none'
    //                             ? const Text(
    //                                 'Finalizar pedido',
    //                                 style: TextStyle(
    //                                   color: Colors.white,
    //                                   fontSize: 15.0,
    //                                   fontWeight: FontWeight.bold,
    //                                 ),
    //                               )
    //                             : const CircularProgressIndicator(),
    //                       ),
    //                     ),
    //                   ],
    //                 );
    //               } else if (snapshot.hasError) {
    //                 return const Center(
    //                   child: Text('Nenhum produto encontrado',
    //                       style: TextStyle(color: Colors.white)),
    //                 );
    //               } else {
    //                 return const Center(
    //                   child: Text('Nenhum produto encontrado'),
    //                 );
    //               }
    //             }),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

const List<String> list = <String>['Pix'];

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<String>(
        alignment: AlignmentDirectional.centerStart,
        value: dropdownValue,
        // icon: const Icon(Icons.arrow_downward),
        // elevation: 16,
        hint: const Text(
          'Selecione o meio de pagamento',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        underline: Container(
          height: 0,
          // color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        selectedItemBuilder: (BuildContext context) {
          return <String>['Pix'].map((String value) {
            return Center(
              child: Text(
                dropdownValue,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            );
          }).toList();
        },
        // selectedItemBuilder: list.map<Widget>((String value) {
        //   return Text(
        //     value,
        //   );
        // }).toList(),
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
      ),
    );
  }
}
