import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Companies {
  Future<Map<String, dynamic>> getCompany(String idCompany) async {
    var url = Uri.parse('https://menuon-api.herokuapp.com/company/$idCompany');
    final response = await http.get(url);
    if (response.statusCode == 201) {
      var jsonResponse = await convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return {"statusCode": response.statusCode};
      // throw Exception('Error status code: ${response.statusCode}');
    }
  }
}
