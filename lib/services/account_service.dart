import 'dart:convert';
import 'package:finance/models/index.dart';
import 'package:http/http.dart' as http;
import 'package:finance/api/api.dart';
import 'package:finance/models/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  CallAPi api = CallAPi();
  static const API = "https://financepro.proxymall.store/api/";
  static const headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<ApiResponse<Account>> getAccount() async {
    // var userData;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString("client"));
    // return api.getData("client/accounts/${user["id"]}")
    return http
        .get(API + "client/accounts/${user["id"]}", headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        // final ton = jsonData["Tontine"];

        final e = Type_acc(
          acc_num: jsonData["Epargne"]["acc_num"],
          id: jsonData["Epargne"]["id"],
          account_type_id: jsonData["Epargne"]["account_type_id"],
          amount_blocked: jsonData["Epargne"]["amount_blocked"],
          balance: jsonData["Epargne"]["balance"],
          block_end_date: jsonData["Epargne"]["block_end_date"],
          block_period: jsonData["Epargne"]["block_period"],
          client_id: jsonData["Epargne"]["client_id"],
          created_at: jsonData["Epargne"]["created_at"],
          creator_id: jsonData["Epargne"]["creator_id"],
          mise: jsonData["Epargne"]["mise"],
          nanti: jsonData["Epargne"]["nanti"],
          state: jsonData["Epargne"]["state"],
          updated_at: jsonData["Epargne"]["updated_at"],
        );

        final t = Type_acc(
          acc_num: jsonData["Tontine"]["acc_num"],
          id: jsonData["Tontine"]["id"],
          account_type_id: jsonData["Tontine"]["account_type_id"],
          amount_blocked: jsonData["Tontine"]["amount_blocked"],
          balance: jsonData["Tontine"]["balance"],
          block_end_date: jsonData["Tontine"]["block_end_date"],
          block_period: jsonData["Tontine"]["block_period"],
          client_id: jsonData["Tontine"]["client_id"],
          created_at: jsonData["Tontine"]["created_at"],
          creator_id: jsonData["Tontine"]["creator_id"],
          mise: jsonData["Tontine"]["mise"],
          nanti: jsonData["Tontine"]["nanti"],
          state: jsonData["Tontine"]["state"],
          updated_at: jsonData["Tontine"]["updated_at"],
        );

        final account = Account(epargne: e, tontine: t);
        return ApiResponse<Account>(
          data: account,
        );
      }
      return ApiResponse<Account>(
        error: true,
        erorMessage: "Une erreur s'est produite!",
      );
    }).catchError((_) => ApiResponse<Account>(
              error: true,
              erorMessage: "Une erreur s'est produite!",
            ));
  }
}
