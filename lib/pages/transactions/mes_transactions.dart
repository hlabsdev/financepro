import 'dart:convert';

import 'package:finance/api/api.dart';
import 'package:finance/models/index.dart';
import 'package:finance/services/app_services.dart';
import 'package:finance/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTransactions extends StatefulWidget {
  @override
  _MyTransactionsState createState() => _MyTransactionsState();
}

class _MyTransactionsState extends State<MyTransactions> {
  String _selectedItem = "";
  MyAppServices get service => GetIt.I<MyAppServices>();
  ApiResponse<List<Transaction>> _depotEpargne;
  ApiResponse<List<Transaction>> _retraitEpargne;
  ApiResponse<List<Transaction>> _depotTontine;
  ApiResponse<List<Transaction>> _retraitTontine;
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
      var newApiDE = await service.getEpargneDepot();
      var newApiRE = await service.getEpargneRetrait();
      var newApiDT = await service.getTontineDepot();
      var newApiRT = await service.getTontineRetrait();
      setState(() {
        _depotEpargne = newApiDE;
        _retraitEpargne = newApiRE;
        _depotTontine = newApiDT;
        _retraitTontine = newApiRT;
      });
      UserPreferences().depotEpargne = json.encode(newApiDE.data);
      UserPreferences().retraitEpargne = json.encode(newApiRE.data);
      UserPreferences().depotTontine = json.encode(newApiDT.data);
      UserPreferences().retraitTontine = json.encode(newApiRT.data);
    } else {
      if (UserPreferences().depotEpargne.toString().isEmpty &&
          UserPreferences().depotTontine.toString().isEmpty &&
          UserPreferences().retraitEpargne.toString().isEmpty &&
          UserPreferences().retraitTontine.toString().isEmpty) {
        /* epargne */
        _retraitEpargne = await service.getEpargneRetrait();
        _depotEpargne = await service.getEpargneDepot();
        UserPreferences().retraitEpargne = json.encode(_retraitEpargne.data);
        UserPreferences().depotEpargne = json.encode(_depotEpargne.data);
        /* tontine */
        _retraitTontine = await service.getTontineRetrait();
        _depotTontine = await service.getTontineDepot();
        UserPreferences().retraitTontine = json.encode(_retraitTontine.data);
        UserPreferences().depotTontine = json.encode(_depotTontine.data);
        /* tontine */
      } else {
        /* Operation Epargne */
        var depotEp = <Transaction>[];
        for (var index in json.decode(UserPreferences().depotEpargne)) {
          depotEp.add(Transaction.fromJson(index));
        }
        _depotEpargne = ApiResponse<List<Transaction>>(
          data: depotEp,
        );

        var retraitEp = <Transaction>[];
        for (var index in json.decode(UserPreferences().retraitEpargne)) {
          retraitEp.add(Transaction.fromJson(index));
        }
        _retraitEpargne = ApiResponse<List<Transaction>>(
          data: retraitEp,
        );
        /* Operation Tontine */
        var depotTn = <Transaction>[];
        for (var index in json.decode(UserPreferences().depotTontine)) {
          depotTn.add(Transaction.fromJson(index));
        }
        _depotTontine = ApiResponse<List<Transaction>>(
          data: depotTn,
        );

        var retraitTn = <Transaction>[];
        for (var index in json.decode(UserPreferences().retraitTontine)) {
          retraitTn.add(Transaction.fromJson(index));
        }
        _retraitTontine = ApiResponse<List<Transaction>>(
          data: retraitTn,
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
          "Details des Transactions",
          style: GoogleFonts.arya(
              fontSize: 20,
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
        if (_depotEpargne.error ||
            _depotTontine.error ||
            _retraitEpargne.error ||
            _retraitTontine.error) {
          return Center(
            child: Text(
              "Il semble que quelque chose ait mal tourné au moment de la conexion!",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          );
        }
        // ignore: unrelated_type_equality_checks
        if (_depotEpargne.data == [] &&
            _depotTontine.data == [] &&
            _retraitEpargne.data == [] &&
            _retraitTontine.data == []) {
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
        return SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              Container(
                child: ExpansionTile(
                  leading: Icon(
                    Icons.credit_card_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 50,
                  ),
                  title: Text("Les Transaction Epargnes"),
                  subtitle: Text(
                    "(Appuyez pour developpez)",
                    style: TextStyle(fontSize: 12),
                  ),
                  children: [
                    Container(
                        child: ListView.separated(
                      shrinkWrap: true,
                      primary: true,
                      addRepaintBoundaries: true,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                      itemCount: _depotEpargne.data.length,
                      itemBuilder: (context, index) {
                        return _depotEpargne.data.length != 0
                            ? InkWell(
                                onTap: () {
                                  _onButtonPressed(
                                      "Epargne",
                                      "Depot",
                                      _depotEpargne.data[index].created_at
                                          .toString(),
                                      _depotEpargne.data[index].amount
                                          .toString());
                                },
                                child: OperationTile())
                            : Text("Aucune Donnée");
                      },
                    )),
                    Container(
                        child: ListView.separated(
                      shrinkWrap: true,
                      primary: true,
                      addRepaintBoundaries: true,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                      itemCount: _retraitEpargne.data.length,
                      itemBuilder: (context, index) {
                        return _retraitEpargne.data.length != 0
                            ? InkWell(
                                onTap: () {
                                  _onButtonPressed(
                                      "Epargne",
                                      "Retrait",
                                      _retraitEpargne.data[index].created_at
                                          .toString(),
                                      _retraitEpargne.data[index].amount
                                          .toString());
                                },
                                child: OperationTile())
                            : Text("Aucune Donnée");
                      },
                    ))
                  ],
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  expandedAlignment: Alignment.bottomCenter,
                  // leading: ,
                  childrenPadding: EdgeInsets.all(20),
                ),
              ),
              /*=========== Tontine =========*/
              /*=========== Epargne =========*/
              Container(
                child: ExpansionTile(
                  leading: Icon(
                    Icons.payments,
                    color: Theme.of(context).primaryColor,
                    size: 50,
                  ),
                  title: Text("Les Transaction Tontines"),
                  subtitle: Text(
                    "(Appuyez pour developpez)",
                    style: TextStyle(fontSize: 12),
                  ),
                  children: [
                    Container(
                        child: ListView.separated(
                      shrinkWrap: true,
                      primary: true,
                      addRepaintBoundaries: true,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                      itemCount: _depotTontine.data.length,
                      itemBuilder: (context, index) {
                        return _depotTontine.data.length != 0
                            ? InkWell(
                                onTap: () {
                                  _onButtonPressed(
                                      "Tontine",
                                      "Cotisation",
                                      _depotTontine.data[index].created_at
                                          .toString(),
                                      _depotTontine.data[index].amount
                                          .toString());
                                },
                                child: OperationTile())
                            : Text("Aucune Donnée");
                      },
                    )),
                    Container(
                        child: ListView.separated(
                      shrinkWrap: true,
                      primary: true,
                      addRepaintBoundaries: true,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                      itemCount: _retraitTontine.data.length,
                      itemBuilder: (context, index) {
                        return _retraitTontine.data.length != 0
                            ? InkWell(
                                onTap: () {
                                  _onButtonPressed(
                                      "Tontine",
                                      "Retrait",
                                      _retraitTontine.data[index].created_at
                                          .toString(),
                                      _retraitTontine.data[index].amount
                                          .toString());
                                },
                                child: OperationTile())
                            : Text("Aucune Donnée");
                      },
                    ))
                  ],
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  expandedAlignment: Alignment.bottomCenter,
                  // leading: ,
                  childrenPadding: EdgeInsets.all(20),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

/* Appeler le bottom sheet deb */
  void _onButtonPressed(
      String account, String type, String date, String amount) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 180,
            child: Container(
              child: _buildBottomNavigationMenu(account, type, date, amount),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  Column _buildBottomNavigationMenu(
      String account, String type, String date, String amount) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_balance),
          title: Text(account),
          onTap: () => _selectItem('Kotlin'),
        ),
        ListTile(
          leading: Icon(Icons.style),
          title: Text(type),
          onTap: () => _selectItem('Flutter'),
        ),
        ListTile(
          leading: Icon(Icons.date_range),
          title: Text(date),
          onTap: () => _selectItem('Flutter'),
        ),
        ListTile(
          leading: Icon(Icons.wallet_giftcard),
          title: Text(amount),
          onTap: () => _selectItem('Android'),
        ),
      ],
    );
  }

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      _selectedItem = name;
    });
  }
/* Appeler le bottom sheet end */
}

