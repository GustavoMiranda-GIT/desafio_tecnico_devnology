import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:desafio_tecnico_devnology/models/airport_model.dart';
import 'package:desafio_tecnico_devnology/project_widgets/date_text_field.dart';
import 'package:desafio_tecnico_devnology/project_widgets/input_text_field.dart';
import 'package:desafio_tecnico_devnology/project_widgets/multi_select.dart';
import 'package:desafio_tecnico_devnology/project_widgets/number_input_field.dart';
import 'package:desafio_tecnico_devnology/theme/theme_controller.dart';
import 'package:flutter/material.dart';
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
  final formKey = GlobalKey<FormState>();
  var themeController = ThemeController.to;
  late List<Airport> airportsList = [];
  late List<String> autoCompleteList = [];

  FlightType? flightType = FlightType.round;
  Rx<String> origin = "".obs;
  Rx<String> destination = "".obs;
  Rx<String> departure = "".obs;
  Rx<String> returnDate = "".obs;
  RxList<String> selectedCompanies = <String>[].obs;
  TextEditingController companiesController = TextEditingController();

  int numAdult = 0;
  int numChild = 0;
  int numInfant = 0;


  Future<void> fetchAirports() async{
    final airportsList = await DatabaseApi.fetchAirports();
    for (var e in airportsList) {
      autoCompleteList.add("${e.iata} - ${e.name}");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAirports();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(leading: Icon(Icons.flight),
        centerTitle: true,
        title: Text("BuscaMilhas"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      endDrawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(AppLocalizations.of(context)!.theme),
              onTap: (){ themeController.changeThemeMode();},
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 16,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  InputTextField(
                    preIcon: Icon(Icons.flight_takeoff),
                    hintText: AppLocalizations.of(context)!.origin,
                    textSelected: origin,
                    autoCompleteData: autoCompleteList,
                    validateFunction: validateLocation,
                  ),

                  InputTextField(
                    preIcon: Icon(Icons.flight_land),
                    hintText: AppLocalizations.of(context)!.destination,
                    textSelected: destination,
                    autoCompleteData: autoCompleteList,
                    validateFunction: validateLocation,
                  ),

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

                  DateTextField(hintText: AppLocalizations.of(context)!.departure, dateValue: departure),

                  Visibility(
                    visible: flightType == FlightType.round,
                    child: DateTextField(hintText: AppLocalizations.of(context)!.return_string, dateValue: returnDate),
                  ),

                  TextField(
                      readOnly: true,
                      controller: companiesController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.company.capitalize,
                      ),
                      onTap: (){ showMultiSelect();}
                  ),

                  NumberInputField(hintText: AppLocalizations.of(context)!.adult,validateFunction: validateNumAdults),
                  NumberInputField(hintText: AppLocalizations.of(context)!.child,validateFunction: validateNumChild),
                  NumberInputField(hintText: AppLocalizations.of(context)!.infant,validateFunction: validateNumInfant),

                ],),
            ),

            ElevatedButton(
              onPressed: () {
                findFlights();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16,horizontal: 40)
              ),
              child: Text(AppLocalizations.of(context)!.search),
            ),


          ],
        ),
      ),
    );
  }

Future<void> findFlights() async {

  if(!formKey.currentState!.validate()) {
    return;
  }
  print(flightType.toString());
  print(origin.value.substring(0,3));
  print(destination.value.substring(0,3));
  print(departure.value);
  print(returnDate.value);
  print(selectedCompanies);
  print(numAdult);
  print(numChild);
  print(numInfant);

  String searchCode = await DatabaseApi.fetchFlightsListCode(
      selectedCompanies,
      departure.value,
      returnDate.value,
      origin.value.substring(0,3),
      destination.value.substring(0,3),
      (flightType == FlightType.round ? "IdaVolta": "Ida")
  );

  if(searchCode.isNotEmpty) {
    Get.to(()=>FlightsListPage(searchCode:searchCode,numAdult:numAdult,numChild:numChild,numInfant:numInfant));
  }
}
  String? validateLocation(String value){
    return null;
  }


  String? validateNumAdults(int n){
    if(n > 9) {
      return "${AppLocalizations.of(context)!.max}: 9";
    }else if(n == 0){
      return "${AppLocalizations.of(context)!.min}: 1";
    } else {
      numAdult = n;
      return null;
    }
  }

  String? validateNumChild(int n){
    if(n > 9) {
      return "${AppLocalizations.of(context)!.max}: 9";
    }else{
      numChild = n;
      return null;
    }
  }

  String? validateNumInfant(int n){
    if(numAdult < n) {
      return AppLocalizations.of(context)!.infant_error_message;
    }else {
      numInfant = n;
      return null;
    }
  }

  void showMultiSelect() async {
    final List<String> companies = [
      "AMERICAN AIRLINES",
      "GOL",
      "IBERIA",
      "INTERLINE",
      "LATAM",
      "AZUL",
      "TAP"
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: companies);
      },
    );

    // Update UI
    if (results != null) {
       companiesController.text= results.join(" , ");
       selectedCompanies.value = results;
    }
  }




}