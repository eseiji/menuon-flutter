import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_on/models/ProductTeste.dart';
import 'package:menu_on/redux/app_store.dart';
import 'package:menu_on/stores/order_product_counter.dart';
import 'package:menu_on/stores/order_product_store.dart';
import 'package:menu_on/view/details/components/item_image.dart';
import 'package:menu_on/view/details/components/title_price_rating.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class Body2 extends StatelessWidget {
  final ProductModel model;
  // final String company;

  const Body2(this.model);
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
              idProduct: model.idProduct,
              company: 'company',
              nome: model.nome,
              preco: model.preco,
              descricao: model.descricao,
              // imagemUrl: model.imagemUrl,
              // tamanho: model.tamanho,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemInfo extends StatefulWidget {
  final int idProduct;
  final String company;
  final String preco;
  final String nome;
  final String descricao;
  // final dynamic tamanho;
  const ItemInfo({
    Key? key,
    required this.idProduct,
    required this.company,
    required this.nome,
    required this.preco,
    required this.descricao,
    // required this.tamanho,
  }) : super(key: key);

  @override
  State<ItemInfo> createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  final _productCounterStore = OrderProductCounter();
  @override
  int numOfItems = 1;
  List<Map<String, dynamic>> product = [];
  String status = 'none';
  final controller = OrderProductStore();

  Future<String> getCompany() async {
    final prefs = await SharedPreferences.getInstance();
    final companyPrefs = prefs.getString('company');

    if (companyPrefs != null) {
      var companyJson = convert.jsonDecode(companyPrefs);
      return companyJson['name'];
    } else {
      return Future.error('Nenhum produto foi encontrado.');
    }
  }

  void addToCart() async {
    setState(() {
      status = 'pending';
    });
    final prefs = await SharedPreferences.getInstance();
    var orderProducts = prefs.getString('order_products');
    if (orderProducts != null && orderProducts.isNotEmpty) {
      var orderProductsParsed = convert.jsonDecode(orderProducts);
      orderProductsParsed.add({
        'productId': widget.idProduct,
        'numOfItems': numOfItems,
        'unitPrice': widget.preco
      });

      // product.add({'productId': widget.idProduct, 'numOfItems': numOfItems});
      await prefs.setString(
          'order_products', convert.jsonEncode(orderProductsParsed));
    } else {
      product = [
        {
          'productId': widget.idProduct,
          'numOfItems': numOfItems,
          'unitPrice': widget.preco
        }
      ];
      print(product);
      await prefs.setString('order_products', convert.jsonEncode(product));
    }
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      status = 'done';
    });
    // await _productCounterStore.getOrderProducts();
    // controller.sim();
    appStore.dispatcher(AppAction.increment);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // padding: const EdgeInsets.all(20),
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
          FutureBuilder(
            future: getCompany(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return shopeName(snapshot.data);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                  widthFactor: 30,
                  heightFactor: 30,
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TitlePriceRating(
              nome: widget.nome,
              preco: widget.preco,
              // tamanho: widget.tamanho,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 80,
                child: ListView(
                  children: [
                    Text(
                      // maxLines: 3,
                      // overflow: TextOverflow.ellipsis,
                      widget.descricao,
                      style: const TextStyle(
                        // height: 1.5,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(height: size.height * 0.1),
          // const SizedBox(height: 25),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            margin: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 35,
                  height: 25,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF5767FE),
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
                Container(
                  width: 35,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$numOfItems",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 35,
                  height: 25,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF5767FE),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Row(
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
                    child: status == 'none'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // const Icon(
                              //   Icons.shopping_cart,
                              //   color: Colors.white,
                              // ),
                              const FaIcon(
                                FontAwesomeIcons.basketShopping,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              TextButton(
                                onPressed: () => addToCart(),
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
                          )
                        : status == 'done'
                            ? Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: const Color(0xFF5767FE),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 1.0,
                                        )
                                      ],
                                    ),
                                    width: 30,
                                    height: 30,
                                    child: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.all(9.0),
                                child: Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  ),
                                ),
                              ),
                  ),
                ),
              ],
            ),
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

  Widget shopeName(name) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.location_on,
            color: Color(0xFF5767FE),
          ),
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
