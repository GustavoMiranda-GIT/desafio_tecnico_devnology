import 'package:desafio_tecnico_devnology/services/database_api.dart';
import 'package:get/get.dart';

enum FlightsListState {start, loading, success, error}

class FlightsListController extends GetxController{
  var flightsList =[];
  Rx<FlightsListState> state = FlightsListState.start.obs;
  RxBool usingMiles = false.obs;
  int numAdult = 0;
  int numChild = 0;
  int numInfant = 0;


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