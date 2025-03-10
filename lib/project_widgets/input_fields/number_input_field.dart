import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputField extends StatelessWidget {
  final String hintText;
  final Function(int value) validateFunction;

  const NumberInputField({super.key, required this.hintText, required this.validateFunction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (text){},
      decoration: InputDecoration( label: Text(hintText), hintText: hintText,),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],

      validator: (value){
        if(value!.isEmpty) {
          return AppLocalizations.of(context)!.empty_field;
        }else{
          return validateFunction(int.parse(value));
        }
      },

    );
  }

}
