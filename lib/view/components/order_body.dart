import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:menu_on/redux/app_store.dart';
import 'package:menu_on/services/payments.dart';
import 'package:menu_on/view/components/order_button.dart';
/* import 'package:flutter_svg/svg.dart'; */

import '../../models/Cart.dart';
import 'cart_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:menu_on/services/companies.dart';
import 'package:menu_on/services/orders.dart';
import 'dart:convert' as convert;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String order_products;
  final _companies = Companies();
  final _orders = Orders();
  final _payments = Payments();
  Future<String> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    // product = {'idProduct': widget.idProduct, 'numOfItems': numOfItems};
    order_products = prefs.getString('order_products') as String;
    // print('order_products');
    // print(order_products);
    return order_products;
    // return convert.jsonDecode(order_products);
  }

  // void messageAlert(
  //   String title,
  //   String message,
  // ) {
  //   showDialog<String>(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: Text(title),
  //       content: Text(
  //         message,
  //         style: const TextStyle(
  //           color: Colors.black,
  //           fontSize: 13.0,
  //         ),
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context, 'OK');
  //             setState(() {
  //               status = 'none';
  //             });
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

//   Future<void> postOrder() async {
//     // messageAlert(
//     //   'Pedido realizado com sucesso',
//     //   "Seu pedido foi realizado com sucesso e ele será servido em breve.\nPara realizar o pagamento, acesse o Menu na página inicial, selecione o pedido e realize o pagamento.",
//     // );

//     // AwesomeDialog(
//     //   context: context,
//     //   headerAnimationLoop: false,
//     //   // dialogType: DialogType.success,
//     //   customHeader: Icon(
//     //     Icons.check_circle,
//     //     size: 110,
//     //     color: const Color(0xFF5767FE),
//     //   ),
//     //   title: 'No Header',
//     //   desc:
//     //       'Dialog description here..................................................',
//     //   btnOkOnPress: () {
//     //     debugPrint('OnClcik');
//     //   },
//     //   btnOkIcon: Icons.check_circle,
//     // ).show();
// // ESSE
//     // AwesomeDialog(
//     //   context: context,
//     //   animType: AnimType.leftSlide,
//     //   headerAnimationLoop: false,
//     //   // dialogType: DialogType.success,
//     //   customHeader: const Icon(
//     //     Icons.check_circle,
//     //     size: 110,
//     //     color: Color(0xFF5767FE),
//     //   ),
//     //   showCloseIcon: false,
//     //   title: 'Success',
//     //   desc:
//     //       'Dialog description here..................................................',
//     //   btnOkOnPress: () {
//     //     debugPrint('OnClcik');
//     //   },
//     //   btnOkIcon: Icons.check_circle,
//     //   onDismissCallback: (type) {
//     //     debugPrint('Dialog Dissmiss from callback $type');
//     //   },
//     // ).show();
//     setState(() {
//       status = 'pending';
//     });
//     var diferenca = await validandoLocalizacao();
//     if (diferenca != null && diferenca < 100) {
//       // _createCharge();
//       double total = 0;
//       String formattedPrice;
//       final prefs = await SharedPreferences.getInstance();
//       var orderProducts = prefs.getString('order_products');
//       var company = prefs.getString('company');
//       Map<String, dynamic> parsedCompany =
//           convert.jsonDecode(company as String);
//       Map<String, dynamic> user =
//           convert.jsonDecode(prefs.getString('user') as String);
//       List<dynamic> orderProductsParsed =
//           convert.jsonDecode(orderProducts as String);

//       for (var e in orderProductsParsed) {
//         {
//           if (e['unitPrice'] != null && e['numOfItems'] != null) {
//             formattedPrice = (e['unitPrice'] as String).replaceAll("\$", '');
//             total = total +
//                 (double.parse(formattedPrice) * (e['numOfItems'] as int));
//           }
//         }
//       }
//       var orderResponse = await _orders.postOrder(
//         total,
//         0,
//         1,
//         user['id_user'],
//         1,
//         parsedCompany['id_company'],
//       );
//       await _payments.createPayment(
//         orderResponse['id'],
//         0,
//       );
//       for (var element in orderProductsParsed) {
//         await _orders.postOrderProducts(
//           orderResponse['id'],
//           element['productId'],
//           element['numOfItems'],
//           double.parse(element['unitPrice'] as String),
//           0,
//         );
//       }
//       setState(() {
//         status = 'done';
//       });

