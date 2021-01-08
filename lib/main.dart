import 'package:finance/login.dart';
import 'package:finance/mainpage.dart';
import 'package:finance/profile.dart';
import 'package:finance/services/account_service.dart';
import 'package:finance/services/credit_service.dart';
import 'package:finance/splash.dart';
import "package:flutter/material.dart";
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() {
    AccountService();
    CreditService();
  });
  // GetIt.instance.register
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /* get the startupNumber deb */
  /* get the startupNumber end */
  // This widget is the root of your application.
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
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
        '/mainpage': (BuildContext context) => new MainPage(),
        '/profile': (BuildContext context) => new Profile(),
      },
    );
  }
}
