import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finance/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

import 'mainpage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isAllValidate = false;
  bool _emailEmpty = false;
  bool _emailValidate = false;
  bool _passwordEmpty = false;
  bool _passwordValidate = false;

  bool _isLoading = false;
  var text;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

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
      mailController.text = "";
      passwordController.text = "";
    }
  }

  String _validateEmail() {
    setState(() {
      if (mailController.text == "") {
        _emailEmpty = true;
      } else {
        _emailEmpty = false;
      }

      // mailController.text.contains('@')
      //     ? _emailValidate = true
      //     : _emailValidate = false;
      _emailValidate = true;
    });
    var errorMsg;
    if (_emailEmpty == true) {
      errorMsg = "Il faut un Email!";
    } else if (!_emailValidate) {
      errorMsg = "Saisisez un Email valide";
    }
    return errorMsg;
    // setState(() {
    //   _emailEmpty = false;
    //   _emailValidate = false;
    // });
  }

  String _validatePassword() {
    setState(() {
      if (passwordController.text == "") {
        _passwordEmpty = true;
      } else {
        _passwordEmpty = false;
      }

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

    // setState(() {
    //   _passwordEmpty = false;
    //   _passwordValidate = false;
    // });
  }

  void _checkAll() {
    _isLoading = true;

    setState(() {
      // _isLoading = true;

      if (!_emailEmpty) {
        if (_emailValidate) {
          if (!_passwordEmpty) {
            if (_passwordValidate) {
              _isAllValidate = true;
            }
          }
        }
      } else {
        _isAllValidate = false;
      }
    });
  }

  void _handleLogin() async {
    _checkAll();

    if (!_isAllValidate) {
      showDismissableFlushbar(context, "Saisie nvalide",
          "Ressaisissez avec des données valide!", false);
    } else {
      var data = {
        // "email": mailController.text,
        "uername": mailController.text,
        "password": passwordController.text,
      };

      var res = await CallAPi().postData(data, "get_token/");
      // var res = await CallAPi().postData(data, "client/auth");
      var body = json.decode(res.body);

      if (body.toString().isNotEmpty) {
        // if (body["status_code"] == 200) {
        print(body);

        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString("token", body["token"]);
        // localStorage.setString("user", body["0"]);
        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new MainPage(),
        );

        Navigator.of(context).push(route);
      } else /* if (body.toString().isEmpty) */ {
        showDismissableFlushbar(context, "Donnée incorrect",
            "Email ou mot de passe incorrect. Reessayez!", false);
      }
    }

    setState(() {
      // _isLoading = false;
      _isAllValidate = false;
    });
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Un Logo ici",
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    )),
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
                    controller: mailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        icon: Icon(
                          Icons.mail,
                          color: Colors.grey,
                        ),
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
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Mot de Passe",
                      icon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      errorText: _isLoading ? _validatePassword() : null,
                    ),
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
                        _handleLogin();
                      },
                    )),
                SizedBox(
                  height: 8,
                ),
              ],
            )));
  }
}
