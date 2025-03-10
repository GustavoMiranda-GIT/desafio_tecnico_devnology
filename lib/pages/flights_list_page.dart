import 'package:desafio_tecnico_devnology/controllers/flights_list_controller.dart';
import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:desafio_tecnico_devnology/project_widgets/flight_list_item.dart';
import 'package:flutter/material.dart';
import 'package:desafio_tecnico_devnology/models/flight_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FlightsListPage extends StatefulWidget {
  final String searchCode;
  final int numAdult;
  final int numChild;
  final int numInfant;
  final SearchType searchType;

  const FlightsListPage({super.key, required this.searchCode, required this.numAdult, required this.numChild, required this.numInfant, required this.searchType});

  @override
  State<FlightsListPage> createState() => _FlightsListPageState();
}

class _FlightsListPageState extends State<FlightsListPage> {
  List<Flight> filteredList = [];
  final listController = Get.put(FlightsListController());

  @override
  void initState() {
    super.initState();
    listController.searchType = widget.searchType;
    listController.numAdult = widget.numAdult;
    listController.numChild = widget.numChild;
    listController.numInfant = widget.numInfant;
    listController.start(widget.searchCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(()=>Text(listController.showReturnList.value ?  AppLocalizations.of(context)!.return_string : AppLocalizations.of(context)!.departure)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          Obx(()=>Text(getCurrencySymbol(context), style: Theme.of(context).textTheme.headlineSmall)),
          Obx(()=>Switch(value: listController.usingMiles.value, onChanged: (value){ listController.usingMiles.value = value;})),
        ]
      ),

      body: Obx((){return stateManagement(listController.state.value);}),
    );
  }

  _success(){
    if(listController.showReturnList.value){
      filteredList = listController.flightsList.where((e)=> e.flightDirection == FlightDirection.returnDirection).toList();
    }else{
      filteredList = listController.flightsList.where((e)=> e.flightDirection == FlightDirection.departure).toList();
    }

    return ListView.builder(
      padding: EdgeInsets.all(4),
      itemCount: filteredList.length,
      itemBuilder: (context, index){
        Flight flight =  filteredList[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: FlightListItem(flight: flight, listController:listController),
        );
      },
    );
  }

  stateManagement(FlightsListState state){
    switch(state){
      case FlightsListState.start:
        return Container();
      case FlightsListState.loading:
        return Center(child: CircularProgressIndicator());
      case FlightsListState.error:
        return Center(
          child: ElevatedButton(
            onPressed: (){ listController.start(widget.searchCode); },
            child: Text(AppLocalizations.of(context)!.try_again),
        ),);
      case FlightsListState.success:
        return _success();
    }
  }

  String getCurrencySymbol(BuildContext context){
    if(listController.usingMiles.value){
      return AppLocalizations.of(context)!.miles;
    }

    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return format.currencySymbol;
  }


}
