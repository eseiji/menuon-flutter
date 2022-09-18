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
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFF5767FE),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 15.0,
                    )
                  ],
                ),
                child: TextButton(
                  onPressed: () => (context),
                  child: const Text(
                    'Adicionar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
              // FlatButton(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(18)),
              //   color: Color(0xFF5767FE),
              //   // color: model.color,
              //   onPressed: () {},
              //   child: Text(
              //     "Adicionar".toUpperCase(),
              //     style: const TextStyle(
              //       fontSize: 17,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
