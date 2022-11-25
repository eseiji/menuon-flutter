import 'package:flutter/material.dart';
import 'package:menu_on/services/order_history.dart';
import 'package:menu_on/view/components/order_history_card.dart';
/* import 'package:flutter_svg/svg.dart'; */

import '../../models/Cart.dart';
import 'cart_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class OrderHistoryBody extends StatefulWidget {
  @override
  _OrderHistoryBodyState createState() => _OrderHistoryBodyState();
}

class _OrderHistoryBodyState extends State<OrderHistoryBody> {
  String getOrderHistoryStatus = 'none';
  // late String order_products;
  final _orderHistory = OrderHistory();
  Future<List<dynamic>> getOrderHistory() async {
    getOrderHistoryStatus = 'pending';
    final prefs = await SharedPreferences.getInstance();
    // product = {'idProduct': widget.idProduct, 'numOfItems': numOfItems};
    Map<String, dynamic> company =
        convert.jsonDecode(prefs.getString('company') as String);
    Map<String, dynamic> user =
        convert.jsonDecode(prefs.getString('user') as String);
    final response = await _orderHistory.getOrderHistory(
      user["id_user"],
      company["id_company"],
      1,
    );
    print(response);
    getOrderHistoryStatus = 'done';
    if (response.isNotEmpty) {
      return response;
    } else {
      return Future.error('');
    }
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
            future: getOrderHistory(),
            builder: (context, snapshot) {
              if (!snapshot.hasData && getOrderHistoryStatus == 'done') {
                return const Center(
                  child: Text(
                    'Nenhum pedido foi encontrado',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              if (!snapshot.hasData && getOrderHistoryStatus == 'pending') {
                return const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Text('Erro ao carregar os produtos.');
              }
              if (snapshot.hasData) {
                final List<dynamic> data = snapshot.data as List<dynamic>;
                // print('=================================');
                print(data);
                // final List<dynamic> products = data['products'];
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(data[index]['id_order'].toString()),
                      direction: DismissDirection.none,
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
                          ],
                        ),
                      ),
                      child: OrderHistoryCard(order_history: data[index]),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  ),
                );
              }
            },
          )),
    );
  }
}