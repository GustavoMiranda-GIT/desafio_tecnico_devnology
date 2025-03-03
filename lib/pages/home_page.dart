import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:desafio_tecnico_devnology/theme/theme_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  var controller = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: (){ controller.changeThemeMode();},
            child: Text(AppLocalizations.of(context)!.theme)),
      ),
    );
  }

}