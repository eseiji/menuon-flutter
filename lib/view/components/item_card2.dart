import 'package:flutter/material.dart';

import '../../../constants.dart';
// import '../../models/ProductMenu.dart';
import '../../models/ProductTeste.dart';

class ItemCard extends StatelessWidget {
  final ProductModel model;

  // final Product? product;
  final Function()? press;
  // const ItemCard(
  //   ProductModel productModel, {
  //   Key? key,
  //   // this.product,
  //   this.press,
  //   this.model,
  // }) : super(key: key);

  ItemCard(this.model, {this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF252A34),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(kDefaultPaddin),
                // For  demo we use fixed height  and width
                // Now we dont need them
                // height: 180,
                // width: 160,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  // color: product!.color,
                  // borderRadius: BorderRadius.circular(16),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Hero(
                  tag: model.nome,
                  child: Image.network("https://${model.imagemUrl}"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kDefaultPaddin / 4,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // products is out demo list
                    "${model.nome} - ${model.tamanho}ml",
                    style: TextStyle(color: kTextLightColor),
                  ),
                  Text(
                    "R\$ ${model.preco}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
