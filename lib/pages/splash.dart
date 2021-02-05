import 'dart:async';

import 'package:finance/pages/login.dart';
import 'package:finance/pages/mainpage.dart';
import 'package:finance/services/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();
  bool _isLogged = false;

  @override
  void initState() {
    super.initState();
    loadData();
    _incrementStartup();
    /*
    if (_getStartupNumber() > 1){
      onDonePress();
    }*/

    slides.add(
      new Slide(
          heightImage: 80,
          marginTitle: EdgeInsets.all(50),
          title: "BIENVENUE A MICROFINANCE PRO",
          maxLineTitle: 3,
          maxLineTextDescription: 5,
          description: "Aluksons Business Solutions"
              " vous offre Microfinance Pro "
              "Une Plateforme ultra sécurisée qui"
              " vous rend la vie facile.",
          pathImage: "images/logo.png",
          backgroundImage: "images/slider1.jpg"),
    );
    slides.add(
      new Slide(
        title: "SUIVIT DE TONTINE",
        maxLineTitle: 2,
        maxLineTextDescription: 5,
        marginTitle: EdgeInsets.all(50),
        description: "Microfinance pro donne un avantage"
            " de suivit de vos cotisations journalière"
            " et vous évite tout autre confusion à l'avenir.",
        //pathImage: "images/logo.png",
        //backgroundColor: Color(0xff203152),
        backgroundImage: "images/slider2.png",
      ),
    );
    slides.add(
      new Slide(
        title: "APPELEZ VOS AGENTS DE TONTINE",
        maxLineTitle: 3,
        maxLineTextDescription: 5,
        marginTitle: EdgeInsets.all(50),
        description: "Microfinance pro donne un avantage"
            " en mettant à votre disposition le moyen "
            " de comminuquer avec vos agents et de "
            " faire valider vos cotisations instantannément.",
        //pathImage: "images/logo.png",
        //backgroundColor: Color(0xff203152),
        backgroundImage: "images/slider4.gif",
      ),
    );
    slides.add(
      new Slide(
        maxLineTitle: 3,
        maxLineTextDescription: 5,
        marginTitle: EdgeInsets.all(50),
        title: "CARNET ELECTRONIQUE",
        description: "Avec Microfinance Pro vous avez à votre"
            " disposition un carnet électronique qui "
            "vous permet de consulter votre position "
            "de chaque mois de l'année.",
        //pathImage: "images/logo.png",
        //backgroundColor: Color(0xff9932CC),
        backgroundImage: "images/slider3.gif",
      ),
    );
  }

  Future<void> loadData() async {
    SharedPreferences localData = await SharedPreferences.getInstance();
    setState(() {
      localData.containsKey("token") ? _isLogged = true : _isLogged = false;
    });
  }

  Future<void> _incrementStartup() async {
    final pref = await SharedPreferences.getInstance();
    int lastStartupNumber = _getStartupNumber();
    int currentStartupNumber = ++lastStartupNumber;
    UserPreferences().startupNumber = currentStartupNumber.toString();
    if (lastStartupNumber > 1) {
      this.onDonePress();
    }
  }

  int _getStartupNumber() {
    int startupNumber = UserPreferences().startupNumber.hashCode;
    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  void onDonePress() {
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

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
