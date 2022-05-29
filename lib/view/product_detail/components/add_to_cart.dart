import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shop_app/models/Product.dart';

import '../../../constants.dart';
// import '../../../models/ProductMenu.dart';

import '../../../constants.dart';
import '../../../models/ProductTeste.dart';

class AddToCart extends StatelessWidget {
  final ProductModel model;

  AddToCart(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.white,
                // color: model.color,
                onPressed: () {},
                child: Text(
                  "Adicionar".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
