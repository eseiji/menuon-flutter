import 'package:flutter/material.dart';

/* import 'package:shop_app/models/Cart.dart'; */

/* import '../../../constants.dart'; */

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
  String formatDate(String value) {
    var splittedDate = value.split(' ');
    var date = splittedDate[0].split('-');
    var formattedYear = date[0].substring(2);
    var hour = splittedDate[1].split(':');
    return "${date[2]}/${date[1]}/$formattedYear - ${hour[0]}:${hour[1]}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFF252A34),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 62, 66, 73),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 15,
                    ),
                    child: Text(
                      formatDate(widget.order_history['insertion_date']),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
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
                                  " R\$ ${widget.order_history['total']}",
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
            ),
          ],
        ));
  }
}
