import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:menu_on/redux/app_store.dart';
import 'package:menu_on/stores/order_product_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class AppRoute {
  String title;
  Widget action;
  AppRoute({required this.title, required this.action});
}

class AppBarComponent extends StatefulWidget implements PreferredSizeWidget {
  const AppBarComponent({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();

  @override
  final Size preferredSize;
}

class _AppBarComponentState extends State<AppBarComponent> {
  int numOfItems = 0;
  // final _productCounterStore = OrderProductCounter();
  // final controller = Store(0);
  // late String order_products;
  // final AppBar appBar;
  final provider = OrderProductStore();
  void signout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  Future<String> getCompany() async {
    final prefs = await SharedPreferences.getInstance();
    final companyPrefs = prefs.getString('company');

    if (companyPrefs != null) {
      var companyJson = convert.jsonDecode(companyPrefs);
      return companyJson['name'];
    } else {
      return Future.error('Nenhum produto foi encontrado.');
    }
  }

  Future<AppRoute> getCurrentRoute() async {
    await appStore.dispatcher(AppAction.increment);
    String? route = ModalRoute.of(context)!.settings.name;
    late String title = '';
    late Widget action;
    switch (route) {
      case '/menu':
        var companyName = await getCompany();
        title = companyName;
        if (appStore.state.value >= 1) {
          action = IconButton(
            onPressed: () => Get.toNamed(
              '/cart',
              arguments: {'company': 'company'},
            ),
            icon: Badge(
              badgeColor: const Color(0xFF5767FE),
              badgeContent: AnimatedBuilder(
                  animation: appStore,
                  builder: (_, __) {
                    return Text(
                      '${appStore.state.value}',
                      style: const TextStyle(color: Colors.white),
                    );
                  }),
              child: const FaIcon(
                FontAwesomeIcons.basketShopping,
                color: Colors.white,
                size: 20,
              ),
            ),
          );
        } else {
          action = IconButton(
            onPressed: () => Get.toNamed(
              '/cart',
              arguments: {'company': 'company'},
            ),
            icon: const FaIcon(
              FontAwesomeIcons.basketShopping,
              color: Colors.white,
              size: 20,
            ),
          );
        }
        break;
      case '/cart':
        title = 'Carrinho';
        action = Container();
        break;
      case '/order_history':
        title = 'Meus pedidos';
        action = IconButton(
            onPressed: () {
              appStore.refreshOrderHistory();
              // setState(() {
              //   print('SETstate');
              // });
            },
            icon: const Icon(Icons.refresh_rounded)
            // const FaIcon(
            //   FontAwesomeIcons.arrowsRotate,
            //   color: Colors.white,
            //   size: 20,
            // ),
            );
        break;
      case '/order_history_details':
        title = 'Meus pedidos';
        action = Container();
        break;
      default:
        title = '';
        action = Container();
    }
    return AppRoute(title: title, action: action);
  }

  Future<void> geta() async {
    await appStore.dispatcher(AppAction.increment);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   geta();
  //   // appStore.dispatcher(AppAction.increment);
  // }

  // Future<String> getOrderProducts() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // product = {'idProduct': widget.idProduct, 'numOfItems': numOfItems};
  //   // order_products = prefs.getString('order_products') as String;
  //   // print('order_products');
  //   // print(order_products);
  //   // return order_products;
  //   return convert.jsonDecode(prefs.getString('order_products') as String);
  // }

  // void updateCartItems() async {
  //   var orderProducts = await getOrderProducts();

  //   setState(() {
  //     numOfItems = orderProducts.length;
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // geta();
    // print('provider');
    // print(provider.value);
    // final teste = Provider.of<AppBarComponent>(context);
    // final bloc = Provider.of<OrderProductStore>(context);
    // final todo = teste.;
    return AppBar(
      backgroundColor: const Color(0xff181920),
      elevation: 2,
      centerTitle: true,
      title: FutureBuilder(
        future: getCurrentRoute(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final AppRoute companyName = snapshot.data as AppRoute;
            return Text(
              companyName.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      actions: [
        FutureBuilder(
          future: getCurrentRoute(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final AppRoute actions = snapshot.data as AppRoute;
              return actions.action;
            } else {
              return Container();
            }
          },
        )
      ],
      // [getCurrentRoute().action],
    );
  }
}
