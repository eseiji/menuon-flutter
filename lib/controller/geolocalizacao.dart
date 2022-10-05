import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:geolocator/geolocator.dart';

validandoLocalizacao(double latitude, double logitude) async {
  double latRestaurante = 0.0;
  double longRestaurante = 0.0;
//TODO: COLOCAR A URL CERTA a
  var url = Uri.parse('https://menuon-api.herokuapp.com/geolocation ');
  final response = await http.get(url);
  if (response.statusCode == 201) {
    var jsonResponse = await convert.jsonDecode(response.body);
    //TODO: PEDIR PRO ENZAO FAZER ESSA ROTA
    latRestaurante = jsonResponse['latitude'];
    longRestaurante = jsonResponse['longitude'];
  } else {
    print('erro');
    // throw Exception('Error status code: ${response.statusCode}');
  }

  var diferenca = GeolocatorPlatform.instance
      .distanceBetween(latitude, logitude, latRestaurante, longRestaurante);

  return diferenca;
}
