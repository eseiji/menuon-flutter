import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerencianet/gerencianet.dart';
import 'package:menu_on/options.dart';
import 'package:menu_on/services/payments.dart';
import 'dart:typed_data';
/* import 'package:flutter_svg/svg.dart'; */
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class PaymentBody extends StatefulWidget {
  @override
  _PaymentBodyState createState() => _PaymentBodyState();
}

class _PaymentBodyState extends State<PaymentBody> {
  late Map<String, dynamic> orderHistoryProducts;
  String status = 'none';
  final _payments = Payments();
  late double orderTotal = 0;
  Uint8List? _byteImage;
  String? _copyAndPastePix;
  // Future<Map<String, dynamic>> getPaymentInfo() async {
  //   setState(() {
  //     status = 'pending';
  //   });
  //   final prefs = await SharedPreferences.getInstance();
  //   var id_order = prefs.getString('id_order') as String;
  //   order_history_products =
  //       await _orderHistory.getOrderHistoryProducts(int.parse(id_order));
  //   prefs.setString(
  //     'order_history_products',
  //     convert.jsonEncode(order_history_products),
  //   );
  //   setState(() {
  //     orderTotal = double.parse(order_history_products['total']);
  //     status = 'done';
  //   });
  //   return order_history_products;
  // }

  Future<void> _createCharge() async {
    // setState(() {
    //   status = 'pending';
    // });
    final prefs = await SharedPreferences.getInstance();
    String orderHistoryProducts =
        prefs.getString('order_history_products') as String;
    Map<String, dynamic> parsedOrderHistoryProducts =
        convert.jsonDecode(orderHistoryProducts);

    Gerencianet gn = Gerencianet(OPTIONS);

    if (double.parse(parsedOrderHistoryProducts['total']) < 1) {
      parsedOrderHistoryProducts['total'] =
          (parsedOrderHistoryProducts['total'] as String).padRight(
        (parsedOrderHistoryProducts['total'] as String).length,
        "0",
      );
    } else {
      parsedOrderHistoryProducts['total'] =
          (parsedOrderHistoryProducts['total'] as String).padRight(
        (parsedOrderHistoryProducts['total'] as String).length + 1,
        "0",
      );
    }

    Map<String, dynamic> body = {
      "calendario": {
        "expiracao": int.parse("3600"),
      },
      "valor": {
        "original": (parsedOrderHistoryProducts['total'] as String).padRight(
          (parsedOrderHistoryProducts['total'] as String).length,
          "0",
        ), // string
      },
      "chave": "9132e2ec-b7b2-45c0-8edc-8648b1051bc2",
    };
    // await Future.delayed(const Duration(seconds: 2), () => 'Complete');
    // setState(() {
    //   _byteImage = Uint8List.fromList([0, 2, 5, 7, 42, 255]);
    //   _copyAndPastePix = '23281938d9jqhjjd79hd';
    // });

    gn.call("pixCreateImmediateCharge", body: body).then((value) async {
      gn.call("pixGenerateQRCode", params: {"id": value['loc']['id']}).then(
        (value) {
          setState(() {
            _byteImage = const convert.Base64Decoder()
                .convert(value['imagemQrcode'].split(',').last);
            _copyAndPastePix = value['qrcode'];
          });
          print('_byteImage');
          print(_byteImage);
        },
      );
      await _payments.updatePayment(
        parsedOrderHistoryProducts['Payment']['id_payment'],
        value['txid'],
        0,
      );
    }).catchError((onError) => print(onError));
  }

  @override
  void initState() {
    _createCharge();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff181920),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    color: const Color(0xFF252A34),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: _byteImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.memory(_byteImage!.buffer.asUint8List(),
                              fit: BoxFit.fitHeight),
                        )
                      : const Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          ),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            _copyAndPastePix != null
                ? Container(
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xFF5767FE),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 5.0,
                        )
                      ],
                    ),
                    child: TextButton(
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: _copyAndPastePix),
                          );
                        },
                        child: const Text(
                          'PIX copia e cola',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
