import 'package:flutter/material.dart';
import 'package:desafio_tecnico_devnology/services/database_api.dart';

void main() {
  fetchAirports();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    );
  }
}

Future<void> fetchAirports() async{
  final airport = await DatabaseApi.fetchAirports();
  airport.printAirport();
}
