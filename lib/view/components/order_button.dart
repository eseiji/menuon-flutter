import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:menu_on/services/payments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:menu_on/services/companies.dart';
import 'package:menu_on/services/orders.dart';
import 'dart:convert' as convert;

class OrderButton extends StatefulWidget {
  const OrderButton({Key? key}) : super(key: key);

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  String status = 'none';
  @override
  Widget build(BuildContext context) {
    final _companies = Companies();
    final _orders = Orders();
    final _payments = Payments();
    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();
    }

    validandoLocalizacao() async {
      double latRestaurante = 0.0;
      double longRestaurante = 0.0;
      String? company = '';
      Map<String, dynamic> parsedCompany;
      final prefs = await SharedPreferences.getInstance();
      company = prefs.getString('company');
      if (company != null) {
        parsedCompany = convert.jsonDecode(company);
        var currentLoc = await _determinePosition();
        var lat = currentLoc.latitude;
        var long = currentLoc.longitude;
        print('currentLoc');
        final response =
            await _companies.getCompany('${parsedCompany["id_company"]}');
        latRestaurante = double.parse(response['latitude']);
        longRestaurante = double.parse(response['longitude']);
        var diferenca = GeolocatorPlatform.instance.distanceBetween(
          lat,
          long,
          latRestaurante,
          longRestaurante,
        );
        // var diferenca = GeolocatorPlatform.instance.distanceBetween(
        //   -20.7975102,
        //   -49.4003299,
        //   -20.7975102,
        //   -49.4003299,
        // );

        print('diferenca');
        print(diferenca);

        return diferenca;
      }
    }

    Future<void> postOrder() async {
      AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        // dialogType: DialogType.success,
        customHeader: const Icon(
          Icons.error,
          size: 110,
          color: Color(0xFF5767FE),
        ),
        showCloseIcon: false,
        title: 'Localização inválida',
        desc:
            'Sua localização não está de acordo com a localização do restaurante',
        btnOkOnPress: () async {
          // await Future.delayed(const Duration(milliseconds: 500));
          // Navigator.pop(context);
          // prefs.remove('order_products');
        },
        btnOkIcon: Icons.check_circle,
        btnOkColor: const Color(0xFF5767FE),
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
      // setState(() {
      //   status = 'pending';
      // });
      // var diferenca = await validandoLocalizacao();
      // if (diferenca != null && diferenca < 100) {
      //   double total = 0;
      //   String formattedPrice;
      //   final prefs = await SharedPreferences.getInstance();
      //   var orderProducts = prefs.getString('order_products');
      //   var company = prefs.getString('company');
      //   Map<String, dynamic> parsedCompany =
      //       convert.jsonDecode(company as String);
      //   Map<String, dynamic> user =
      //       convert.jsonDecode(prefs.getString('user') as String);
      //   List<dynamic> orderProductsParsed =
      //       convert.jsonDecode(orderProducts as String);

      //   for (var e in orderProductsParsed) {
      //     {
      //       if (e['unitPrice'] != null && e['numOfItems'] != null) {
      //         formattedPrice = (e['unitPrice'] as String).replaceAll("\$", '');
      //         total = total +
      //             (double.parse(formattedPrice) * (e['numOfItems'] as int));
      //       }
      //     }
      //   }
      //   var orderResponse = await _orders.postOrder(
      //     total,
      //     0,
      //     1,
      //     user['id_user'],
      //     1,
      //     parsedCompany['id_company'],
      //   );
      //   await _payments.createPayment(
      //     orderResponse['id'],
      //     0,
      //   );
      //   for (var element in orderProductsParsed) {
      //     await _orders.postOrderProducts(
      //       orderResponse['id'],
      //       element['productId'],
      //       element['numOfItems'],
      //       double.parse(element['unitPrice'] as String),
      //       0,
      //     );
      //   }
      //   setState(() {
      //     status = 'done';
      //   });

      //   AwesomeDialog(
      //     dismissOnTouchOutside: false,
      //     context: context,
      //     animType: AnimType.leftSlide,
      //     headerAnimationLoop: false,
      //     // dialogType: DialogType.success,
      //     customHeader: const Icon(
      //       Icons.check_circle,
      //       size: 110,
      //       color: Color(0xFF5767FE),
      //     ),
      //     showCloseIcon: false,
      //     title: 'Pedido realizado com sucesso',
      //     desc:
      //         'Seu pedido foi realizado com sucesso e ele será servido em breve.\nPara realizar o pagamento, acesse o Menu na página inicial, selecione o pedido e realize o pagamento',
      //     btnOkOnPress: () async {
      //       await Future.delayed(const Duration(milliseconds: 500));
      //       Navigator.pop(context);
      //       prefs.remove('order_products');
      //     },
      //     btnOkIcon: Icons.check_circle,
      //     onDismissCallback: (type) {
      //       debugPrint('Dialog Dissmiss from callback $type');
      //     },
      //   ).show();
      // } else {
      //   // PEGAR O ID_TABLE PELO QRCODE
      //   AwesomeDialog(
      //     dismissOnTouchOutside: false,
      //     context: context,
      //     animType: AnimType.leftSlide,
      //     headerAnimationLoop: false,
      //     // dialogType: DialogType.success,
      //     customHeader: const Icon(
      //       Icons.dangerous_rounded,
      //       size: 110,
      //       color: Color(0xFF5767FE),
      //     ),
      //     showCloseIcon: false,
      //     title: 'Localização inválida',
      //     desc:
      //         'Sua localização não está de acordo com a localização do restaurante',
      //     btnOkOnPress: () async {
      //       // await Future.delayed(const Duration(milliseconds: 500));
      //       // Navigator.pop(context);
      //       // prefs.remove('order_products');
      //     },
      //     btnOkIcon: Icons.check_circle,
      //     onDismissCallback: (type) {
      //       debugPrint('Dialog Dissmiss from callback $type');
      //     },
      //   ).show();
      // }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 20.0,
            ),
            // padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0xFF5767FE),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 15.0,
                )
              ],
            ),
            child: TextButton(
              onPressed: () {
                postOrder();
              },
              child: status == 'none'
                  ? const Text(
                      'Realizar pedido',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : status == 'pending'
                      ? const SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
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
            ),
          ),
        ),
      ],
    );
  }
}
