import 'dart:convert';

import 'package:finance/models/index.dart';
import 'package:finance/services/app_services.dart';
import 'package:finance/services/user_preferences.dart';
import 'package:finance/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:finance/api/api.dart';
import 'package:finance/pages/credits/create_demande.dart';
import 'package:finance/pages/credits/demande_delete.dart';

class MesCredit extends StatefulWidget {
  @override
  _MesCreditState createState() => _MesCreditState();
}

class _MesCreditState extends State<MesCredit> {
  MyAppServices get service => GetIt.I<MyAppServices>();

  ApiResponse<List<Credit>> _creditEpargne;
  ApiResponse<List<Credit>> _creditTontine;
  bool _isLoading;

  @override
  void initState() {
    _fetchCreditEpg(false);
    super.initState();
  }

  _fetchCreditEpg(bool getNew) async {
    setState(() {
      _isLoading = true;
    });
    if (getNew) {
      var newApiCE = await service.getCreditEpargneList();
      var newApiCT = await service.getCreditTontineList();
      setState(() {
        _creditEpargne = newApiCE;
        _creditTontine = newApiCT;
      });
      UserPreferences().creditEpargne = json.encode(newApiCE.data);
      UserPreferences().creditTontine = json.encode(newApiCT.data);
    } else {
      if (UserPreferences().creditEpargne.toString().isEmpty &&
          UserPreferences().creditTontine.toString().isEmpty) {
        /* epargne */
        _creditEpargne = await service.getCreditEpargneList();
        UserPreferences().creditEpargne = json.encode(_creditEpargne.data);
        /* tontine */
        _creditTontine = await service.getCreditTontineList();
        UserPreferences().creditTontine = json.encode(_creditTontine.data);
      } else {
        /* Credit Epargne */
        var creditEp = <Credit>[];
        print(json.decode(UserPreferences().creditEpargne));
        for (var index in json.decode(UserPreferences().creditEpargne)) {
          creditEp.add(Credit.fromJson(index));
        }
        _creditEpargne = ApiResponse<List<Credit>>(
          data: creditEp,
        );

        /* Credit Tontine */
        var creditTn = <Credit>[];
        print(json.decode(UserPreferences().creditTontine));
        for (var index in json.decode(UserPreferences().creditTontine)) {
          creditTn.add(Credit.fromJson(index));
        }
        _creditTontine = ApiResponse<List<Credit>>(
          data: creditTn,
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
          title: Text(
            "Mes Credits",
            style: GoogleFonts.arya(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: false,
          actions: [
            IconButton(
              tooltip: "Rafraichir la page",
              icon: Icon(Icons.refresh_rounded),
              onPressed: () {
                _fetchCreditEpg(true);
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => CreerDemande()));
          },
          child: Icon(Icons.add),
        ),
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_creditEpargne.error && _creditTontine.error) {
            return Center(
              child: Text(_creditEpargne.errorMessage),
            );
          }
          return SingleChildScrollView(
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
                      title: Text("Les Credits Epargne"),
                      subtitle: Text(
                        "(Appuyez pour developpez)",
                        style: TextStyle(fontSize: 12),
                      ),
                      children: [
                        SizedBox(
                          // height: 300,
                          child: Container(
                              child: ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder: (_, __) => Divider(
                              height: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                            itemCount: _creditEpargne.data.length,
                            itemBuilder: (context, index) {
                              return _creditEpargne.data.length != 0
                                  ? ListTile(
                                      leading: Container(
                                        height: 40,
                                        width: 70,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                                const Radius.circular(5.0),
                                            bottomRight:
                                                const Radius.circular(5.0),
                                            topLeft: const Radius.circular(5.0),
                                            topRight:
                                                const Radius.circular(5.0),
                                          ),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/recieved.png')),
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
                                        _creditEpargne.data[index].start_date !=
                                                null
                                            // ? 'Debuté le ${_creditEpargne.data[index].start_date.toString().substring(0, 10)}'
                                            ? 'Denuté le\n' +
                                                Utils().displayDate(
                                                    _creditEpargne
                                                        .data[index].start_date)
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _creditEpargne != null
                                                  ? '${_creditEpargne.data[index].amount} FCFA'
                                                  : "...FCFA",
                                              style: GoogleFonts.lato(
                                                color: Colors.blue[600],
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            _creditEpargne.data[index].is_closed
                                                ? Icon(
                                                    Icons.check_box,
                                                    size: 20,
                                                    color: Colors.green,
                                                  )
                                                : Icon(
                                                    Icons.cancel_outlined,
                                                    size: 20,
                                                    color: Colors.red,
                                                  )
                                          ],
                                        ),
                                      ),
                                      isThreeLine: true,
                                    )
                                  : Text("Aucune Donnée");
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
                      title: Text("Les Credits Tontine"),
                      subtitle: Text(
                        "(Appuyez pour developpez)",
                        style: TextStyle(fontSize: 12),
                      ),
                      children: [
                        SizedBox(
                          // height: 300,
                          child: Container(
                              child: ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: _creditTontine.data.length,
                            separatorBuilder: (_, __) => Divider(
                              height: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                            itemBuilder: (context, index) {
                              return _creditTontine.data.length != 0
                                  ? ListTile(
                                      leading: Container(
                                        height: 40,
                                        width: 70,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                                const Radius.circular(5.0),
                                            bottomRight:
                                                const Radius.circular(5.0),
                                            topLeft: const Radius.circular(5.0),
                                            topRight:
                                                const Radius.circular(5.0),
                                          ),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/recieved.png')),
                                        ),
                                      ),
                                      title: Row(
                                        children: [
                                          Text(
                                            'Credit Tontine',
                                            style: GoogleFonts.cinzel(
                                                color: Colors.black,
                                                letterSpacing: 0,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        _creditTontine.data[index].start_date !=
                                                null
                                            // ? 'Debuté le ${_creditTontine.data[index].start_date.toString().substring(0, 10)}'
                                            ? 'Denuté ' +
                                                Utils().displayDate(
                                                    _creditTontine
                                                        .data[index].start_date
                                                        .toString())
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _creditTontine != null
                                                  ? '${_creditTontine.data[index].amount} FCFA'
                                                  : "...FCFA",
                                              style: GoogleFonts.lato(
                                                color: Colors.blue[600],
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            _creditTontine.data[index].is_closed
                                                ? Icon(
                                                    Icons.check_box,
                                                    size: 20,
                                                    color: Colors.green,
                                                  )
                                                : Icon(
                                                    Icons.cancel_outlined,
                                                    size: 20,
                                                    color: Colors.red,
                                                  )
                                          ],
                                        ),
                                      ),
                                      isThreeLine: false,
                                    )
                                  : Text("Aucune Données");
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
          );
        }));
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
    /* builPopup end */
  }
}
