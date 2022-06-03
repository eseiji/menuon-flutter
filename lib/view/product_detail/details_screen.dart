import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shop_app/constants.dart';
// import 'package:shop_app/models/Product.dart';
// import 'package:shop_app/screens/details/components/body.dart';
import '../../models/ProductMenu.dart';

// import '../../models/Product.dart';
import '../../constants.dart';
import '../../models/ProductTeste.dart';
import 'components/details_body.dart';

class DetailsScreen extends StatelessWidget {
  // final Product product;

  final ProductModel model;

  DetailsScreen(this.model);

  // const DetailsScreen({
  //   Key? key,
  //   required this.product,
  // }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: const Color(0xff181920),
      // backgroundColor: Color(0xFF252A34),
      appBar: buildAppBar(context),
      body: Body(model),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        // icon: SvgPicture.asset(
        //   'assets/icons/back.svg',
        //   color: Colors.white,
        // ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          // icon: SvgPicture.asset("assets/icons/cart.svg"),
          icon: Icon(Icons.shopping_basket_rounded),
          onPressed: () => Get.toNamed('/cart'),
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
