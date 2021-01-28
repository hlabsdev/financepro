import 'dart:convert';

import 'package:finance/api/api.dart';
import 'package:finance/models/account.dart';
import 'package:finance/services/app_services.dart';
import 'package:finance/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class MesTansfert extends StatefulWidget {
  @override
  _MesTansfertState createState() => _MesTansfertState();
}

class _MesTansfertState extends State<MesTansfert> {
  MyAppServices get service => GetIt.I<MyAppServices>();

  var userData;
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
          "Mes Transferts",
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
        // ignore: unrelated_type_equality_checks
        if (_apiResponse.data == []) {
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
        return Center(
            child: Text(
          "Bientot Disponible (-_-)",
          style: GoogleFonts.arya(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ));
      }),
    );
  }
}
