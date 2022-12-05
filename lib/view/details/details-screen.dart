import 'package:flutter/material.dart';
import 'package:menu_on/models/ProductTeste.dart';
import 'package:menu_on/view/details/components/body.dart';

class DetailsScreen2 extends StatelessWidget {
  final ProductModel model;
  // final String company;

  const DetailsScreen2(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff181920),
      ),
      // appBar: const AppBarComponent(),
      body: Body2(model),
    );
  }
}
