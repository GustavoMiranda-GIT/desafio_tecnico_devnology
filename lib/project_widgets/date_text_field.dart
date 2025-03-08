import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTextField extends StatefulWidget {
  String hintText;

  DateTextField({super.key, required this.hintText});

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  TextEditingController datePicker = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 8,
      child: TextField(
        style: Theme.of(context).textTheme.headlineMedium,
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
            setState(() {
              datePicker.text = DateFormat(AppLocalizations.of(context)!.date_display_format_YYYY).format(dateTime);
            });
          }
        },

      ),
    );
  }



  String getDate() => datePicker.text;

}
