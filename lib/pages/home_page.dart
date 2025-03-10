import 'package:desafio_tecnico_devnology/controllers/flights_list_controller.dart';
import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:desafio_tecnico_devnology/models/airport_model.dart';
import 'package:desafio_tecnico_devnology/project_widgets/input_fields/date_text_field.dart';
import 'package:desafio_tecnico_devnology/project_widgets/input_fields/input_text_field.dart';
import 'package:desafio_tecnico_devnology/project_widgets/input_fields/multi_select.dart';
import 'package:desafio_tecnico_devnology/project_widgets/input_fields/number_input_field.dart';
import 'package:desafio_tecnico_devnology/theme/theme_controller.dart';
import 'package:desafio_tecnico_devnology/services/database_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'flights_list_page.dart';

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

  SearchType searchType = SearchType.round;
  Rx<String> origin = "".obs;
  Rx<String> destination = "".obs;
  Rx<DateTime> departure = DateTime.now().obs;
  Rx<DateTime> returnDate = DateTime.now().obs;
  RxList<String> selectedCompanies = <String>[].obs;
  TextEditingController companiesController = TextEditingController();

  int numAdult = 0;
  int numChild = 0;
  int numInfant = 0;

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
                    validateFunction: validateOrigin,
                  ),

                  InputTextField(
                    preIcon: Icon(Icons.flight_land),
                    hintText: AppLocalizations.of(context)!.destination,
                    textSelected: destination,
                    autoCompleteData: autoCompleteList,
                    validateFunction: validateDestination,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<SearchType>(
                            title: Text(AppLocalizations.of(context)!.round_trip),
                            value: SearchType.round,
                            groupValue: searchType,
                            onChanged: (val){ setState(() {
                                searchType = val!;
                            }
                            );
                            }
                        ),
                      ),

                      Expanded(
                        child: RadioListTile<SearchType>(
                            title: Text(AppLocalizations.of(context)!.one_way),
                            value: SearchType.oneWay,
                            groupValue: searchType,
                            onChanged: (val){ setState(() {
                              searchType = val!;

                            }
                            );
                            }
                        ),
                      ),
                    ],
                  ),

                  DateTextField(hintText: AppLocalizations.of(context)!.departure, dateValue: departure, validateFunction: validateDate,),

                  Visibility(
                    visible: searchType == SearchType.round,
                    child: DateTextField(hintText: AppLocalizations.of(context)!.return_string, dateValue: returnDate, validateFunction: validateDate,),
                  ),


                  TextFormField(
                      readOnly: true,
                      controller: companiesController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.company.capitalize,
                      ),
                      onTap: (){ showMultiSelect();},
                      validator: (value){
                        if(value!.isEmpty) {
                          return AppLocalizations.of(context)!.empty_field;
                        }
                        return null;
                      },
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
              child: Text(AppLocalizations.of(context)!.search,style: Theme.of(context).textTheme.bodyLarge),
            ),


          ],
        ),
      ),
    );
  }

  Future<void> fetchAirports() async{
    airportsList = await DatabaseApi.fetchAirports();
    for (var e in airportsList) {
      autoCompleteList.add("${e.iata} - ${e.name}");
    }
  }

  Future<void> findFlights() async {

    if(!formKey.currentState!.validate()) {
    return;
    }

    String searchCode = await DatabaseApi.fetchFlightsListCode(
        selectedCompanies,
        DateFormat("dd/MM/yyyy").format(departure.value),
        DateFormat("dd/MM/yyyy").format(returnDate.value),
        origin.value,
        destination.value,
        (searchType == SearchType.round ? "IdaVolta": "Ida")
    );

    /*
    List<String> c = ["AMERICAN AIRLINES", "GOL", "IBERIA", "INTERLINE", "LATAM", "AZUL", "TAP"];
    String searchCode = await DatabaseApi.fetchFlightsListCode(c, "2/12/2025", "20/12/2025", "GRU", "MIA", "IdaVolta");
   */

    if(searchCode.isNotEmpty) {
      Get.to(()=>FlightsListPage(searchCode:searchCode, searchType: searchType , numAdult:numAdult,numChild:numChild,numInfant:numInfant));
    }

  }

  String? validateOrigin(String value){
    if(origin.value.compareTo(destination.value) == 0){
      return AppLocalizations.of(context)!.origin_destination_same;
    }

    for (var e in airportsList) {
      if(value.compareTo("${e.iata} - ${e.name}") == 0){
        origin.value = e.iata;
        return null;
      }
    }

    return AppLocalizations.of(context)!.valid_value;
  }

  String? validateDestination(String value){
    if(origin.value.compareTo(destination.value) == 0){
      return AppLocalizations.of(context)!.origin_destination_same;
    }

    for (var e in airportsList) {
      if(value.compareTo("${e.iata} - ${e.name}") == 0){
        destination.value = e.iata;
        return null;
      }
    }

    return AppLocalizations.of(context)!.valid_value;
  }

  String? validateDate(DateTime value){
    if(departure.value.isAfter(returnDate.value)){
      return AppLocalizations.of(context)!.date_before;
    }


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