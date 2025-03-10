import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MultiSelect extends StatefulWidget {
  final List<String> items;

  const MultiSelect({super.key, required this.items});

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.select_companies),
      content: SingleChildScrollView(
        child: ListBody(
          children:
          widget.items.map((item) => CheckboxListTile(
            value: selectedItems.contains(item),
            title: Text(item),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked) => itemChange(item, isChecked!),
          )).toList(),
        ),
      ),

      actions: [
        TextButton(
          onPressed: (){ Navigator.pop(context);},
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: (){Navigator.pop(context, selectedItems);},
          child: Text(AppLocalizations.of(context)!.submit),
        ),
      ],
    );
  }

  void itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedItems.add(itemValue);
      } else {
        selectedItems.remove(itemValue);
      }
    });
  }

}