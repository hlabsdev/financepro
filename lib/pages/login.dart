import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finance/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

import 'mainpage.dart';

class Login extends StatefulWidget {
  final bool isMain;

  const Login({
    Key key,
    this.isMain = false,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  CallAPi api = new CallAPi();

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isAllValidate = false;
  bool _emailEmpty = false;
  bool _emailValidate = false;
  bool _passwordEmpty = false;
  bool _passwordValidate = false;

  bool _isLoading = false;
  bool _isLogged = false;

  @override
  void initState() {
    _isAllValidate = false;
    _emailEmpty = false;
    _emailValidate = false;
    _passwordEmpty = false;
    _passwordValidate = false;
    _isLoading = false;
    _isLogged = false;
    super.initState();
  }

  String _validateEmail() {
    setState(() {
      _emailEmpty = _mailController.text.isEmpty ? true : false;

      // mailController.text.contains('@')
      //     ? _emailValidate = true
      //     : _emailValidate = false;
      _emailValidate = true;
    });
    var errorMsg;
    if (_emailEmpty) {
      errorMsg = "Il faut un Email!";
    } else if (!_emailValidate) {
      errorMsg = "Saisisez un Email valide";
    }
    return errorMsg;
  }

  String _validatePassword() {
    setState(() {
      _passwordEmpty = _passwordController.text.isEmpty ? true : false;

      // passwordController.text.length <= 4
      //     ? _passwordValidate = true
      //     : _passwordValidate = false;
      _passwordValidate = true;
    });
    var errorMesg;
    if (_passwordEmpty) {
      errorMesg = "Il faut un Mot de passe!";
    } else if (!_passwordValidate) {
      errorMesg = "Saisisez un Email valide!";
    }
    return errorMesg;
  }

  void onClose() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        maintainState: true,
        opaque: true,
        pageBuilder: (context, __, ___) => MainPage(),
        transitionsBuilder: (context, anim1, anim2, child) {
          return new FadeTransition(
            child: child,
            opacity: anim1,
          );
        }));
  }

  void _validateAll() {
    setState(() {
      if (!_emailEmpty) {
        if (!_passwordEmpty) {
          _isAllValidate = true;
        }
      } else {
        _isAllValidate = false;
      }
    });
    // return _isAllValidate ? true : false;
  }

  void _handleLogin() {
    setState(() {
      _isLoading = true;
      if (_isAllValidate) {
        api
            .login(_mailController.text, _passwordController.text)
            .whenComplete(() {
          if (api.status) {
            showDismissableFlushbar(
                context,
                "Une erreur s'est produite",
                "Données invalide, ou mauvaise connexion. Veuillez reessayer avec des données correct ou avec un meilleure connexion",
                true);
          } else {
            widget.isMain
                ? onClose()
                : Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
          }
        });
      }
      _isLoading = false;
    });
  }

/* 
  void _handleLogin() async {
    if (!_isAllValidate) {
      showDismissableFlushbar(context, "Saisie invalide",
          "Ressaisissez avec des données valide!", false);
    } else {
      setState(() {
        _isLoading = true;
      });
      var data = {
        "email": _mailController.text,
        // "username": mailController.text,
        "password": _passwordController.text,
      };
      // var res = await CallAPi().postData(data, "get_token/");
      var res = await CallAPi().postData(data, "client/auth");
      var status = res.statusCode;
      var body = json.decode(res.body);

      // if (status == 200) {
      if (body.toString().contains("token")) {
        // if (body["status_code"] == 200) {
        print(body);

        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString("token", body["token"]);
        localStorage.setString("client", json.encode(body["client"]));
        var route = new MaterialPageRoute(
          builder: (BuildContext context) => MainPage(),
        );
        Navigator.of(context).push(route);
      } else /* if (body["error_status"] == 400) */ {
        showDismissableFlushbar(
            context,
            "Une erreur s'est produite",
            "Données invalide, ou mauvaise connexion. Veuillez reessayer avec des données correct ou avec un meilleure connexion",
            true);
      }
      // }
      /* if (status == 500) {
        showDismissableFlushbar(
            context,
            "Une erreur s'est produite",
            "Le serveur ne repond pas, Veuillez reessayer dans quelques instants!",
            false);
      }
      if (status == 0) {
        showDismissableFlushbar(
            context,
            "Erreur de connexion",
            "Il semble que vous n'etes pas connecté ou que votre connexion est mauvaise.",
            false);
      } */
    }
    setState(() {
      _isLoading = false;
      _isAllValidate = false;
    });
  }
 */
  void showDismissableFlushbar(BuildContext context, String errorTitle,
      String errorText, bool eraseCases) {
    Flushbar(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),

      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: [Colors.red.shade800, Colors.redAccent.shade700],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: errorTitle,
      message: errorText,
    )..show(context);
    if (eraseCases) {
      _mailController.text = "";
      _passwordController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
          body: Center(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage("images/logo.png"),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      _isLoading ? "Connection..." : 'Connectez-vous',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _mailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        icon: Icon(
                          Icons.mail,
                          color: Colors.grey,
                        ),
                        // errorText: _validateEmail(),
                        errorText: _isLoading ? _validateEmail() : null,
                        errorStyle: TextStyle(
                          textBaseline: TextBaseline.ideographic,
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Mot de Passe",
                      icon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      errorText: _isLoading ? _validatePassword() : null,
                      // errorText: _validatePassword(),
                    ),
                    onChanged: (value) {
                      _validateAll();
                    },
                    // onSubmitted: (value) {
                    //   _validateAll();
                    // },
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.teal,
                  child: Text("Vous avez oublié le mot de passe ?"),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Text('Login'),
                      onPressed: () {
                        _isAllValidate
                            ? _handleLogin()
                            : showDismissableFlushbar(
                                context,
                                "Pas de saisie",
                                "Saisiessez quelque chose avant de valider",
                                false);
                      },
                    )),
                SizedBox(
                  height: 8,
                ),
              ],
            )),
      )),
    );
  }
}
