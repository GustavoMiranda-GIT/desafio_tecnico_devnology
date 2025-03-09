import 'package:flutter/foundation.dart';

class Airport{
  final String iata;
  final String name;
  final String? country;
  final String? countryCode;
  final String? region;
  final String? regionCode;
  final String? continent;
  final String? local;
  final String? subLocal;
  final String? timeZone;
  final List<String>? airports;

  const Airport({required this.iata, required this.name, this.country, this.countryCode, this.region,
    this.regionCode, this.continent, this.local, this.subLocal, this.timeZone, this.airports});

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      iata: json['Iata'],
      name: json['Nome'],
      country: json['Pais'],
      countryCode: json['PaisCodigo'],
      region: json['Regiao'],
      regionCode: json['RegiaoCodigo'],
      continent: json['Continente'],
      local: json['Local'],
      subLocal: json['SubLocal'],
      timeZone: json['FusoHorario'],
      airports: parseAirport(json['Aeroportos']),);
  }


  static List<String> parseAirport(jsonAirports){
    if(jsonAirports == null) {
      return List<String>.empty();
    }

    List<String> listAirports = List<String>.from(jsonAirports);
    return listAirports;
  }

  void printAirport(){
    debugPrint('iata: $iata');
    debugPrint('name: $name');
    debugPrint('country: $country');
    debugPrint('countryCode: $countryCode');
    debugPrint('region: $region');
    debugPrint('regionCode: $regionCode');
    debugPrint('continent: $continent');
    debugPrint('local: $local');
    debugPrint('subLocal: $subLocal');
    debugPrint('timeZone: $timeZone');
    debugPrint('airports: $airports');
  }

}