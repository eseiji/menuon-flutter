import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Payments {
  Future<dynamic> createPayment(
    int id_order,
    int status,
  ) async {
    var url = Uri.https('menuon-api.herokuapp.com', '/insert_payment');
    final response = await http.post(url, body: {
      'id_order': '$id_order',
      'status': '$status',
    });
    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body);
      return jsonResponse;
    }
    return response.statusCode;
  }

  Future<dynamic> updatePayment(
    int id_payment,
    String? identification,
    int? status,
  ) async {
    var url = Uri.https('menuon-api.herokuapp.com', '/update_payment');
    final response = await http.post(url, body: {
      'id_payment': '$id_payment',
      'identification': '$identification',
      'status': '$status',
    });
    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body);
      return jsonResponse;
    }
    return response.statusCode;
  }
}
