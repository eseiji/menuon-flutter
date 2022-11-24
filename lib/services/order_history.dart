import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class OrderHistory {
  Future<List<dynamic>> getOrderHistory(
      int idUser, int idCompany, int idTable) async {
    var url = Uri.parse(
        'https://menuon-api.herokuapp.com/order_history/$idUser/$idCompany/$idTable');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return Future.error('Nenhum pedido foi encontrado.');
    }
  }
}
