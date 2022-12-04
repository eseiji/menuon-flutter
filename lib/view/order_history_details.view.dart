import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/order_history_details_body.dart';

class OrderHistoryDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBarComponent(),
      body: OrderHistoryDetailsBody(),
    );
  }
}
