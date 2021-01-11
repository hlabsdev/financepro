import "package:flutter/material.dart";
import 'package:get_it/get_it.dart';

import 'package:finance/pages/splash.dart';
import 'package:finance/services/app_services.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => MyAppServices());
  // GetIt.instance.registerLazySingleton(() => {
  //       AccountService(),
  //       CreditService(),
  //     });
}

void main() {
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
      //darkTheme: ThemeData(
      //brightness: Brightness.dark,
      //primarySwatch: Colors.black,
      //visualDensity: VisualDensity.adaptivePlatformDensity,
      //),
      home: SplashScreen(),
      // routes: <String, WidgetBuilder>{
      //   '/login': (BuildContext context) => new Login(),
      //   '/mainpage': (BuildContext context) => new MainPage(),
      //   '/profile': (BuildContext context) => new Profile(),
      // },
    );
  }
}
