import 'package:flutter/foundation.dart';

class Connection{
  final String origin;
  final String destination;
  final String flightNumber;
  final String duration;
  final String landingDate;
  final String landingTime;
  final String landingComplete;
  final String boardingDate;
  final String boardingTime;
  final String boardingComplete;

  const Connection({required this.origin,required this.destination,required this.flightNumber,required this.duration,required this.landingDate,
    required this.landingTime,required this.landingComplete,required this.boardingDate,required this.boardingTime,required this.boardingComplete});

  factory Connection.fromJson(Map<String, dynamic> json){
    return Connection(
        origin: json['Origem'],
        destination: json['Destino'],
        flightNumber: json['NumeroVoo'],
        duration: json['Duracao'],
        landingDate: json['DataDesembarque'],
        landingTime: json['Desembarque'],
        landingComplete: json['DesembarqueCompleto'],
        boardingDate: json['DataEmbarque'],
        boardingTime: json['Embarque'],
        boardingComplete: json['EmbarqueCompleto']
    );
  }

  void printConnection()
  {
    debugPrint('   origin: $origin');
    debugPrint('   destination: $destination');
    debugPrint('   flightNumber: $flightNumber');
    debugPrint('   duration: $duration');
    debugPrint('   landingDate: $landingDate');
    debugPrint('   landingTime: $landingTime');
    debugPrint('   landingComplete: $landingComplete');
    debugPrint('   boardingDate: $boardingDate');
    debugPrint('   boardingTime: $boardingTime');
    debugPrint('   boardingComplete: $boardingComplete');
  }


}


