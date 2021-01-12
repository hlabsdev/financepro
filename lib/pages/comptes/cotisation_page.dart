import 'package:finance/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CotisationPage extends StatefulWidget {
  final String mise;

  const CotisationPage({
    Key key,
    this.mise,
  }) : super(key: key);

  @override
  _CotisationPageState createState() => _CotisationPageState();
}

class _CotisationPageState extends State<CotisationPage> {
  /* 
  MyAppServices get service => GetIt.I<MyAppServices>();
  ApiResponse<Account> _apiResponse;
  bool _isLoading;
  // Account compte;

  @override
  void initState() {
    _fetchData(false);
    super.initState();
  }

  _fetchData(bool getNew) async {
    setState(() {
      _isLoading = true;
    });
    if (getNew) {
      var newApiResp = await service.getAccount();
      setState(() {
        _apiResponse = newApiResp;
      });
      UserPreferences().comptes = json.encode(newApiResp.data);
    } else {
      if (UserPreferences().comptes.toString().isEmpty) {
        _apiResponse = await service.getAccount();
        UserPreferences().comptes = json.encode(_apiResponse.data);
      } else {
        _apiResponse = ApiResponse<Account>(
          data: Account.fromJson(json.decode(UserPreferences().comptes)),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          /* actions: [
          IconButton(
            tooltip: "Rafraichir la page",
            icon: Icon(Icons.refresh_rounded),
            onPressed: () {
              _fetchData(true);
            },
          ),
        ], */
          title: Text(
            "Cotiser",
            style: GoogleFonts.arya(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          child: ListView(
            shrinkWrap: true,
            itemExtent: 160,
            children: [
              InkWell(
                onTap: () {
                  _showDialog("Flooz", widget.mise);
                },
                child: Card(
                  elevation: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image(
                            image: AssetImage("images/flooz.jpeg"),
                            height: 100,
                            width: 100),
                      ),
                      Text(
                        "Cotiser par flooz",
                        style: GoogleFonts.cairo(
                            color: Colors.blue[800],
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _showDialog("TMoney", widget.mise);
                },
                child: Card(
                  elevation: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image(
                            image: AssetImage("images/tmoney.png"),
                            height: 100,
                            width: 100),
                      ),
                      Text(
                        "Cotiser par Tmoney",
                        style: GoogleFonts.cairo(
                            color: Colors.blue[800],
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image(
                          image: AssetImage("images/agent_moto.png"),
                          height: 100,
                          width: 100),
                    ),
                    Text(
                      "Cotiser chez l'agent",
                      style: GoogleFonts.cairo(
                          color: Colors.blue[800],
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _showDialog(String titre, String mise) {
    TextEditingController sommeController = TextEditingController();
    setState(() {
      sommeController.text = mise;
    });
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CupertinoAlertDialog(
          title: Text("Cotiser par " + titre),
          content: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                // padding: EdgeInsets.all(6),
                child: CupertinoTextField(
                  controller: sommeController,
                  keyboardType: TextInputType.number,
                  enabled: false,

                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  placeholder: mise,
                  textAlign: TextAlign.center,
                  // decoration: InputDecoration(
                  //     // border: OutlineInputBorder(),
                  //     border: UnderlineInputBorder(),
                  //     labelText: "Montant",

                  //     // errorText: _isLoading ? _validateEmail() : null,
                  //     errorStyle: TextStyle(
                  //       textBaseline: TextBaseline.ideographic,
                  //     )),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                  child: RaisedButton(
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Text('Valider'),
                onPressed: () {
                  titre == "Flooz"
                      ? CallAPi().launchUssd("*101#")
                      : CallAPi().launchUssd("*444#");
                },
              )),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Fermer"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    setState(() {
      sommeController.text = "";
    });
  }
}
