import 'package:flutter/material.dart';
import 'components/app_bar.dart';
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
      appBar: AppBarComponent(),
      body: PaymentBody(),
    );
  }
}
