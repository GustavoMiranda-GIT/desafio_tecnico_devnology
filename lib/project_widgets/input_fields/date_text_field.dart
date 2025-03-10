import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class DateTextField extends StatelessWidget {
  final String hintText;
  final Rx<DateTime> dateValue;
  final Function(DateTime value) validateFunction;
  final TextEditingController datePicker = TextEditingController();

  DateTextField({super.key, required this.hintText, required this.dateValue, required this.validateFunction});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: datePicker,
      readOnly: true,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: const Icon(Icons.calendar_month),
          )
      ),
      onTap: () async {
        DateTime initialDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2);
        DateTime? dateTime = await showDatePicker(
            context: context, initialDate: initialDate, firstDate: initialDate, lastDate: DateTime(2100));

        if(dateTime != null){
          dateValue.value = dateTime;
          if(context.mounted) {
            datePicker.text = DateFormat(AppLocalizations.of(context)!.date_display_format_YYYY).format(dateTime);
          }
        }
      },

      validator: (value){
        if(value!.isEmpty) {
          return AppLocalizations.of(context)!.empty_field;
        }else{
          return validateFunction(dateValue.value);
        }
      },

    );

  }

}
