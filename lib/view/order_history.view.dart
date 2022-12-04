import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/order_history_body.dart';

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
      appBar: AppBarComponent(),
      body: OrderHistoryBody(),
      // bottomNavigationBar: const CheckoutCard(),
    );
  }
}
