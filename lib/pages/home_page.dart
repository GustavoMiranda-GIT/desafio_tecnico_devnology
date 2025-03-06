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
  var controller = ThemeController.to;
  FlightType? flightType = FlightType.round;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.origin,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.flight_takeoff),
                )
            )
          ),
        //------------------------------------------------------------------------------
          TextField(
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.destination,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.flight_land),
                )
            )
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
        //------------------------------------------------------------------------------
          Row(
            children: [
              Expanded(
                child: DateTextField(hintText: AppLocalizations.of(context)!.departure),
              ),
              
              Expanded(
                child: Visibility(
                  visible: flightType == FlightType.round,
                  child: DateTextField(hintText: AppLocalizations.of(context)!.return_string),
                ),
              ),
            ],
          ),
        //------------------------------------------------------------------------------
          TextField(
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.company,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.business_sharp),
                  )
              )
          ),
          //------------------------------------------------------------------------------
          TextButton(
            onPressed: () async {
              List<String> c = ["AMERICAN AIRLINES", "GOL", "IBERIA", "INTERLINE", "LATAM", "AZUL", "TAP"];
              String code = await DatabaseApi.fetchFlightsListCode(c, "2/12/2025", "20/12/2025", "GRU", "MIA", "IdaVolta");
              //List<Flight> fli = await DatabaseApi.fetchFlightsList(code);
              Get.to(()=>FlightsListPage(), arguments: code);

            },
            child: Text(AppLocalizations.of(context)!.theme),
          ),

        ],
      ),
    );
  }
}