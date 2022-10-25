import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Orders {
  Future<dynamic> postOrder(
      double total, int status, int id_table, int id_customer) async {
    var url = Uri.parse('https://menuon-api.herokuapp.com/order');
    final response = await http.post(url,
        headers: {},
        body: convert.jsonEncode({
          'total': total,
          'status': status,
          'id_table': id_table,
          'id_customer': id_customer
        }));
    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body);
      return jsonResponse;
    }
    return response.statusCode;
  }

  Future<int> postOrderProducts(int id_order, int id_product, int quantity_sold,
      double product_price, int status) async {
    var url = Uri.parse('https://menuon-api.herokuapp.com/order_products');
    final response = await http.post(url,
        headers: {},
        body: convert.jsonEncode({
          'id_order': id_order,
          'id_product': id_product,
          'quantity_sold': quantity_sold,
          'product_price': product_price,
          'status': status
        }));
    return response.statusCode;
  }
}
