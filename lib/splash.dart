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
    _incrementStartup();
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

/* test deb */
  /* get the startupNumber deb */
  Future<int> _getStartupNumber() async {
    final pref = await SharedPreferences.getInstance();
    final startupNumber = pref.getInt('startupNumber');
    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  Future<void> _resetStartupNumber() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('startupNumber', 0);
  }

  Future<void> _incrementStartup() async {
    final pref = await SharedPreferences.getInstance();
    int lastStartupNumber = await _getStartupNumber();
    int currentStartupNumber = ++lastStartupNumber;

    await pref.setInt("startupNumber", currentStartupNumber);
  }

/* test end */
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
