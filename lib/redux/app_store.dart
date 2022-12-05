import 'package:menu_on/redux/store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

enum AppAction { increment, decrement }

class AppState {
  final int value;

  AppState({this.value = 0});
}

Future<AppState> _reducer(AppState state, AppAction action) async {
  final prefs = await SharedPreferences.getInstance();
  String? asim = prefs.getString('order_products');
  if (asim != null) {
    List<dynamic> orderProducts = convert.jsonDecode(asim);

    return AppState(value: orderProducts.length);
  }
  return AppState(value: 0);
}

void _refresh(AppState state) async {
  // return AppState();
}

final appStore = ReduxStore<AppAction, AppState>(
    initialState: AppState(), reducer: _reducer, refresh: _refresh);