//       AwesomeDialog(
//         dismissOnTouchOutside: false,
//         context: context,
//         animType: AnimType.leftSlide,
//         headerAnimationLoop: false,
//         // dialogType: DialogType.success,
//         customHeader: const Icon(
//           Icons.check_circle,
//           size: 110,
//           color: Color(0xFF5767FE),
//         ),
//         showCloseIcon: false,
//         title: 'Pedido realizado com sucesso',
//         desc:
//             'Seu pedido foi realizado com sucesso e ele será servido em breve.\nPara realizar o pagamento, acesse o Menu na página inicial, selecione o pedido e realize o pagamento',
//         btnOkOnPress: () async {
//           await Future.delayed(const Duration(milliseconds: 500));
//           Navigator.pop(context);
//           prefs.remove('order_products');
//         },
//         btnOkIcon: Icons.check_circle,
//         onDismissCallback: (type) {
//           debugPrint('Dialog Dissmiss from callback $type');
//         },
//       ).show();
//     } else {
//       // PEGAR O ID_TABLE PELO QRCODE
//       messageAlert('Localização inválida',
//           "Sua localização não está de acordo com a localização do restaurante");
//     }
//   }

  Future<void> removeFromCart(int index) async {
    final prefs = await SharedPreferences.getInstance();
    var orderProducts = prefs.getString('order_products');
    List<dynamic> orderProductsParsed =
        convert.jsonDecode(orderProducts as String);
    orderProductsParsed.removeAt(index);

    setState(() {
      if (orderProductsParsed.isEmpty) {
        prefs.remove('order_products');
      } else {
        prefs.setString(
            'order_products', convert.jsonEncode(orderProductsParsed));
      }
    });

    appStore.dispatcher(AppAction.increment);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.infinity,
      // width: double.infinity,
      color: const Color(0xff181920),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder(
            future: getProducts(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text(
                    'Nenhum produto encontrado',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Text('Erro ao carregar os produtos.');
              }
              if (snapshot.hasData) {
                final List<dynamic> data = convert
                    .jsonDecode(snapshot.data as String) as List<dynamic>;
                print(data);
                // final List<dynamic> products = data['products'];
                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async {
                              AwesomeDialog(
                                dismissOnTouchOutside: false,
                                context: context,
                                animType: AnimType.leftSlide,
                                headerAnimationLoop: false,
                                dialogType: DialogType.noHeader,
                                // customHeader: const Icon(
                                //   Icons.info,
                                //   size: 110,
                                //   color: Color(0xFF5767FE),
                                // ),
                                showCloseIcon: false,
                                title: 'Remover item do carrinho',
                                desc:
                                    'Tem certeza que deseja remover o item ${data[index]["numOfItems"]} do carrinho?',
                                // btnOkOnPress: () {
                                //   removeFromCart(index);
                                // },
                                // btnCancelOnPress: () {
                                //   setState(() {});
                                //   debugPrint('OnClcik');
                                // },
                                // btnCancelText: 'Não',
                                // btnOkText: 'Sim',
                                btnOk: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    removeFromCart(index);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    primary: const Color.fromARGB(
                                        255, 206, 210, 252),
                                    backgroundColor: const Color(0xFF5767FE),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                    side: const BorderSide(
                                      color: Color(0xFF5767FE),
                                    ),
                                  ),
                                  child: const Text(
                                    'Sim',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.of(context).pop();
                                //     removeFromCart(index);
                                //   },
                                //   child: Container(
                                //     padding: const EdgeInsets.all(5.0),
                                //     decoration: BoxDecoration(
                                //       color: const Color(0xFF5767FE),
                                //       border: Border.all(
                                //         color: const Color(0xFF5767FE),
                                //         width: 1.0,
                                //         style: BorderStyle.solid,
                                //       ),
                                //       borderRadius: BorderRadius.circular(100),
                                //     ),
                                //     child: const Center(
                                //       child: Text(
                                //         'Sim',
                                //         style: TextStyle(
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                btnCancel: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                  style: OutlinedButton.styleFrom(
                                    primary: const Color(0xFF5767FE),
                                    // shadowColor: Color(0xFF5767FE),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                    side: const BorderSide(
                                      color: Color(0xFF5767FE),
                                    ),
                                  ),
                                  child: const Text(
                                    'Não',
                                    style: TextStyle(
                                      color: Color(0xFF5767FE),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                // GestureDetector(
                                //   onTap: () {
                                // Navigator.of(context).pop();
                                // setState(() {});
                                //   },
                                //   child: Container(
                                //     padding: const EdgeInsets.all(5.0),
                                //     decoration: BoxDecoration(
                                //       color: const Color.fromARGB(
                                //           255, 188, 195, 255),
                                //       border: Border.all(
                                //         color: const Color(0xFF5767FE),
                                //         width: 1.0,
                                //         style: BorderStyle.solid,
                                //       ),
                                //       borderRadius: BorderRadius.circular(100),
                                //     ),
                                //     child: const Center(
                                //       child: Text(
                                //         'Não',
                                //         style: TextStyle(
                                //           color: Color(0xFF5767FE),
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                btnOkColor: const Color(0xFF5767FE),
                                btnOkIcon: Icons.check_circle,
                                onDismissCallback: (type) {
                                  debugPrint(
                                      'Dialog Dissmiss from callback $type');
                                },
                              ).show();
                              // setState(() {
                              //   // demoCarts.removeAt(index);
                              //   // print('REMOVER DO CARRINHO');
                              // });
                            },
                            background: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xff181920),
                                // color: Color(0xFFFFE6E6),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: const [
                                  Spacer(),
                                  /* SvgPicture.asset("assets/icons/Trash.svg"), */
                                ],
                              ),
                            ),
                            child: CartCard(product: data[index]),
                          ),
                        ),
                      ),
                    ),
                    const OrderButton(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Expanded(
                    //       child: Container(
                    //         margin: const EdgeInsets.only(
                    //           top: 20,
                    //           bottom: 20.0,
                    //         ),
                    //         // padding: const EdgeInsets.all(1),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(4),
                    //           color: const Color(0xFF5767FE),
                    //           boxShadow: const [
                    //             BoxShadow(
                    //               color: Colors.black,
                    //               blurRadius: 15.0,
                    //             )
                    //           ],
                    //         ),
                    //         child: TextButton(
                    //           onPressed: () {
                    //             postOrder();
                    //           },
                    //           child: status == 'none'
                    //               ? const Text(
                    //                   'Realizar pedido',
                    //                   style: TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 15.0,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 )
                    //               : status == 'pending'
                    //                   ? const SizedBox(
                    //                       width: 30,
                    //                       height: 30,
                    //                       child: CircularProgressIndicator(
                    //                         color: Colors.white,
                    //                         strokeWidth: 2.5,
                    //                       ),
                    //                     )
                    //                   : Center(
                    //                       child: Container(
                    //                         decoration: BoxDecoration(
                    //                           borderRadius:
                    //                               BorderRadius.circular(100.0),
                    //                           color: const Color(0xFF5767FE),
                    //                           boxShadow: const [
                    //                             BoxShadow(
                    //                               color: Colors.black,
                    //                               blurRadius: 1.0,
                    //                             )
                    //                           ],
                    //                         ),
                    //                         width: 30,
                    //                         height: 30,
                    //                         child: const Icon(
                    //                           Icons.done,
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                );
              }
            },
          )
          // ListView.builder(
          //   itemCount: demoCarts.length,
          //   itemBuilder: (context, index) => Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 10),
          //     child: Dismissible(
          //       key: Key(demoCarts[index].product.id.toString()),
          //       direction: DismissDirection.endToStart,
          //       onDismissed: (direction) {
          //         setState(() {
          //           demoCarts.removeAt(index);
          //         });
          //       },
          //       background: Container(
          //         padding: const EdgeInsets.symmetric(horizontal: 20),
          //         decoration: BoxDecoration(
          //           color: const Color(0xff181920),
          //           // color: Color(0xFFFFE6E6),
          //           borderRadius: BorderRadius.circular(15),
          //         ),
          //         child: Row(
          //           children: const [
          //             Spacer(),
          //             /* SvgPicture.asset("assets/icons/Trash.svg"), */
          //           ],
          //         ),
          //       ),
          //       child: CartCard(cart: demoCarts[index]),
          //     ),
          //   ),
          // ),
          ),
    );
  }

  // String status = 'none';
  // Widget button() {
  //   Future<Position> _determinePosition() async {
  //     bool serviceEnabled;
  //     LocationPermission permission;

  //     // Test if location services are enabled.
  //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       // Location services are not enabled don't continue
  //       // accessing the position and request users of the
  //       // App to enable the location services.
  //       return Future.error('Location services are disabled.');
  //     }

  //     permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         // Permissions are denied, next time you could try
  //         // requesting permissions again (this is also where
  //         // Android's shouldShowRequestPermissionRationale
  //         // returned true. According to Android guidelines
  //         // your App should show an explanatory UI now.
  //         return Future.error('Location permissions are denied');
  //       }
  //     }

  //     if (permission == LocationPermission.deniedForever) {
  //       // Permissions are denied forever, handle appropriately.
  //       return Future.error(
  //           'Location permissions are permanently denied, we cannot request permissions.');
  //     }

  //     // When we reach here, permissions are granted and we can
  //     // continue accessing the position of the device.
  //     return await Geolocator.getCurrentPosition();
  //   }

  //   validandoLocalizacao() async {
  //     double latRestaurante = 0.0;
  //     double longRestaurante = 0.0;
  //     String? company = '';
  //     Map<String, dynamic> parsedCompany;
  //     final prefs = await SharedPreferences.getInstance();
  //     company = prefs.getString('company');
  //     if (company != null) {
  //       parsedCompany = convert.jsonDecode(company);
  //       var currentLoc = await _determinePosition();
  //       var lat = currentLoc.latitude;
  //       var long = currentLoc.longitude;
  //       print('currentLoc');
  //       final response =
  //           await _companies.getCompany('${parsedCompany["id_company"]}');
  //       latRestaurante = double.parse(response['latitude']);
  //       longRestaurante = double.parse(response['longitude']);
  //       var diferenca = GeolocatorPlatform.instance.distanceBetween(
  //         lat,
  //         long,
  //         latRestaurante,
  //         longRestaurante,
  //       );
  //       // var diferenca = GeolocatorPlatform.instance.distanceBetween(
  //       //   -20.7975102,
  //       //   -49.4003299,
  //       //   -20.7975102,
  //       //   -49.4003299,
  //       // );

  //       print('diferenca');
  //       print(diferenca);

  //       return diferenca;
  //     }
  //   }

  //   Future<void> postOrder() async {
  //     setState(() {
  //       status = 'pending';
  //     });
  //     var diferenca = await validandoLocalizacao();
  //     if (diferenca != null && diferenca < 100) {
  //       // _createCharge();
  //       double total = 0;
  //       String formattedPrice;
  //       final prefs = await SharedPreferences.getInstance();
  //       var orderProducts = prefs.getString('order_products');
  //       var company = prefs.getString('company');
  //       Map<String, dynamic> parsedCompany =
  //           convert.jsonDecode(company as String);
  //       Map<String, dynamic> user =
  //           convert.jsonDecode(prefs.getString('user') as String);
  //       List<dynamic> orderProductsParsed =
  //           convert.jsonDecode(orderProducts as String);

  //       for (var e in orderProductsParsed) {
  //         {
  //           if (e['unitPrice'] != null && e['numOfItems'] != null) {
  //             formattedPrice = (e['unitPrice'] as String).replaceAll("\$", '');
  //             total = total +
  //                 (double.parse(formattedPrice) * (e['numOfItems'] as int));
  //           }
  //         }
  //       }
  //       // var orderResponse = await _orders.postOrder(
  //       //   total,
  //       //   0,
  //       //   1,
  //       //   user['id_user'],
  //       //   1,
  //       //   parsedCompany['id_company'],
  //       // );
  //       // await _payments.createPayment(
  //       //   orderResponse['id'],
  //       //   0,
  //       // );
  //       // for (var element in orderProductsParsed) {
  //       //   await _orders.postOrderProducts(
  //       //     orderResponse['id'],
  //       //     element['productId'],
  //       //     element['numOfItems'],
  //       //     double.parse(element['unitPrice'] as String),
  //       //     0,
  //       //   );
  //       // }
  //       setState(() {
  //         status = 'done';
  //       });

  //       AwesomeDialog(
  //         dismissOnTouchOutside: false,
  //         context: context,
  //         animType: AnimType.leftSlide,
  //         headerAnimationLoop: false,
  //         // dialogType: DialogType.success,
  //         customHeader: const Icon(
  //           Icons.check_circle,
  //           size: 110,
  //           color: Color(0xFF5767FE),
  //         ),
  //         showCloseIcon: false,
  //         title: 'Pedido realizado com sucesso',
  //         desc:
  //             'Seu pedido foi realizado com sucesso e ele será servido em breve.\nPara realizar o pagamento, acesse o Menu na página inicial, selecione o pedido e realize o pagamento',
  //         btnOkOnPress: () async {
  //           await Future.delayed(const Duration(milliseconds: 500));
  //           Navigator.pop(context);
  //           prefs.remove('order_products');
  //         },
  //         btnOkIcon: Icons.check_circle,
  //         onDismissCallback: (type) {
  //           debugPrint('Dialog Dissmiss from callback $type');
  //         },
  //       ).show();
  //     } else {
  //       // PEGAR O ID_TABLE PELO QRCODE
  //       // messageAlert('Localização inválida',
  //       //     "Sua localização não está de acordo com a localização do restaurante");
  //       AwesomeDialog(
  //         dismissOnTouchOutside: false,
  //         context: context,
  //         animType: AnimType.leftSlide,
  //         headerAnimationLoop: false,
  //         // dialogType: DialogType.success,
  //         customHeader: const Icon(
  //           Icons.check_circle,
  //           size: 110,
  //           color: Color(0xFF5767FE),
  //         ),
  //         showCloseIcon: false,
  //         title: 'Pedido realizado com sucesso',
  //         desc:
  //             'Seu pedido foi realizado com sucesso e ele será servido em breve.\nPara realizar o pagamento, acesse o Menu na página inicial, selecione o pedido e realize o pagamento',
  //         btnOkOnPress: () async {
  //           await Future.delayed(const Duration(milliseconds: 500));
  //           Navigator.pop(context);
  //           // prefs.remove('order_products');
  //         },
  //         btnOkIcon: Icons.check_circle,
  //         onDismissCallback: (type) {
  //           debugPrint('Dialog Dissmiss from callback $type');
  //         },
  //       ).show();
  //     }
  //   }

  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Expanded(
  //         child: Container(
  //           margin: const EdgeInsets.only(
  //             top: 20,
  //             bottom: 20.0,
  //           ),
  //           // padding: const EdgeInsets.all(1),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(4),
  //             color: const Color(0xFF5767FE),
  //             boxShadow: const [
  //               BoxShadow(
  //                 color: Colors.black,
  //                 blurRadius: 15.0,
  //               )
  //             ],
  //           ),
  //           child: TextButton(
  //             onPressed: () {
  //               postOrder();
  //             },
  //             child: status == 'none'
  //                 ? const Text(
  //                     'Realizar pedido',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 15.0,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   )
  //                 : status == 'pending'
  //                     ? const SizedBox(
  //                         width: 30,
  //                         height: 30,
  //                         child: CircularProgressIndicator(
  //                           color: Colors.white,
  //                           strokeWidth: 2.5,
  //                         ),
  //                       )
  //                     : Center(
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(100.0),
  //                             color: const Color(0xFF5767FE),
  //                             boxShadow: const [
  //                               BoxShadow(
  //                                 color: Colors.black,
  //                                 blurRadius: 1.0,
  //                               )
  //                             ],
  //                           ),
  //                           width: 30,
  //                           height: 30,
  //                           child: const Icon(
  //                             Icons.done,
  //                             color: Colors.white,
  //                           ),
  //                         ),
  //                       ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
