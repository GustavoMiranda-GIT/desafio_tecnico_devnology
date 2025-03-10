import 'package:desafio_tecnico_devnology/controllers/flights_list_controller.dart';
import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:desafio_tecnico_devnology/project_widgets/flight_list_item.dart';
import 'package:flutter/material.dart';

class SelectedFlightsPage extends StatelessWidget {
  final FlightsListController listController;

  const SelectedFlightsPage({super.key, required this.listController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( AppLocalizations.of(context)!.selected),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      body: Column(
        children: [
          FlightListItem(flight: listController.flightOrigin, listController: listController),

          Visibility(visible: listController.searchType == SearchType.round,child: FlightListItem(flight: listController.flightDestination, listController: listController)),
        ],

      ),
    );
  }




}
