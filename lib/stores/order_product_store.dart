import 'package:flutter/material.dart';

class OrderProductStore extends ChangeNotifier {
  var value = 1;

  // Future<void> getOrderProducts() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // product = {'idProduct': widget.idProduct, 'numOfItems': numOfItems};
  //   List<dynamic> orderProducts =
  //       convert.jsonDecode(prefs.getString('order_products') as String);
  //   // print('order_products');
  //   // print(order_products);
  //   // return order_products;
  //   value = orderProducts.length;
  //   notifyListeners();
  //   print('value');
  //   print(value);
  // }

  void sim() {
    value++;
    notifyListeners();
    print('PASSANDO NO SIM');
    print(value);
  }
}
