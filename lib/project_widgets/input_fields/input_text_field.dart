import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class InputTextField extends StatelessWidget {
  final Icon preIcon;
  final String hintText;
  final Rx<String> textSelected;
  final List<String> autoCompleteData;
  final Function(String value) validateFunction;


  const InputTextField({super.key, required this.preIcon, required this.hintText,required this.textSelected ,required this.autoCompleteData, required this.validateFunction});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue){
        if(textEditingValue.text.isEmpty){
          return const Iterable<String>.empty();
        }
        return autoCompleteData.where((String item){
          return item.toLowerCase().contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (selectedString){
        textSelected.value = selectedString;
      },


      fieldViewBuilder: (context, controller, focusNode, onEditingComplete){
        return TextFormField(
          onChanged: (text){textSelected.value = text;},
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: preIcon,
              )
          ),
          validator: (value){
            if(value!.isEmpty) {
              return AppLocalizations.of(context)!.empty_field;
            }else{
              return validateFunction(value);
            }
          },

        );
      },


    );


  }
}
