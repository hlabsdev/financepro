import 'dart:async';

import 'package:finance/login.dart';
import 'package:finance/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    SharedPreferences localData = await SharedPreferences.getInstance();
    localData.containsKey("token")
        ? Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainPage()))
        : Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Login()));
    dispose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/splash.png'), fit: BoxFit.cover),
      ),
      // child: Center(
      //   child: CircularProgressIndicator(
      //     valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
      //   ),
      // ),
    );
  }
}
