import 'package:flutter/material.dart';
import 'package:desafio_tecnico_devnology/pages/home_page.dart';
import 'package:desafio_tecnico_devnology/services/database_api.dart';
import 'package:desafio_tecnico_devnology/theme/theme_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:desafio_tecnico_devnology/l10n/app_localizations.dart';

void main() async {
  await GetStorage.init();
  Get.lazyPut<ThemeController>(() => ThemeController());
  fetchAirports();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController.to.loadThemeMode();

    return GetMaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      home: HomePage(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> fetchAirports() async{
 // DatabaseApi.fetchTickets();
  //DatabaseApi.fetchTicketsList();
  //final airport = await DatabaseApi.fetchAirports();
  //airport.printAirport();
}
