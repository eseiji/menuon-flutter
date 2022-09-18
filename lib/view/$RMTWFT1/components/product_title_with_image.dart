import 'package:flutter/material.dart';
// import '../../../models/ProductMenu.dart';

import '../../../constants.dart';
import '../../../models/ProductTeste.dart';

class ProductTitleWithImage extends StatelessWidget {
  final ProductModel model;

  ProductTitleWithImage(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              height: 180,
              child: Image.network("https://${model.imagemUrl}"),
            ),
          ),
          Text(
            model.nome,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Preço\n"),
                    TextSpan(
                      text: "R\$ ${model.preco}",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
              // Expanded(
              //   child: Hero(
              //     tag: model.nome,
              //     child: Image.network("https://${model.imagemUrl}"),
              //     // Image.asset(
              //     //   product.image,
              //     //   fit: BoxFit.fill,
              //     // ),
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
