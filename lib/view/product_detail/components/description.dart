import 'package:flutter/material.dart';
// import '../../../models/ProductMenu.dart';

import '../../../constants.dart';
import '../../../models/ProductTeste.dart';

class Description extends StatelessWidget {
  final ProductModel model;

  Description(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        model.descricao,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
