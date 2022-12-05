import 'package:gerencianet/gerencianet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:menu_on/options.dart';

class OrderHistory {
  Future<List<dynamic>> getOrderHistory(
    int idUser,
    int idCompany,
    int idTable,
  ) async {
    var url = Uri.parse(
      'https://menuon-api.herokuapp.com/order_history/$idUser/$idCompany/$idTable',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = await convert.jsonDecode(response.body);
      for (var element in jsonResponse) {
        if (element['identification'] != null && element['status'] == 0) {
          var paymentInfo = await getPaymentStatus(element['identification']);
          if (paymentInfo['status'] == 'CONCLUIDA') {
            var value = paymentInfo['pix'][0]['horario'];
            var splittedDate = value.split("T");
            var date = splittedDate[0];
            var hour = splittedDate[1];
            // .split(".");
            var formattedDate = '$date $hour';
            await updatePaymentStatus(
              element['id_payment'],
              status: 1,
              paymentDate: formattedDate,
            );
            element['status'] = 1;
          }
        }
      }
      return jsonResponse;
    } else {
      return Future.error('Nenhum pedido foi encontrado.');
    }
  }

  Future<Map<String, dynamic>> getPaymentStatus(String identification) async {
    Gerencianet gn = Gerencianet(OPTIONS);
    var sim = await gn.call(
      'pixDetailCharge',
      params: {"txid": identification},
    );
    return sim;
  }

  Future<void> updatePaymentStatus(
    int idPayment, {
    int? status,
    String? paymentDate,
  }) async {
    var url = Uri.https('menuon-api.herokuapp.com', '/update_payment');
    await http.post(url, body: {
      'id_payment': '$idPayment',
      'status': '$status',
      'payment_date': '$paymentDate',
    });
    // if (response.statusCode == 200) {
    //   var jsonResponse = await convert.jsonDecode(response.body);
    //   return jsonResponse;
    // } else {
    //   return Future.error('Nenhum pedido foi encontrado.');
    // }
  }

  Future<Map<String, dynamic>> getOrderHistoryProducts(int idOrder) async {
    var url = Uri.https('menuon-api.herokuapp.com', '/orders/$idOrder');
    // var url = Uri.parse(
    //   'https://menuon-api.herokuapp.com/order_history/$idUser/$idCompany/$idTable',
    // );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return Future.error('Nenhum produto foi encontrado.');
    }
  }
}
