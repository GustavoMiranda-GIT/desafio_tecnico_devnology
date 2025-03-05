import 'dart:convert';
import 'package:desafio_tecnico_devnology/models/airport_model.dart';
import 'package:desafio_tecnico_devnology/models/flight_model.dart';
import 'package:http/http.dart' as http;



const String BASE_URL = 'https://buscamilhas.mock.gralmeidan.dev/';
const String AIRPORTS_URL = 'aeroportos?q=BHZ';
const String TICKETS_CODE_URL = 'busca/criar';
const String TICKETS_LIST_URL = 'busca/';

class DatabaseApi {

  static Future<Airport> fetchAirports() async {

    final response = await http.get(Uri.parse(BASE_URL + AIRPORTS_URL));

    if (response.statusCode == 200) {
      return Airport.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load airports');
    }
  }

  static Future<String> fetchTicketsCode(List<String> companies, String departure, String returnDate,
      String origin, String destination, String type) async {

    final response = await http.post(
        Uri.parse(BASE_URL + TICKETS_CODE_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
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

  static Future<Flight> fetchTicketsList(String searchCode) async {

    final response = await http.get(Uri.parse(BASE_URL + TICKETS_LIST_URL + searchCode));
    final allFlights = jsonDecode(response.body)['Voos'];

    if (response.statusCode == 200) {
      //print(allFlights[0]);
      Flight flight = Flight.fromJson(allFlights[0] as Map<String, dynamic>);

      return flight;
    } else {
      throw Exception('Failed to load tickets list');
    }


  }


}
