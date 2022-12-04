import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
part 'order_product_counter.g.dart';

class OrderProductCounterStore = OrderProductCounter
    with _$OrderProductCounterStore;

abstract class OrderProductCounter with Store {
  @observable
  int value = 0;
  @action
  Future<void> getOrderProducts() async {
    final prefs = await SharedPreferences.getInstance();
    // product = {'idProduct': widget.idProduct, 'numOfItems': numOfItems};
    List<dynamic> orderProducts =
        convert.jsonDecode(prefs.getString('order_products') as String);
    // print('order_products');
    // print(order_products);
    // return order_products;
    print('orderProducts.length');
    print(orderProducts.length);
    value = orderProducts.length;
  }
}