/* hors classe */
class OperationTile extends StatelessWidget {
  final Transaction trans;

  const OperationTile({
    Key key,
    this.trans,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(5.0),
            bottomRight: const Radius.circular(5.0),
            topLeft: const Radius.circular(5.0),
            topRight: const Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 6.0, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
              offset: Offset(
                0, // Move to right 10  horizontally
                4, // Move to bottom 10 Vertically
              ),
            )
          ]),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(5.0),
              bottomRight: const Radius.circular(5.0),
              topLeft: const Radius.circular(5.0),
              topRight: const Radius.circular(5.0),
            ),
            image: DecorationImage(image: AssetImage('images/Money.png')),
          ),
        ),
        title: Row(
          children: [
            Text(
              'Date : ',
              style: GoogleFonts.cinzel(
                  color: Colors.black,
                  letterSpacing: 0,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        subtitle: Text(
          '${trans.created_at}',
          /* Utils().displayDate(trans.start_date) */
          style: GoogleFonts.lato(
              color: Colors.grey[600],
              fontSize: 13,
              fontWeight: FontWeight.normal),
        ),
        trailing: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${trans.amount} FCFA',
                style: GoogleFonts.lato(
                  color: Colors.blue[600],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Icon(
                Icons.money,
                size: 20,
                color: Colors.red,
              )
            ],
          ),
        ),
        isThreeLine: false,
      ),
    );
  }
}
