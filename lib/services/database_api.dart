import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:desafio_tecnico_devnology/models/models.dart';

const String BASE_URL = 'https://buscamilhas.mock.gralmeidan.dev/';
const String AIRPORTS_URL = 'aeroportos?q=BHZ';

class DatabaseApi {

  static Future<Airport> fetchAirports() async {

    final response = await http.get(Uri.parse(BASE_URL + AIRPORTS_URL));

    if (response.statusCode == 200) {
      return Airport.fromJson(jsonDecode(response.body)[0] as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load airports');
    }
  }

}
