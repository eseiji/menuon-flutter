import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Products {
  Future<Map<String, dynamic>> getProducts(
      int idCompany, int idCategory) async {
    var url = Uri.parse(
        'https://menuon-api.herokuapp.com/products/$idCompany/$idCategory');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return Future.error('Nenhum produto foi encontrado.');
    }
  }

  Future<Map<String, dynamic>> getProduct(int productId) async {
    var url = Uri.parse('https://menuon-api.herokuapp.com/product/$productId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return Future.error('Nenhum produto foi encontrado.');
    }
  }
}
