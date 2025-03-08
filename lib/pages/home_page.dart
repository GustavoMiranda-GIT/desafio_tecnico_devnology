import 'dart:ffi';

import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:desafio_tecnico_devnology/project_widgets/date_text_field.dart';
import 'package:flutter/material.dart';
import 'package:desafio_tecnico_devnology/theme/theme_controller.dart';
import 'package:get/get.dart';
import '../services/database_api.dart';
import 'flights_list_page.dart';

enum FlightType { round, oneWay }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlightType? flightType = FlightType.round;
  int numAdult = 0;
  int numChild = 0;
  int numInfant = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,

      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [

            Material(
              borderRadius: BorderRadius.circular(12),
              elevation: 8,
              child: TextField(
                style: Theme.of(context).textTheme.headlineMedium,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.origin,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: const Icon(Icons.flight_takeoff),
                    )
                )

              ),
            ),
          //------------------------------------------------------------------------------
            Material(
              borderRadius: BorderRadius.circular(12),
              elevation: 8,
              child: TextField(
                  style: Theme.of(context).textTheme.headlineMedium,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.destination,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: const Icon(Icons.flight_land),
                      )
                )
              ),
            ),
          //------------------------------------------------------------------------------
            Row(
              children: [
                Expanded(
                  child: RadioListTile<FlightType>(
                      title: Text(AppLocalizations.of(context)!.round_trip),
                      value: FlightType.round,
                      groupValue: flightType,
                      onChanged: (val){ setState(() {
                        flightType = val;
                      }
                      );
                      }
                  ),
                ),

                Expanded(
                  child: RadioListTile<FlightType>(
                      title: Text(AppLocalizations.of(context)!.one_way),
                      value: FlightType.oneWay,
                      groupValue: flightType,
                      onChanged: (val){ setState(() {
                        flightType = val;
                      }
                      );
                      }
                  ),
                ),
              ],
            ),

            DateTextField(hintText: AppLocalizations.of(context)!.departure),

            Visibility(
              visible: flightType == FlightType.round,
              child: DateTextField(hintText: AppLocalizations.of(context)!.return_string),
            ),

            Material(
              borderRadius: BorderRadius.circular(12),
              elevation: 8,
              child: TextField(
                  style: Theme.of(context).textTheme.headlineMedium,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.company,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: const Icon(Icons.business_sharp),
                      )
                  )
              ),
            ),
            //------------------------------------------------------------------------------
            ElevatedButton(
              onPressed: () async {
                List<String> c = ["AMERICAN AIRLINES", "GOL", "IBERIA", "INTERLINE", "LATAM", "AZUL", "TAP"];
                String searchCode = await DatabaseApi.fetchFlightsListCode(c, "2/12/2025", "20/12/2025", "GRU", "MIA", "IdaVolta");
                //List<Flight> fli = await DatabaseApi.fetchFlightsList(code);
                numAdult=1;
                numChild=1;
                if(searchCode.isNotEmpty) {
                  Get.to(()=>FlightsListPage(searchCode:searchCode,numAdult:numAdult,numChild:numChild,numInfant:numInfant));
                }

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text(AppLocalizations.of(context)!.theme),
            ),

          ],
        ),
      ),
    );
  }
}