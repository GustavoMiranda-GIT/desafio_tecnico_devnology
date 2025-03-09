import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class DateTextField extends StatefulWidget {
  final String hintText;
  final Rx<String> dateValue;

  const DateTextField({super.key, required this.hintText, required this.dateValue});

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  TextEditingController datePicker = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
        readOnly: true,
        decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.calendar_month),
            )
        ),

        controller: datePicker,

        onTap: () async{
          DateTime? dateTime = await showDatePicker(
              context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));

          if(dateTime != null){
            widget.dateValue.value = DateFormat("dd/MM/yyyy").format(dateTime);
            if(context.mounted) {
              datePicker.text = DateFormat(AppLocalizations.of(context)!.date_display_format_YYYY).format(dateTime);
            }
          }
        },

      );
  }



  String getDate() => datePicker.text;

}
