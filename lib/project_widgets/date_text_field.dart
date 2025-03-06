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
          String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
          setState(() {
            datePicker.text = formattedDate;
          });
        }
      },

    );
  }

  String getDate() => datePicker.text;

}
