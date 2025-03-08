import 'package:desafio_tecnico_devnology/models/connection_model.dart';
import 'package:desafio_tecnico_devnology/models/price_model.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';


class Flight {
  final String company;
  final String direction;
  final String origin;
  final String destination;
  final DateTime boarding;
  final DateTime landing;
  final List<Connection> connections;
  final int nConnections;
  final String duration;
  final String flightNumber;
  final List<Price> prices;
  final List<Price> miles;

  late final String boardingTime = DateFormat.Hm().format(boarding);
  late final String landingTime = DateFormat.Hm().format(landing);

  Flight({required this.company,required this.direction,required this.origin,required this.destination,required this.boarding,required this.landing,
    required this.connections,required this.nConnections,required this.duration,required this.flightNumber,required this.prices,required this.miles});

  factory Flight.fromJson(Map<String, dynamic> json){
    return Flight(
        company: json['Companhia'],
        direction: json['Sentido'],
        origin: json['Origem'],
        destination: json['Destino'],
        boarding: parseDate(json['Embarque']),
        landing: parseDate(json['Desembarque']),
        connections: parseConnections(json['Conexoes']),
        nConnections: json['NumeroConexoes'],
        duration: json['Duracao'],
        flightNumber: json['NumeroVoo'],
        prices: parsePrices(json['Valor']),
        miles: parsePrices(json['Milhas']),
    );
  }



  static List<Price> parsePrices(jsonPrices){
    List<Price> listPrices=[];

    for (var e in (jsonPrices as List)) {
      listPrices.add(Price.fromJson(e));
    }

    return listPrices;
  }

  static List<Connection> parseConnections(jsonConnections){
    List<Connection> listConnections=[];

    for (var e in (jsonConnections as List)) {
      listConnections.add(Connection.fromJson(e));
    }

    return listConnections;
  }

  static DateTime parseDate(String inputDate){
    DateFormat date = DateFormat('dd/MM/yyyy HH:mm');
    DateTime finalDate = date.parse(inputDate);
    return finalDate;
  }

  void printFlight(){
    debugPrint('company: $company');
    debugPrint('direction: $direction');
    debugPrint('origin: $origin');
    debugPrint('destination: $destination');
    debugPrint('boarding: $boarding');
    debugPrint('landing: $landing');
    debugPrint('connections:');
    for (var e in connections) {
      e.printConnection();
      debugPrint('-----------------------');
    }
    debugPrint('nConnections: $nConnections');
    debugPrint('duration: $duration');
    debugPrint('flightNumber: $flightNumber');
    debugPrint('prices:');
    for (var e in prices) {
      e.printPrice();
      debugPrint('-----------------------');
    }
    debugPrint('miles:');
    for (var e in miles) {
      e.printPrice();
      debugPrint('-----------------------');
    }

  }

}