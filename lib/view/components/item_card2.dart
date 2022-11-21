import 'package:flutter/material.dart';

import '../../../constants.dart';
// import '../../models/ProductMenu.dart';
import '../../models/ProductTeste.dart';

class ItemCard extends StatelessWidget {
  final ProductModel model;
  final Function()? press;

  ItemCard(this.model, {this.press});

  String formatSize(dynamic size) {
    // String result;
    // if (num.tryParse('$size') != null) {
    //   if (size >= 1000 && size > 0) {
    //     size = (size / 1000).round();
    //     result = "${model.nome} - ${size}L";
    //   } else if (size > 0 && size < 1000) {
    //     result = "${model.nome} - ${model.tamanho}ml";
    //   } else {
    //     result = model.nome;
    //   }
    // } else {
    //   result = "${model.nome} - ${model.tamanho}";
    // }
    // return result;
    return model.nome;
  }

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
                  color: Colors.white,
                  // color: product!.color,
                  // borderRadius: BorderRadius.circular(16),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network("https://${model.imagemUrl}",
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kDefaultPaddin / 4,
                horizontal: 10,
              ),
              child:
                  // StreamBuilder<String>(
                  //   stream: formatSize(model.tamanho),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasError) {
                  //       final error = snapshot.error;
                  //       return Center(child: Text('$error'));
                  //     } else if (snapshot.hasData) {
                  //       final String text = snapshot.data as String;
                  //       return Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             text,
                  //             style: const TextStyle(color: kTextLightColor),
                  //           ),
                  //           Text(
                  //             "R\$ ${model.preco}",
                  //             style: const TextStyle(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           )
                  //         ],
                  //       );
                  //     } else {
                  //       return const Center(child: CircularProgressIndicator());
                  //     }
                  //   },
                  // ),
                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatSize(model.tamanho),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: kTextLightColor),
                  ),
                  Text(
                    "R\$ ${model.preco}",
                    style: const TextStyle(
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
