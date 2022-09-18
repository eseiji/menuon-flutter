import 'dart:math';

import 'package:flutter/material.dart';
import 'package:menu_on/models/ProductTeste.dart';
import 'package:menu_on/view/details/components/item_image.dart';
import 'package:menu_on/view/details/components/order_button.dart';
import 'package:menu_on/view/details/components/title_price_rating.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class ItemInfo extends StatefulWidget {
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
  State<ItemInfo> createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  @override
  int numOfItems = 1;
  //   void addToCart(<String, dynamic> product) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('order_products', link!);
  // }
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
          shopeName(widget.company),
          TitlePriceRating(
            nome: widget.nome,
            preco: widget.preco,
            tamanho: widget.tamanho,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.descricao,
              style: const TextStyle(
                height: 1.5,
                color: Colors.white,
              ),
            ),
          ),
          // SizedBox(height: size.height * 0.1),
          // const SizedBox(height: 25),
          const Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 35,
                  height: 25,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF5767FE),
                        primary: Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(20)),
                        // primary: Colors.white,
                        // backgroundColor: Color(0xFF5767FE),
                      ),
                      onPressed: () {
                        if (numOfItems > 1) {
                          setState(() {
                            numOfItems--;
                          });
                        }
                      },
                      child: const Icon(Icons.remove)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${numOfItems}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 35,
                  height: 25,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF5767FE),
                        primary: Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(20)),
                        // primary: Colors.white,
                        // backgroundColor: Color(0xFF5767FE),
                      ),
                      onPressed: () {
                        setState(() {
                          numOfItems++;
                        });
                      },
                      child: const Icon(Icons.add)),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFF5767FE),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      TextButton(
                        onPressed: () => {},
                        child: const Text(
                          'Adicionar no carrinho',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Free space  10% of total height
          // OrderButton(
          //   size: size,
          //   press: () {},
          // ),
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
