import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Categories {
  Future<Map<String, dynamic>> getCategories(int idCompany) async {
    var url =
        Uri.parse('https://menuon-api.herokuapp.com/categories/$idCompany');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return Future.error('Nenhuma categoria foi encontrada.');
      // return {"statusCode": response.statusCode};
      // throw Exception('Error status code: ${response.statusCode}');
    }
  }
}
