import 'dart:convert';

import 'package:http/http.dart' as http;

class CallAPi {
  final String _url = "http://192.168.1.135:8000/api/";
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

  getData(data, apiUrl) async {
    var fulUrl = _url + apiUrl;
    return await http.get(
      fulUrl,
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        // 'Accept': 'application/json',
      };
}
