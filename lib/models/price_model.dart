import 'package:desafio_tecnico_devnology/models/baggage_limit_model.dart';
import 'package:flutter/foundation.dart';

class Price{
  final double adult;
  final double infant;
  final double child;
  final bool executive;
  final BaggageLimit baggageLimit;
  final double boardingFee;
  final String typeValue;
  final String typeMiles;

  const Price({required this.adult,required this.infant,required this.child,required this.executive,required this.baggageLimit,
      required this.boardingFee,required this.typeValue,required this.typeMiles});

  factory Price.fromJson(Map<String, dynamic> json){
    return Price(
        adult: double.parse(json['Adulto'].toString()),
        infant: double.parse(json['Bebe'].toString()),
        child: double.parse(json['Crianca'].toString()),
        executive: json['Executivo'],
        baggageLimit: BaggageLimit.fromJson(json['LimiteBagagem']),
        boardingFee: double.parse(json['TaxaEmbarque'].toString()),
        typeValue: json['TipoValor'],
        typeMiles: json['TipoMilhas']
    );
  }

  void printPrice()
  {
    debugPrint('   adult: $adult');
    debugPrint('   infant: $infant');
    debugPrint('   child: $child');
    debugPrint('   executive: $executive');
    debugPrint('   baggageLimit:');
    baggageLimit.printBaggageLimit();
    debugPrint('   boardingFee: $boardingFee');
    debugPrint('   typeValue: $typeValue');
    debugPrint('   typeMiles: $typeMiles');
  }



}
