import 'package:flutter/foundation.dart';

class BaggageLimit{
  final Map<String,int> checkedBaggage;
  final Map<String,int> handBaggage;

  const BaggageLimit({required this.checkedBaggage,required this.handBaggage});

  factory BaggageLimit.fromJson(Map<String, dynamic> json){
    return BaggageLimit(
      checkedBaggage:  {"23kg": json['BagagemDespachada']["23kg"]},
      handBaggage:  {"10kg": json['BagagemMao']["10kg"]},
    );
  }

  void printBaggageLimit()
  {
    debugPrint('      checkedBaggage: $checkedBaggage');
    debugPrint('      handBaggage: $handBaggage');
  }

}

