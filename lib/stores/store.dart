import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class Store extends ChangeNotifier {
  int value;
  Store(this.value);

  Future<void> getOrderProducts() async {
    final prefs = await SharedPreferences.getInstance();
    // product = {'idProduct': widget.idProduct, 'numOfItems': numOfItems};
    List<dynamic> orderProducts =
        convert.jsonDecode(prefs.getString('order_products') as String);
    // print('order_products');
    // print(order_products);
    // return order_products;
    value = orderProducts.length;
    notifyListeners();
    print('value');
    print(value);
  }
}
