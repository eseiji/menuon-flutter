import 'package:flutter/material.dart';
import 'package:menu_on/models/ProductTeste.dart';
import 'package:menu_on/view/details/components/item_image.dart';
import 'package:menu_on/view/details/components/order_button.dart';
import 'package:menu_on/view/details/components/title_price_rating.dart';

class Body2 extends StatelessWidget {
  final ProductModel model;
  final String company;

  Body2(this.model, this.company);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff181920),
      ),
      child: Column(
        children: <Widget>[
          ItemImage(
            imgSrc: model.imagemUrl,
          ),
          Expanded(
            child: ItemInfo(
              company: company,
              nome: model.nome,
              preco: model.preco,
              descricao: model.descricao,
              tamanho: model.tamanho,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemInfo extends StatelessWidget {
  final String company;
  final int preco;
  final String nome;
  final String descricao;
  final dynamic tamanho;
  const ItemInfo({
    Key? key,
    required this.company,
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.tamanho,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF252A34),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          shopeName(company),
          TitlePriceRating(
            nome: nome,
            preco: preco,
            tamanho: tamanho,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              descricao,
              style: const TextStyle(
                height: 1.5,
                color: Colors.white,
              ),
            ),
          ),
          // SizedBox(height: size.height * 0.1),
          // const SizedBox(height: 25),
          const Spacer(),
          // Free space  10% of total height
          OrderButton(
            size: size,
            press: () {},
          ),
        ],
      ),
    );
  }

  Row shopeName(name) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: Color(0xFF5767FE),
        ),
        SizedBox(width: 10),
        Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
