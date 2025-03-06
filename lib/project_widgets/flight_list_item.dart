import 'package:desafio_tecnico_devnology/models/flight_model.dart';
import 'package:flutter/material.dart';


class FlightListItem extends StatelessWidget {
  final Flight flight;

  const FlightListItem({super.key, required this.flight});


  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        tileColor: Theme.of(context).colorScheme.primary,
        leading: Column(
            children: [
              Text(flight.origin),
              Text(flight.boarding)
            ]
        )
    );
  }
}
