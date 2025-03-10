import 'dart:convert';
import 'package:desafio_tecnico_devnology/models/airport_model.dart';
import 'package:desafio_tecnico_devnology/models/flight_model.dart';
import 'package:http/http.dart' as http;

//Chaves da API devem ser criptografadas futuramente
const String BASE_URL = 'https://buscamilhas.mock.gralmeidan.dev/';
const String AIRPORTS_URL = 'aeroportos';
const String TICKETS_CODE_URL = 'busca/criar';
const String TICKETS_LIST_URL = 'busca/';

class DatabaseApi {

  static Future<List<Airport>> fetchAirports() async {
    final response = await http.get(Uri.parse(BASE_URL + AIRPORTS_URL));

    if (response.statusCode == 200) {
      final jsonAirportsList = jsonDecode(response.body) as List;
      return jsonAirportsList.map((json)=> Airport.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load airports');
    }
  }

  static Future<String> fetchFlightsListCode(List<String> companies, String departure, String returnDate,
      String origin, String destination, String type) async {

    final response = await http.post(
        Uri.parse(BASE_URL + TICKETS_CODE_URL),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic> {
        "Companhias": companies,
        "DataIda": departure,
        "DataVolta": returnDate,
        "Origem": origin,
        "Destino": destination,
        "Tipo": type
        }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['Busca'];
    } else {
      throw Exception('Failed to load tickets code');
    }

  }

  static Future<List<Flight>> fetchFlightsList(String searchCode) async {

    final response = await http.get(Uri.parse(BASE_URL + TICKETS_LIST_URL + searchCode));

    if (response.statusCode == 200) {
      final jsonFlightList = jsonDecode(response.body)['Voos'] as List;
      return jsonFlightList.map((json)=> Flight.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load flights list');
    }

  }

}