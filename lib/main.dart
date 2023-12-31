import 'package:finance/services/user_preferences.dart';
import "package:flutter/material.dart";
import 'package:get_it/get_it.dart';

import 'package:finance/pages/splash.dart';
import 'package:finance/services/app_services.dart';

import 'pages/splash.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => MyAppServices());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: IntroScreen(),
    );
  }
}
