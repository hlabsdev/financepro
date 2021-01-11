import 'package:finance/api/api.dart';
import 'package:finance/models/account.dart';
import 'package:finance/services/app_services.dart';
import 'package:finance/utils/refreshable_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class MesTansfert extends StatefulWidget {
  @override
  _MesTansfertState createState() => _MesTansfertState();
}

class _MesTansfertState extends State<MesTansfert> {
  MyAppServices get service => GetIt.I<MyAppServices>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var userData;
  ApiResponse<Account> _apiResponse;
  bool _isLoading;
  // Account compte;

  @override
  void initState() {
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

  Future<Null> _refreshPage() async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mes Transferts",
          style: GoogleFonts.arya(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        // centerTitle: true,
      ),
      body: Builder(builder: (_) {
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
        return RefreshableView(
          refreshIndicatorKey: _refreshIndicatorKey,
          refreshPage: _refreshPage(),
          child: Center(
              child: Text(
            "Bientot Disponible (-_-)",
            style: GoogleFonts.arya(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )),
        );
      }),
    );
  }
}
