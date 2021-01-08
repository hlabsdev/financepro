import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ussd/ussd.dart';

import 'package:finance/login.dart';

class CallAPi {
  final String _url = "https://financepro.proxymall.store/api/";
  var status;
  var statusCode;
  var token;

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

  login(String email, String password) async {
    final response = await http.post("${_url}client/auth",
        headers: _setHeaders(),
        body: jsonEncode({"email": "$email", "password": "$password"}));

    // statusCode = response.statusCode;
    status = response.body.contains('error');
    status = response.body.isEmpty;
    var data = json.decode(response.body);

    if (status) {
      print("data: $data['error]");
    } else {
      print("data: $data");
      _saveUser(data);
    }
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _saveUser(var body) async {
    final localStorage = await SharedPreferences.getInstance();
    localStorage.setString("token", body["token"]);
    localStorage.setString("client", json.encode(body["client"]));
  }

  readUser() async {
    final localStorage = await SharedPreferences.getInstance();
    // final token = localStorage.getString("token") ?? 0;
    final user = localStorage.getString("client") ?? 0;
    return user;
  }

  launchUssd(String ussdCode) async {
    Ussd.runUssd(ussdCode);
  }

  logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
  }
}

class ApiResponse<T> {
  T data;
  bool error;
  String erorMessage;

  ApiResponse({
    this.data,
    this.error = false,
    this.erorMessage,
  });
}
