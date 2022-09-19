import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/Cart.dart';
import 'components/app_bar.dart';
import 'components/order_body.dart';
import 'components/check_out_card.dart';

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
      appBar: appBar(context),
      body: Body(),
      bottomNavigationBar: const CheckoutCard(),
    );
  }
}
