import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Cart.dart';
import 'components/app_bar.dart';
import 'components/order_history_body.dart';
import 'components/check_out_card.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final arguments = (ModalRoute.of(context)?.settings.arguments ??
    //     <String, dynamic>{}) as Map;
    // print(arguments);
    // final company = arguments['company'];

    return Scaffold(
      // extendBody: true,
      appBar: appBar(context),
      body: OrderHistoryBody(),
      // bottomNavigationBar: const CheckoutCard(),
    );
  }
}
