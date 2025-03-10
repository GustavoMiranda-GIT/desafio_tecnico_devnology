import 'package:desafio_tecnico_devnology/models/flight_model.dart';
import 'package:desafio_tecnico_devnology/models/price_model.dart';
import 'package:desafio_tecnico_devnology/services/database_api.dart';
import 'package:get/get.dart';

enum FlightsListState {start, loading, success, error}

enum SearchType { round, oneWay }

class FlightsListController extends GetxController{
  List<Flight> flightsList =[];
  Rx<FlightsListState> state = FlightsListState.start.obs;
  RxBool usingMiles = false.obs;
  RxBool showReturnList = false.obs;
  int numAdult = 0;
  int numChild = 0;
  int numInfant = 0;

  late SearchType searchType;
  late Flight flightOrigin;
  late FareType fareTypeOrigin;
  late Flight flightDestination;
  late FareType fareTypeDestination;


  Future start(String searchCode) async {
    state.value = FlightsListState.loading;
    try{
      flightsList = await DatabaseApi.fetchFlightsList(searchCode);
      state.value = FlightsListState.success;
    }catch(e){
      state.value = FlightsListState.error;
    }
  }

}