import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:finance/api/api.dart';
import 'package:finance/pages/credits/create_demande.dart';
import 'package:finance/pages/credits/demande_delete.dart';

class MesCredit extends StatefulWidget {
  @override
  _MesCreditState createState() => _MesCreditState();
}

class _MesCreditState extends State<MesCredit> {
  var userData;
  var creditEpargne;
  var creditTontine;
  @override
  void initState() {
    getUserLoanInfos();
    super.initState();
  }

  Future<void> getUserLoanInfos() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString("client");
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });

    if (localStorage.containsKey("creditEpargne")) {
      var test = localStorage.getString("creditTontine");
      print(json.decode(test));
    } else {
      var res =
          await CallAPi().getData("client/accounts/loan/${userData["id"]}");
      var body = json.decode(res.body);
      print(body);
      // localStorage.setString("accounts", json.encode(body[0]));
      localStorage.setString(
          "creditEpargne", json.encode(body["saving_loans"]));
      localStorage.setString(
          "creditTontine", json.encode(body["tontine_loans"]));

      setState(() {
        creditEpargne = json.decode(localStorage.getString("creditEpargne"));
        creditTontine = json.decode(localStorage.getString("creditTontine"));
      });
    }
  }

  getLoanDetail() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var res = await CallAPi()
        .getData("client/accounts/loan/${userData["id"]}/detail");
    var body = json.decode(res.body);
    print(body);
    // localStorage.setString("accounts", json.encode(body[0]));
    localStorage.setString("creditEpargne", json.encode(body["saving_loans"]));
    localStorage.setString("creditTontine", json.encode(body["tontine_loans"]));
  }

  Future<void> _refreshPage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var res = await CallAPi().getData("client/accounts/${userData["id"]}");
    var body = json.decode(res.body);
    print(body);
    // localStorage.setString("accounts", json.encode(body[0]));
    localStorage.setString("Epargne", json.encode(body["Epargne"]));
    localStorage.setString("Tontine", json.encode(body["Tontine"]));
    setState(() {
      this.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mes Credits",
          style: GoogleFonts.arya(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CreerDemande()));
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 10,
              child: Container(
                child: ExpansionTile(
                  leading: Icon(
                    Icons.credit_card_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 50,
                  ),
                  title: Text("Les Credits en cours"),
                  subtitle: Text(
                    "(Appuyez pour developpez)",
                    style: TextStyle(fontSize: 12),
                  ),
                  children: [
                    SizedBox(
                      height: 300,
                      child: Container(
                          child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              height: 40,
                              width: 70,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: const Radius.circular(5.0),
                                  bottomRight: const Radius.circular(5.0),
                                  topLeft: const Radius.circular(5.0),
                                  topRight: const Radius.circular(5.0),
                                ),
                                image: DecorationImage(
                                    image: AssetImage('images/recieved.png')),
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  'Credit Epargne',
                                  style: GoogleFonts.cinzel(
                                      color: Colors.black,
                                      letterSpacing: 0,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              creditEpargne != null
                                  ? 'Denuté le ${creditEpargne["start_date"]}'
                                  : "Debuté le 12-O9-2020",
                              style: GoogleFonts.lato(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    creditEpargne != null
                                        ? '${creditEpargne["amount"]} FCFA'
                                        : "...FCFA",
                                    style: GoogleFonts.lato(
                                      color: Colors.blue[600],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            ),
                            isThreeLine: false,
                          );
                        },
                      )),
                    )
                  ],
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  expandedAlignment: Alignment.bottomCenter,
                  // leading: ,
                  childrenPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: Container(
                child: ExpansionTile(
                  leading: Icon(
                    Icons.receipt_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 50,
                  ),
                  title: Text("Les Credits deja remboursés"),
                  subtitle: Text(
                    "(Appuyez pour developpez)",
                    style: TextStyle(fontSize: 12),
                  ),
                  children: [
                    SizedBox(
                      height: 300,
                      child: Container(
                          child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: 10,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              height: 40,
                              width: 70,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: const Radius.circular(5.0),
                                  bottomRight: const Radius.circular(5.0),
                                  topLeft: const Radius.circular(5.0),
                                  topRight: const Radius.circular(5.0),
                                ),
                                image: DecorationImage(
                                    image: AssetImage('images/recieved.png')),
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  'Cotisation du ',
                                  style: GoogleFonts.cinzel(
                                      color: Colors.black,
                                      letterSpacing: 0,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              '17 Dec, 2020',
                              style: GoogleFonts.lato(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '\550 FCFA',
                                    style: GoogleFonts.lato(
                                      color: Colors.blue[600],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            ),
                            isThreeLine: false,
                          );
                        },
                      )),
                    )
                  ],
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  expandedAlignment: Alignment.bottomCenter,
                  // leading: ,
                  childrenPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            Card(
              elevation: 12,
              child: ExpansionTile(
                leading: Icon(
                  Icons.request_quote_sharp,
                  color: Theme.of(context).primaryColor,
                  size: 50,
                ),
                title: Text("Mes demandes"),
                subtitle: Text(
                  "(Appuyez pour developpez)",
                  style: TextStyle(fontSize: 12),
                ),
                children: [
                  SizedBox(
                    height: 260,
                    child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      separatorBuilder: (_, __) => Divider(
                        height: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                      itemBuilder: (_, index) {
                        return Dismissible(
                          key: ValueKey(index),
                          background: Container(
                            color: Colors.red[900],
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {},
                          confirmDismiss: (direction) async {
                            final result = await showDialog(
                              context: context,
                              builder: (_) => DemandeDelete(),
                            );
                            return result;
                          },
                          child: ListTile(
                            title: Text("Demande $index"),
                            subtitle: Text(
                              '12 Mars, 2020',
                              style: GoogleFonts.lato(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    index % 2 != 0
                                        ? 'traitement encours...'
                                        : 'demande rejetée!',
                                    style: GoogleFonts.lato(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Icon(
                                    index % 2 != 0
                                        ? Icons.more_horiz_outlined
                                        : Icons.cancel_outlined,
                                    size: 20,
                                    color: index % 2 != 0
                                        ? Colors.blue[600]
                                        : Colors.red,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        dragStartBehavior: DragStartBehavior.start,
      ),
    );
  }

  /* builPopup deb */
  Widget _buildPopupDialog(BuildContext context) {
    return new CupertinoAlertDialog(
      title: const Text('Demande de credit'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
    /* return new AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    ); */
  }
  /* builPopup end */
}
