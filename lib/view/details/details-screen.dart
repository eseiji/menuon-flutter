import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_on/models/ProductTeste.dart';
import 'package:menu_on/redux/app_store.dart';
import 'package:menu_on/view/details/components/body.dart';

class DetailsScreen2 extends StatelessWidget {
  final ProductModel model;
  // final String company;

  const DetailsScreen2(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightBlue,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: const Color(0xff181920),
      // ),
      appBar: _appBar(context),
      body: Body2(model),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff181920),
      elevation: 2,
      centerTitle: true,
      // title: const Text('Sim'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed('/cart');
          },
          //  Get.toNamed(
          //   '/cart',
          //   arguments: {'company': 'company'},
          // ),
          icon: AnimatedBuilder(
            animation: appStore,
            builder: (_, __) {
              if (appStore.state.value > 0) {
                return Badge(
                  badgeColor: const Color(0xFF5767FE),
                  badgeContent: Text(
                    '${appStore.state.value}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.basketShopping,
                    color: Colors.white,
                    size: 20,
                  ),
                );
              } else {
                return const FaIcon(
                  FontAwesomeIcons.basketShopping,
                  color: Colors.white,
                  size: 20,
                );
              }
            },
          ),
        )

        // FutureBuilder(
        //   future: getCurrentRoute(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       final AppRoute actions = snapshot.data as AppRoute;
        //       return actions.action;
        //     } else {
        //       return Container();
        //     }
        //   },
        // )
      ],
      // [getCurrentRoute().action],
    );
  }
}
