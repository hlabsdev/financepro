import 'package:finance/mainpage.dart';
import 'package:finance/splash.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

void main() {
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
    );
  }
}
