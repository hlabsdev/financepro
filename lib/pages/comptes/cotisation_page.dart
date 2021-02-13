import 'dart:convert';

import 'package:finance/api/api.dart';
import 'package:finance/models/agent_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/app_services.dart';
import '../../services/user_preferences.dart';

class CotisationPage extends StatefulWidget {
  const CotisationPage({
    Key key,
  }) : super(key: key);

  @override
  _CotisationPageState createState() => _CotisationPageState();
}

class _CotisationPageState extends State<CotisationPage> {
  TextEditingController sommeController = TextEditingController();

  MyAppServices get service => GetIt.I<MyAppServices>();
  ApiResponse<AgentClient> _apiResponse;
  bool _isLoading;

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
      var newApiResp = await service.getAgentClient();
      setState(() {
        _apiResponse = newApiResp;
      });
      UserPreferences().agentClient = json.encode(newApiResp.data);
    } else {
      if (UserPreferences().agentClient.toString().isEmpty) {
        _apiResponse = await service.getAgentClient();
        UserPreferences().agentClient = json.encode(_apiResponse.data);
      } else {
        _apiResponse = ApiResponse<AgentClient>(
          data:
              AgentClient.fromJson(json.decode(UserPreferences().agentClient)),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: "Rafraichir la page",
            icon: Icon(Icons.refresh_rounded),
            onPressed: () {
              _fetchData(true);
            },
          ),
        ],
        title: Text(
          "Cotiser",
          style: GoogleFonts.arya(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
        ),
      ),
      body: Builder(builder: (_) {
        if (_isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (_apiResponse.error) {
          return Center(
            child: Text(
              _apiResponse.errorMessage,
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          );
        }
        if (_apiResponse.data.agent.toString().isEmpty) {
          return Center(
            child: Text(
              "Aucune donnée pour le moment",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          );
        }
        return Container(
          padding: EdgeInsets.all(5),
          child: ListView(
            shrinkWrap: true,
            itemExtent: 160,
            children: [
              InkWell(
                onTap: () {
                  _showDialog(
                      "Chez l'agent", _apiResponse.data.account.mise, true);
                },
                child: Card(
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
              ),
              InkWell(
                onTap: () {
                  _showDialog(
                      "par Flooz", _apiResponse.data.account.mise, false);
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
                  _showDialog(
                      "par TMoney", _apiResponse.data.account.mise, false);
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
            ],
          ),
        );
      }),
    );
  }

  void _showDialog(String titre, String mise, bool dispo) {
    TextEditingController sommeController = TextEditingController();
    setState(() {
      sommeController.text = mise;
    });
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Cotiser " + titre),
          content: dispo
              ? Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: CupertinoTextField(
                        controller: sommeController,
                        keyboardType: TextInputType.number,
                        // enabled: false,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        placeholder: "Le montant ici..",
                        textAlign: TextAlign.center,
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
                        /*  titre == "Flooz"
                      ? CallAPi().launchUssd("*101#")
                      : Call APi().launchUssd("*444#");*/

                        var resp = CallAPi().postData({
                          "account": _apiResponse.data.account.id,
                          "amount": sommeController.text,
                          "agent": _apiResponse.data.agent.id,
                        }, "client/cotisation/journaliere/${_apiResponse.data.account.client_id}").whenComplete(
                            () {
                          Navigator.of(context).pop();
                        });
                        if (resp != null) {
                          print("resp = " + resp.toString());
                        } else
                          print("resp = Echec");
                      },
                    )),
                  ],
                )
              : Text("Bientot Dipo"),
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
