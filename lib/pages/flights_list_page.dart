import 'package:desafio_tecnico_devnology/controllers/flights_list_controller.dart';
import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:desafio_tecnico_devnology/project_widgets/flight_list_item.dart';
import 'package:flutter/material.dart';
import 'package:desafio_tecnico_devnology/models/flight_model.dart';
import 'package:get/get.dart';

class FlightsListPage extends StatefulWidget {
  final String searchCode;
  final int numAdult;
  final int numChild;
  final int numInfant;

  const FlightsListPage({super.key, required this.searchCode, required this.numAdult, required this.numChild, required this.numInfant});
  @override
  State<FlightsListPage> createState() => _FlightsListPageState();
}

class _FlightsListPageState extends State<FlightsListPage> {

  final listController = Get.put(FlightsListController());


  _success(){
    return ListView.builder(
      padding: EdgeInsets.all(4),
      itemCount: listController.flightsList.length,
      itemBuilder: (context, index){
        Flight flight =  listController.flightsList[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: FlightListItem(flight: flight, listController:listController),
        );},
    );
  }

  stateManagement(FlightsListState state){
    switch(state){
      case FlightsListState.start:
        return Container();
      case FlightsListState.loading:
        return Center(child: CircularProgressIndicator());
      case FlightsListState.error:
        return Center( child: ElevatedButton(
          onPressed: (){ listController.start(Get.arguments["searchCode"]); },
          child: Text(AppLocalizations.of(context)!.try_again),
        ),);
      case FlightsListState.success:
        return _success();
      }
  }

  @override
  void initState() {
    super.initState();
    listController.numAdult = widget.numAdult;
    listController.numChild = widget.numChild;
    listController.numInfant = widget.numInfant;
    listController.start(widget.searchCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.departure),
        backgroundColor: Theme.of(context).colorScheme.primary,

      ),
      body: Obx((){return stateManagement(listController.state.value);}),
    );
  }
}
