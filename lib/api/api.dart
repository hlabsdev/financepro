import 'dart:convert';

import 'package:finance/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ussd/ussd.dart';

class CallAPi {
  final String _url = "https://financepro.proxymall.store/api/";
  // final String _url = "http://flatnyeapi.nunyalabprojets.com/api/";

  postData(data, apiUrl) async {
    var fulUrl = _url + apiUrl;
    return http.post(
      fulUrl,
      // body: json.encode(data),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  getData(apiUrl) async {
    var fulUrl = _url + apiUrl;
    return await http.get(
      fulUrl,
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  launchUssd(String ussdCode) async {
    Ussd.runUssd(ussdCode);
  }

  logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
  }
}
