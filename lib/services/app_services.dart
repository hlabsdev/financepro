import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:finance/api/api.dart';
import 'package:finance/models/account.dart';
import 'package:finance/models/index.dart';

class MyAppServices {
  CallAPi api = CallAPi();
  static const API = "https://financepro.proxymall.store/api/";
  static const headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  /* ===== Tout ce qui concerne Account deb ===== */
  Future<ApiResponse<Account>> getAccount() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final user = json.decode(localStorage.getString("client"));

    return http
        .get(API + "client/accounts/${user["id"]}", headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        final account = Account(
            epargne: Type_acc.fromJson(jsonData["Epargne"]),
            tontine: Type_acc.fromJson(jsonData["Tontine"]));
        return ApiResponse<Account>(
          data: account,
        );
      }
      return ApiResponse<Account>(
        error: true,
        errorMessage: "Une erreur s'est produite!",
      );
    }).catchError((_) => ApiResponse<Account>(
              error: true,
              errorMessage: "Une erreur s'est produite!",
            ));
  }
  /* ===== Tout ce qui concerne Account end ===== */

  /* ===== Tout ce qui concerne Credit deb ===== */
  Future<ApiResponse<List<Credit>>> getCreditTontineList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final user = json.decode(localStorage.getString("client"));

    return http
        .get(API + "client/accounts/loan/${user["id"]}", headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final creditTontines = <Credit>[];
        for (var item in jsonData["tontine_loans"]) {
          creditTontines.add(Credit.fromJson(item));
        }
        return ApiResponse<List<Credit>>(data: creditTontines);
      }
      return ApiResponse<List<Credit>>(
          error: true, errorMessage: "Une erreur s'est produite!");
    }).catchError((_) => ApiResponse<List<Credit>>(
            error: true, errorMessage: "Une erreur s'est produite!"));
  }

  Future<ApiResponse<List<Credit>>> getCreditEpargneList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final user = json.decode(localStorage.getString("client"));

    return http
        .get(API + "client/accounts/loan/${user["id"]}", headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final creditEpargne = <Credit>[];
        for (var item in jsonData["saving_loans"]) {
          creditEpargne.add(Credit.fromJson(item));
        }
        return ApiResponse<List<Credit>>(data: creditEpargne);
      }
      return ApiResponse<List<Credit>>(
          error: true, errorMessage: "Une erreur s'est produite!");
    }).catchError((_) => ApiResponse<List<Credit>>(
            error: true, errorMessage: "Une erreur s'est produite!"));
  }

  Future<ApiResponse<List<Payement>>> getDetailCredit(String creditID) {
    return http
        .get(API + "client/account/loans/" + creditID + "/detail",
            headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final payements = <Payement>[];
        for (var item in jsonData["repayments"]) {
          payements.add(Payement.fromJson(item));
        }
        return ApiResponse<List<Payement>>(data: payements);
      }
      return ApiResponse<List<Payement>>(
          error: true, errorMessage: "Une erreur s'est produite!");
    }).catchError((_) => ApiResponse<List<Payement>>(
            error: true, errorMessage: "Une erreur s'est produite!"));
  }

/* Future<ApiResponse<Payement>> getNote(String noteID) {
    return http
        .get(API + "client/account/loans/" + noteID + "/detail",
            headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return ApiResponse<Payement>(data: Payement.fromJson(jsonData));
      }
      return ApiResponse<Payement>(
          error: true, errorMessage: "Une erreur s'est produite!");
    }).catchError((_) => ApiResponse<Payement>(
            error: true, errorMessage: "Une erreur s'est produite!"));
  }
  Future<ApiResponse<bool>> createNote(NoteInsert item) {
    return http
        .post(API + '/notes',
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return ApiResponse<bool>(data: true);
      }
      return ApiResponse<bool>(
          error: true, errorMessage: "Une erreur s'est produite!");
    }).catchError((_) => ApiResponse<bool>(
            error: true, errorMessage: "Une erreur s'est produite!"));
  } */
  /* ===== Tout ce qui concerne Credit end ===== */

  /* ===== Tout ce qui concerne Carnet deb ===== */
  Future<ApiResponse<List<Mois>>> getMoisList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final user = json.decode(localStorage.getString("client"));

    return http
        .get(API + "client/carnet-tontine/${user["id"]}", headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final listMois = <Mois>[];
        for (var item in jsonData["carnets"]) {
          listMois.add(Mois.fromJson(item));
        }
        return ApiResponse<List<Mois>>(data: listMois);
      }
      return ApiResponse<List<Mois>>(
          error: true, errorMessage: "Une erreur s'est produite!");
    }).catchError((_) => ApiResponse<List<Mois>>(
            error: true, errorMessage: "Une erreur s'est produite!"));
  }

  // Future<ApiResponse<List<Payement>>> getDetailMois(String creditID) {
  //   return http
  //       .get(API + "client/account/loans/" + creditID + "/detail",
  //           headers: headers)
  //       .then((data) {
  //     if (data.statusCode == 200) {
  //       final jsonData = json.decode(data.body);
  //       final payements = <Payement>[];
  //       for (var item in jsonData["repayments"]) {
  //         payements.add(Payement.fromJson(item));
  //       }
  //       return ApiResponse<List<Payement>>(data: payements);
  //     }
  //     return ApiResponse<List<Payement>>(
  //         error: true, errorMessage: "Une erreur s'est produite!");
  //   }).catchError((_) => ApiResponse<List<Payement>>(
  //           error: true, errorMessage: "Une erreur s'est produite!"));
  // }
  /* ===== Tout ce qui concerne Carnet end ===== */

}
