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
    List<String> listAirports = List<String>.from(jsonAirports);
    return listAirports;
  }

  void printAirport(){
    debugPrint('iata: ${this.iata}');
    debugPrint('name: ${this.name}');
    debugPrint('country: ${this.country}');
    debugPrint('countryCode: ${this.countryCode}');
    debugPrint('region: ${this.region}');
    debugPrint('regionCode: ${this.regionCode}');
    debugPrint('continent: ${this.continent}');
    debugPrint('local: ${this.local}');
    debugPrint('subLocal: ${this.subLocal}');
    debugPrint('timeZone: ${this.timeZone}');
    debugPrint('airports: ${this.airports}');
  }

}


/* See why it doest work later | Font: https://docs.flutter.dev/cookbook/networking/fetch-data

   factory Airport.fromJson(Map<String, dynamic> json) {
    return switch(json){
      {'Iata': String iata, 'Nome': String name, 'Pais': String country, 'PaisCodigo': String countryCode,
      'Regiao': String region, 'RegiaoCodigo': String regionCode,'Continente': String continent ,
      'Local': String local, 'SubLocal': String subLocal, 'FusoHorario': String timeZone} => Airport(
        iata: iata,
        name: name,
        country: country,
        countryCode: countryCode,
        region: region,
        regionCode: regionCode,
        continent: continent,
        local: local,
        subLocal: subLocal,
        timeZone: timeZone,

      ), _=> throw const FormatException('Failed to parse airport.'),
    };
  }
 */