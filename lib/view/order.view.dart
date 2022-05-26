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
    return Scaffold(
      extendBody: true,
      appBar: appBar(),
      body: Body(),
      bottomNavigationBar: const CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF5767FE),
      title: Container(
        child: Row(
          children: const [
            Icon(FontAwesomeIcons.wineGlassAlt),
            SizedBox(width: 5.0),
            Text(
              'MENU ON',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              child: Text(
                "${demoCarts.length} itens",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
