import 'dart:async';

import 'package:finance/pages/login.dart';
import 'package:finance/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLogged;

  @override
  void initState() {
    super.initState();
    _incrementStartup();
    loadData();
  }

  Future<Timer> loadData() async {
    SharedPreferences localData = await SharedPreferences.getInstance();
    setState(() {
      localData.containsKey("token") ? _isLogged = true : _isLogged = false;
    });

    return new Timer(const Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        maintainState: true,
        opaque: true,
        pageBuilder: (context, __, ___) =>
            _isLogged ? MainPage() : Login(isMain: true),
        transitionDuration: const Duration(seconds: 2),
        transitionsBuilder: (context, anim1, anim2, child) {
          return new FadeTransition(
            child: child,
            opacity: anim1,
          );
        }));
    // dispose();
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
