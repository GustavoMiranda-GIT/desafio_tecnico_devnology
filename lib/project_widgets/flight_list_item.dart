import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:desafio_tecnico_devnology/models/flight_model.dart';
import 'package:desafio_tecnico_devnology/controllers/flights_list_controller.dart';
import 'package:desafio_tecnico_devnology/models/price_model.dart';
import 'package:desafio_tecnico_devnology/pages/selected_flights_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FlightListItem extends StatelessWidget {
  final Flight flight;
  final FlightsListController listController;


  const FlightListItem({super.key, required this.flight, required this.listController,});


  @override
  Widget build(BuildContext context) {
    String originText = "";
    String destinationText = "";

    if(flight.flightDirection == FlightDirection.departure){
      originText = flight.origin;
      destinationText = flight.destination;
    }else{
      originText = flight.destination;
      destinationText = flight.origin;
    }

    return GestureDetector(
      onTap: (){flight.printFlight(); flightSelectPopup(context);},//Remover Print
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14)
        ),
        color: Theme.of(context).colorScheme.primary,

        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            spacing: 8,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(originText, style: Theme.of(context).textTheme.bodySmall),
                            Text(flight.boardingTime, style: Theme.of(context).textTheme.headlineSmall),
                            Text(getDateFormated(context, flight.boarding), style: Theme.of(context).textTheme.bodySmall),
                          ]),

                      Icon(Icons.arrow_forward, size: Theme.of(context).textTheme.headlineSmall?.fontSize,),

                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(destinationText, style: Theme.of(context).textTheme.bodySmall),
                            Text(flight.landingTime, style: Theme.of(context).textTheme.headlineSmall),
                            Text(getDateFormated(context, flight.landing), style: Theme.of(context).textTheme.bodySmall),
                          ]),

                    ],),

                  Column(
                    children: [
                      SizedBox(height: 16),
                      Obx(()=> Text("${getCurrencySymbol(context)} ${getTotalPrice(FareType.start).toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.headlineMedium)
                      ),

                    ],
                  ),
                ],),
//-------------------------------------------------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${flight.duration}, ${getNConnectionsText(context)}", style: Theme.of(context).textTheme.bodySmall),
                  Obx(()=>Text(
                      "${AppLocalizations.of(context)!.boarding_fee}: ${getCurrencySymbol(context)} ${getBoardingFee(FareType.start).toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.bodySmall),

                  ),

                ],),

            ],),

        ),
      ),
    );
  }

  String getNConnectionsText(BuildContext context){
    String connectionsText = "";
    flight.boarding.toString();
    if(flight.nConnections == 0){
      connectionsText = AppLocalizations.of(context)!.direct;
    }else if(flight.nConnections == 1){
      connectionsText = "${flight.nConnections.toString()} ${AppLocalizations.of(context)!.stop}";
    }else{
      connectionsText = "${flight.nConnections.toString()} ${AppLocalizations.of(context)!.stops}";
    }

    return connectionsText;
 }

 String getDateFormated(BuildContext context, DateTime date){
    String dateString = DateFormat(AppLocalizations.of(context)!.date_display_format).format(date);
    return dateString;
  }


  double getTotalPrice(FareType fareType){
    bool usingMiles = listController.usingMiles.value;
    double adultPrice = 0;
    double childPrice = 0;

    if(!usingMiles)
    {
    for (var e in flight.prices) {
     if(e.fareType == fareType){
       adultPrice = listController.numAdult * e.adult;
       childPrice = listController.numChild * e.child;
     }
    }
    }else{
      for (var e in flight.miles) {
        if(e.fareType == fareType){
          adultPrice = listController.numAdult * e.adult;
          childPrice = listController.numChild * e.child;
        }
      }
    }

    return adultPrice + childPrice + getBoardingFee(fareType);
  }

  double getBoardingFee(FareType fareType){
    bool usingMiles = listController.usingMiles.value;
    int numPassengers = listController.numAdult + listController.numChild;
    double fee = 0;

    if(!usingMiles)
    {
      for (var e in flight.prices) {
        if(e.fareType == fareType){
          fee = numPassengers * e.boardingFee;
        }
      }
    }else{
      for (var e in flight.miles) {
        if(e.fareType == fareType){
          fee = numPassengers * e.boardingFee;
        }
      }
    }

    return fee;
  }

  String getCurrencySymbol(BuildContext context){
    if(listController.usingMiles.value){
      return "";
    }

    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return format.currencySymbol;
  }

  void flightSelectPopup(BuildContext context){
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder){
        List<Price> listPrices = listController.usingMiles.value ? flight.miles : flight.prices;
        return CupertinoPopupSurface(
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.center,
            width: double.infinity,
            height: 400,
            child: Row(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(listPrices.length, (index){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children:[
                      Text(listPrices[index].typeMiles.toString(), style: Theme.of(context).textTheme.headlineMedium),
                      Text("${getCurrencySymbol(context)} ${getTotalPrice(listPrices[index].fareType).toStringAsFixed(2)}", style: Theme.of(context).textTheme.headlineSmall),
                      ElevatedButton(
                          onPressed: (){
                            selectFlight(listPrices[index].fareType);
                          },
                          child: Text(AppLocalizations.of(context)!.select, style: Theme.of(context).textTheme.bodyLarge))

                    ],);

                  },),


            ),
          ),



        );},
    );
  }

  void selectFlight(FareType fareType){
    if(!listController.showReturnList.value){
      listController.flightOrigin = flight;
      listController.fareTypeOrigin = fareType;

      if(listController.searchType == SearchType.oneWay){
        listController.flightDestination = flight;//Inicializado aqui somente para mostrar tela de resultados sem erro (Linha removida futuramente);
        listController.fareTypeDestination = fareType;//Inicializado aqui somente para mostrar tela de resultados sem erro (Linha removida futuramente);
        Get.back();
        Get.to(()=>SelectedFlightsPage(listController: listController));
      }else{
        listController.showReturnList.value = true;
        Get.back();
      }

    }else{
      listController.flightDestination = flight;
      listController.fareTypeDestination = fareType;
      Get.back();
      Get.to(()=>SelectedFlightsPage(listController: listController));
    }
  }

}
