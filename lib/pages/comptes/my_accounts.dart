
import 'dart:convert';

import 'package:finance/pages/transactions/mes_transactions.dart';
import 'package:finance/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finance/api/api.dart';
import 'package:finance/models/account.dart';
import 'package:finance/pages/comptes/epargne.dart';
import 'package:finance/pages/comptes/tontine.dart';
import 'package:finance/services/app_services.dart';

class MyAccounts extends StatefulWidget {
  @override
  _MyAccountsState createState() => _MyAccountsState();
}

class _MyAccountsState extends State<MyAccounts> {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
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
              "Mes comptes",
              style: GoogleFonts.arya(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black54,
              tabs: [
                Tab(
                  child: Text(
                    'COMPTE TONTINE',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.account_balance,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  child: Text(
                    'COMPTE EPARGNE',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(Icons.account_box, color: Colors.white),
                ),
              ],
            ),
          ),
          body: Builder(
            builder: (_) {
              if (_isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (_apiResponse.error) {
                return Center(
                  child: Text(_apiResponse.errorMessage),
                );
              }
              if (_apiResponse.data.epargne.toString().isEmpty ||
                  _apiResponse.data.tontine.toString().isEmpty) {
                return TabBarView(
                  children: [
                    Text(
                      "Aucune donnée pour le moment",
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ),
                    Text(
                      "Aucune donnée pour le moment",
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ),
                  ],
                );
              }
              return TabBarView(
                children: [
                  Tontine(tontine: _apiResponse.data.tontine),
                  Epargne(epargne: _apiResponse.data.epargne),
                ],
              );
            },
          )),
    );
  }
}
