import 'package:finance/api/api.dart';
import 'package:finance/pages/mainpage.dart';
import 'package:finance/pages/widgets/bezierContainer.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  Login({Key key, this.isMain = false, this.title}) : super(key: key);

  final String title;
  final bool isMain;

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
      //print(_emailEmpty);
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

      //print(api.status);
      if (_isAllValidate) {
        api
            .login(_mailController.text, _passwordController.text)
            .whenComplete(() {
          if ((api.userData["token"] == null) || (api.status)) {
            showDismissableFlushbar(
                context,
                "Invalid Credentials",
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
    });
  }

  void showDismissableFlushbar(BuildContext context, String errorTitle,
      String errorText, bool eraseCases) {
    Flushbar(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),

      borderRadius: 8,
      backgroundColor: Colors.redAccent,
      // backgroundGradient: LinearGradient(),
      boxShadows: [
        BoxShadow(
          color: Colors.redAccent,
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

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              controller: isPassword ? _passwordController : _mailController,
              onChanged: (value) {
                _validateAll();
              },
              decoration: InputDecoration(
                  errorText: isPassword
                      ? _isLoading
                          ? _validatePassword()
                          : null
                      : _isLoading
                          ? _validateEmail()
                          : null,
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  icon: isPassword ? Icon(Icons.security) : Icon(Icons.email),
                  hintText: isPassword
                      ? "votre mot de passe ici..."
                      : "votre courrier email ici ...",
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.purpleAccent, Colors.deepPurpleAccent])),
      child: RaisedButton(
        child: Text(
          'Se Connecter',
          style: TextStyle(fontSize: 30, fontFamily: "arial"),
        ),
        textColor: Colors.white,
        color: Colors.transparent,
        elevation: 0,
        onPressed: () {
          _isAllValidate
              ? _handleLogin()
              : showDismissableFlushbar(context, "Pas de saisie",
                  "Saisissez quelque chose avant de valider", false);
        },
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  //logo aluksons
  Widget _title() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Image(
        image: AssetImage("images/logo.png"),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email"),
        _entryField("Mot de passe", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  Text(
                    _isLoading ? "Connection..." : 'Connectez-vous',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text('Vous avez oublié le mot de passe ?',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.w500)),
                  ),
                  _divider(),
                  _submitButton(),
                  SizedBox(height: height * .055),
                ],
              ),
            ),
          ),
          //Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
