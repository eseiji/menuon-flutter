import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Cart.dart';
import 'components/app_bar.dart';
import 'components/order_body.dart';
import 'components/check_out_card.dart';
import 'components/payment_body.dart';

class PaymentView extends StatefulWidget {
  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
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
      body: PaymentBody(),
    );
  }
}
