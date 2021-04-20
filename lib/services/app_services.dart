import 'dart:convert';

import 'package:finance/models/agent_client.dart';
import 'package:finance/services/user_preferences.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:finance/api/api.dart';
import 'package:finance/models/account.dart';
import 'package:finance/models/index.dart';

import '../models/microfinance.dart';

class MyAppServices {
  CallAPi api = CallAPi();
  static const API = "https://financepro.proxymall.store/api/";
  static const headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  /* ===== Tout ce qui concerne Account deb ===== */
  Future<ApiResponse<Account>> getAccount() async {
    final user = json.decode(UserPreferences().client);
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

  Future<ApiResponse<Agent_client>> getAgentClient() async {
    final user = json.decode(UserPreferences().client);
    return http
        .get(API + "client/agent/${user["id"]}", headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        // final jsonData = json.decode(data.body);
        final jsonData = jsonDecode(data.body);

        final agentClient = Agent_client(
            account: Type_acc.fromJson(jsonData["account"]),
            agent: Client.fromJson(jsonData["agent"]));
        return ApiResponse<Agent_client>(
          data: agentClient,
        );
      }
      return ApiResponse<Agent_client>(
        error: true,
        errorMessage: "Une erreur s'est produite!",
      );
    }).catchError((_) => ApiResponse<Agent_client>(
          error: true,
          errorMessage: "Une erreur s'est produite!",
        ));
  }

  Future<ApiResponse<Client>> getAgent() async {
    final user = json.decode(UserPreferences().client);
    return http
        .get(API + "client/agent/${user["id"]}", headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        // final jsonData = jsonDecode(data.body);

        final agentClient = Client.fromJson(jsonData["agent"]);
        print(agentClient);
        return ApiResponse<Client>(
          data: agentClient,
        );
      }
      return ApiResponse<Client>(
        error: true,
        errorMessage: "Une erreure s'est produite!",
      );
    }).catchError((_) => ApiResponse<Client>(
          error: true,
          errorMessage: "Une erreur s'est produite!",
        ));
  }

  /* ===== Tout ce qui concerne Account end ===== */

  /* ===== Tout ce qui concerne Credit deb ===== */
  Future<ApiResponse<List<Credit>>> getCreditTontineList() async {
    final user = json.decode(UserPreferences().client);
    return http
        .get(API + "client/accounts/loan/${user["id"]}", headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final creditTontines = <Credit>[];
        if (jsonData["tontine_loans"].toString().isNotEmpty) {
          for (var item in jsonData["tontine_loans"]) {
            creditTontines.add(Credit.fromJson(item));
          }
          return ApiResponse<List<Credit>>(data: creditTontines);
        } else {
          return ApiResponse<List<Credit>>(
              error: true, errorMessage: "Une erreur s'est produite!");
        }
      }
      return ApiResponse<List<Credit>>(
          error: true, errorMessage: "Une erreur s'est produite!");
    }).catchError((_) => ApiResponse<List<Credit>>(
            error: true, errorMessage: "Une erreur s'est produite!"));
  }

  Future<ApiResponse<List<Credit>>> getCreditEpargneList() async {
    final user = json.decode(UserPreferences().client);

    return http
        .get(API + "client/accounts/loan/${user["id"]}", headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final creditEpargne = <Credit>[];
        if (jsonData["saving_loans"].toString().isNotEmpty) {
          for (var item in jsonData["saving_loans"]) {
            creditEpargne.add(Credit.fromJson(item));
          }
          return ApiResponse<List<Credit>>(data: creditEpargne);
        }
      } else {
        return ApiResponse<List<Credit>>(
            error: true, errorMessage: "Une erreur s'est produite!");
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
*/

/*  
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
    final user = json.decode(UserPreferences().client);

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
  /* ===== Tout ce qui concerne Carnet end ===== */

  /* ===== Tout ce qui concerne La microfinance deb ===== */
  Future<ApiResponse<Microfinance>> getMyMicrofinance() async {
    final user = json.decode(UserPreferences().client);
    return http
        .get(API + "client/microfinance/${user["id"]}", headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        final myMicrofin = Microfinance.fromJson(jsonData["microfinance"]);
        return ApiResponse<Microfinance>(
          data: myMicrofin,
        );
      }
      return ApiResponse<Microfinance>(
        error: true,
        errorMessage: "Une erreur s'est produite!",
      );
    }).catchError((_) => ApiResponse<Microfinance>(
              error: true,
              errorMessage: "Une erreur s'est produite!",
            ));
  }
  /* ===== Tout ce qui concerne La microfinance end ===== */

  /* ===== Tout ce qui concerne Les Transactions deb ===== */
  Future<ApiResponse<List<Transaction>>> getTontineRetrait() {
    final user = json.decode(UserPreferences().client);
    return http
        .get(API + "client/accounts/transaction-liste/${user["id"]}",
            headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final tontineRetrait = <Transaction>[];
        if (jsonData["transactions"]["tontine"]["withdrawals"]
            .toString()
            .isNotEmpty) {
          for (var item in jsonData["transactions"]["tontine"]["withdrawals"]) {
            tontineRetrait.add(Transaction.fromJson(item));
          }
          return ApiResponse<List<Transaction>>(data: tontineRetrait);
        } else {
          return ApiResponse<List<Transaction>>(
              error: true, errorMessage: "Une erreur s'est produite!");
        }
      }
      return ApiResponse<List<Transaction>>(
          error: true, errorMessage: "Une erreur s'est produite!");
    }).catchError((_) => ApiResponse<List<Transaction>>(
            error: true, errorMessage: "Une erreur s'est produite!"));
  }

  Future<ApiResponse<List<Transaction>>> getTontineDepot() {
    final user = json.decode(UserPreferences().client);
    return http
        .get(API + "client/accounts/transaction-liste/${user["id"]}",
            headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final tontineRetrait = <Transaction>[];
        if (jsonData["transactions"]["tontine"]["deposits"]
            .toString()
            .isNotEmpty) {
          for (var item in jsonData["transactions"]["tontine"]["deposits"]) {
            tontineRetrait.add(Transaction.fromJson(item));
          }
          return ApiResponse<List<Transaction>>(data: tontineRetrait);
        } else {
          return ApiResponse<List<Transaction>>(
              error: true, errorMessage: "Une erreur s'est produite!");
        }
      }
      return ApiResponse<List<Transaction>>(
          error: true, errorMessage: "Une erreur s'est produite!");
    }).catchError((_) => ApiResponse<List<Transaction>>(
            error: true, errorMessage: "Une erreur s'est produite!"));
  }

  Future<ApiResponse<List<Transaction>>> getEpargneRetrait() {
    final user = json.decode(UserPreferences().client);
    return http
        .get(API + "client/accounts/transaction-liste/${user["id"]}",
            headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final tontineRetrait = <Transaction>[];
        if (jsonData["transactions"]["epargne"]["withdrawals"]
            .toString()
            .isNotEmpty) {
          for (var item in jsonData["transactions"]["epargne"]["withdrawals"]) {
            tontineRetrait.add(Transaction.fromJson(item));
          }
          return ApiResponse<List<Transaction>>(data: tontineRetrait);
        } else {
          return ApiResponse<List<Transaction>>(
              error: true, errorMessage: "Une erreur s'est produite!");
        }
      }
      return ApiResponse<List<Transaction>>(
          error: true, errorMessage: "Une erreur s'est produite!");
    }).catchError((_) => ApiResponse<List<Transaction>>(
            error: true, errorMessage: "Une erreur s'est produite!"));
  }

  Future<ApiResponse<List<Transaction>>> getEpargneDepot() {
    final user = json.decode(UserPreferences().client);
    return http
        .get(API + "client/accounts/transaction-liste/${user["id"]}",
            headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final tontineRetrait = <Transaction>[];
        if (jsonData["transactions"]["epargne"]["deposits"]
            .toString()
            .isNotEmpty) {
          for (var item in jsonData["transactions"]["epargne"]["deposits"]) {
            tontineRetrait.add(Transaction.fromJson(item));
          }
          return ApiResponse<List<Transaction>>(data: tontineRetrait);
        } else {
          return ApiResponse<List<Transaction>>(
              error: true, errorMessage: "Une erreur s'est produite!");
        }
      }
      return ApiResponse<List<Transaction>>(
          error: true, errorMessage: "Une erreur s'est produite!");
    }).catchError((_) => ApiResponse<List<Transaction>>(
            error: true, errorMessage: "Une erreur s'est produite!"));
  }

  /* ===== Tout ce qui concerne Les Transactions end ===== */

}
