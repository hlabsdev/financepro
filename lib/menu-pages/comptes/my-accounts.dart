import 'dart:convert';

import 'package:finance/api/api.dart';
import 'package:finance/menu-pages/comptes/epargne.dart';
import 'package:finance/menu-pages/comptes/tont2.dart';
import 'package:finance/menu-pages/comptes/tontine.dart';
import 'package:finance/menu-pages/mes-transactions.dart';
import 'package:finance/menu-pages/mon-agent.dart';
import 'package:finance/models/account.dart';
import 'package:finance/services/account_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccounts extends StatefulWidget {
  @override
  _MyAccountsState createState() => _MyAccountsState();
}

class _MyAccountsState extends State<MyAccounts> {
  AccountService get service => GetIt.I<AccountService>();

  var userData;
  ApiResponse<Account> _apiResponse;
  bool _isLoading;
  // Account compte;

  @override
  void initState() {
    getUserAccountsInfos();
    _fetchAccount();
    super.initState();
  }

  _fetchAccount() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getAccount();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getUserAccountsInfos() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString("client");
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
/* 
    if (localStorage.containsKey("Epargne")) {
      var test = localStorage.getString("Epargne");
      print(json.decode(test));
    } else {
      var res = await CallAPi().getData("client/accounts/${userData["id"]}");
      var body = json.decode(res.body);
      print(body);
      // localStorage.setString("accounts", json.encode(body[0]));
      localStorage.setString("Epargne", json.encode(body["Epargne"]));
      localStorage.setString("Tontine", json.encode(body["Tontine"]));
    } */
  }

  Future<void> _refreshPage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var res = await CallAPi().getData("client/accounts/${userData["id"]}");
    var body = json.decode(res.body);
    print(body);
    // localStorage.setString("accounts", json.encode(body[0]));
    localStorage.setString("Epargne", json.encode(body["Epargne"]));
    localStorage.setString("Tontine", json.encode(body["Tontine"]));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
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
                  icon: Icon(Icons.account_balance),
                  text: 'Compte Tontine',
                ),
                Tab(
                  icon: Icon(Icons.account_box),
                  text: 'Compte Epargne',
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
                  child: Text(_apiResponse.erorMessage),
                );
              }
              return TabBarView(
                children: [
                  // Tontine(_apiResponse.data.tontine),
                  Tontine(tontine: _apiResponse.data.tontine),
                  Epargne(epargne: _apiResponse.data.epargne),
                  // Epargne(),
                ],
              );
            },
          )),
    );
  }
}
