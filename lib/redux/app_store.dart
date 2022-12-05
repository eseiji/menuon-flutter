import 'package:menu_on/redux/store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

enum AppAction { increment, decrement }

class AppState {
  final int value;

  AppState({this.value = 0});
}

Future<AppState> _reducer(AppState state, AppAction action) async {
  // Future<void> getOrderProducts() async {
  final prefs = await SharedPreferences.getInstance();
  // product = {'idProduct': widget.idProduct, 'numOfItems': numOfItems};
  List<dynamic> orderProducts =
      convert.jsonDecode(prefs.getString('order_products') as String);
  // print('order_products');
  // print(order_products);
  // return order_products;
  // value = orderProducts.length;

  // print('value');
  // print(value);
  return AppState(value: orderProducts.length);
  // if (action == AppAction.increment) {
  //   return AppState(value: state.value + 1);
  // } else {
  //   return AppState(value: state.value - 1);
  // }
}

final appStore = ReduxStore<AppAction, AppState>(
  initialState: AppState(),
  reducer: _reducer,
);
