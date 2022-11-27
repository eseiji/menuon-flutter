import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Cart.dart';
import 'components/app_bar.dart';
import 'components/order_body.dart';
import 'components/check_out_card.dart';
import 'components/order_history_details_body.dart';

class OrderHistoryDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: appBar(context),
      body: OrderHistoryDetailsBody(),
    );
  }
}
