import 'package:desafio_tecnico_devnology/controllers/flights_list_controller.dart';
import 'package:desafio_tecnico_devnology/project_widgets/flight_list_item.dart';
import 'package:flutter/material.dart';
import 'package:desafio_tecnico_devnology/models/flight_model.dart';
import 'package:get/get.dart';

class FlightsListPage extends StatefulWidget {
  const FlightsListPage({super.key});

  @override
  State<FlightsListPage> createState() => _FlightsListPageState();
}

class _FlightsListPageState extends State<FlightsListPage> {

  final listController = Get.put(FlightsListController());


  _success(){
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: listController.flightsList.length,
      itemBuilder: (context, index){
        Flight flight =  listController.flightsList[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: FlightListItem(flight: flight),
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
          onPressed: (){ listController.start(Get.arguments); },
          child: Text("Tentar Novamente"),
        ),);
      case FlightsListState.success:
        return _success();
      }
  }

  @override
  void initState() {
    super.initState();
    listController.start(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Obx((){return stateManagement(listController.state.value);}),
    );
  }
}
