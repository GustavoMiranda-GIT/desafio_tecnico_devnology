import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:desafio_tecnico_devnology/models/flight_model.dart';
import 'package:desafio_tecnico_devnology/controllers/flights_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightListItem extends StatelessWidget {
  final Flight flight;
  final FlightsListController listController;


  const FlightListItem({super.key, required this.flight, required this.listController,});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){flight.printFlight();},
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
                            Text(flight.origin, style: Theme.of(context).textTheme.bodySmall),
                            Text(flight.boardingTime, style: Theme.of(context).textTheme.headlineSmall),
                            Text(getDateFormated(context, flight.boarding), style: Theme.of(context).textTheme.bodySmall),
                          ]),

                      Icon(Icons.arrow_forward, size: Theme.of(context).textTheme.headlineSmall?.fontSize,),

                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(flight.destination, style: Theme.of(context).textTheme.bodySmall),
                            Text(flight.landingTime, style: Theme.of(context).textTheme.headlineSmall),
                            Text(getDateFormated(context, flight.landing), style: Theme.of(context).textTheme.bodySmall),
                          ]),

                    ],),

                  Column(
                    children: [
                      SizedBox(height: 16),
                      Text("${getCurrencySymbol(context)} ${getTotalPrice().toStringAsFixed(2)}", style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                ],),
//-------------------------------------------------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${flight.duration}, ${getNConnectionsText(context)}", style: Theme.of(context).textTheme.bodySmall),
                  Text("${AppLocalizations.of(context)!.boarding_fee} ${getCurrencySymbol(context)} ${getBoardingFee().toStringAsFixed(2)}", style: Theme.of(context).textTheme.bodySmall),

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


  double getTotalPrice(){
    double adultPrice = listController.numAdult * flight.prices[0].adult;
    double childPrice = listController.numChild * flight.prices[0].child;
    return adultPrice + childPrice + getBoardingFee();
  }

  double getBoardingFee(){
    return (listController.numAdult + listController.numChild) * flight.prices[0].boardingFee;
  }

  String getCurrencySymbol(BuildContext context){
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return format.currencySymbol;
  }

}
