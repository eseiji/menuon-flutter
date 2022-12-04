import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/order_body.dart';

class CartScreen extends StatelessWidget {
  /* static String routeName = "/cart"; */
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    print(arguments);
    final company = arguments['company'];

    return Scaffold(
      extendBody: true,
      appBar: AppBarComponent(),
      body: Body(),
      // bottomNavigationBar: const CheckoutCard(),
    );
  }
}
