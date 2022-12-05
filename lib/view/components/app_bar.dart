import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_on/redux/app_store.dart';
import 'package:menu_on/stores/order_product_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

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

  String getCurrentRoute(BuildContext context) {
    String? route = ModalRoute.of(context)!.settings.name;
    String title = '';
    switch (route) {
      case '/cart':
        title = 'Carrinho';
        break;
      case '/order_history':
        title = 'Meus pedidos';
        break;
      case '/order_history_details':
        title = 'Meus pedidos';
        break;
      default:
        title = '';
    }
    return title;
  }

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
        future: getCompany(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final String company = snapshot.data as String;
            return RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: ModalRoute.of(context)!.settings.name == '/menu'
                        ? company
                        : getCurrentRoute(context),
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    // style: const TextStyle(
                    //   color: Colors.white,
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 19,
                    // ),
                  )
                ],
              ),
            );
          } else {
            return const Text('A Companhia não foi encontrada.');
          }
        },
      ),
      actions: [
        ModalRoute.of(context)!.settings.name == '/menu'
            ? IconButton(
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
                ))
            // const Icon(Icons.shopping_bag),
            : Container()
      ],
    );
  }
}

// AppBar appBar(context) {
//   return AppBar(
//     backgroundColor: const Color(0xff181920),
//     elevation: 2,
//     centerTitle: true,
//     title: FutureBuilder(
//       future: getCompany(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final String company = snapshot.data as String;
//           return RichText(
//             text: TextSpan(
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//               children: [
//                 TextSpan(
//                   text: ModalRoute.of(context)!.settings.name == '/menu'
//                       ? company
//                       : getCurrentRoute(context),
//                   style: GoogleFonts.rubik(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                     color: Colors.white,
//                   ),
//                   // style: const TextStyle(
//                   //   color: Colors.white,
//                   //   fontWeight: FontWeight.bold,
//                   //   fontSize: 19,
//                   // ),
//                 )
//               ],
//             ),
//           );
//         } else {
//           return const Text('A Companhia não foi encontrada.');
//         }
//       },
//     ),
//     actions: [
//       ModalRoute.of(context)!.settings.name == '/menu'
//           ? IconButton(
//               onPressed: () => Get.toNamed(
//                     '/cart',
//                     arguments: {'company': 'company'},
//                   ),
//               icon: Badge(
//                 badgeColor: const Color(0xFF5767FE),
//                 badgeContent: const Text(
//                   '1',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 child: const FaIcon(
//                   FontAwesomeIcons.basketShopping,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               )

//               // const Icon(Icons.shopping_bag),
//               )
//           : Container()
//     ],
//   );
// }
