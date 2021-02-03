import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();
  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /* Startup number deb */
  get startupNumber {
    return _prefs.getString("startupNumber") ?? "";
  }

  set startupNumber(String value) {
    _prefs.setString("startupNumber", value);
  }
  /* Startup number end */

  /* Authentication deb */
  get client {
    return _prefs.getString("client") ?? "";
  }

  set client(String value) {
    _prefs.setString("client", value);
  }

  get token {
    return _prefs.getString("token") ?? "";
  }

  set token(String value) {
    _prefs.setString("token", value);
  }

  Future setToken(String value) {
    return _prefs.setString("jwtoken", value);
  }
  /* Authentication end */

  /* Compte Client deb */

  get comptes {
    return _prefs.getString("comptes") ?? "";
  }

  set comptes(String value) {
    _prefs.setString("comptes", value);
  }

  get epargne {
    return _prefs.getString("epargne") ?? "";
  }

  set epargne(String value) {
    _prefs.setString("epargne", value);
  }

  get tontine {
    return _prefs.getString("tontine") ?? "";
  }

  set tontine(String value) {
    _prefs.setString("tontine", value);
  }

  get carnet {
    return _prefs.getString("moisList") ?? "";
  }

  set carnet(String value) {
    _prefs.setString("moisList", value);
  }

  get agentClient {
    return _prefs.getString("agentClient") ?? "";
  }

  set agentClient(String value) {
    _prefs.setString("agentClient", value);
  }
  /* Compte Client end */

  /* Credit deb */
  get creditEpargne {
    return _prefs.getString("creditEpargne") ?? "";
  }

  set creditEpargne(String value) {
    _prefs.setString("creditEpargne", value);
  }

  get creditTontine {
    return _prefs.getString("creditTontine") ?? "";
  }

  set creditTontine(String value) {
    _prefs.setString("creditTontine", value);
  }
  /* Credit end */

  /* Ma microfinance deb */

  get maMicrofinance {
    return _prefs.getString("maMicrofinance") ?? "";
  }

  set maMicrofinance(String value) {
    _prefs.setString("maMicrofinance", value);
  }

  /* Ma microfinance end */

  /* Transactions deb */
  get depotEpargne {
    return _prefs.getString("depotEpargne") ?? "";
  }

  set depotEpargne(String value) {
    _prefs.setString("depotEpargne", value);
  }

  get retraitEpargne {
    return _prefs.getString("retraitEpargne") ?? "";
  }

  set retraitEpargne(String value) {
    _prefs.setString("retraitEpargne", value);
  }

  get depotTontine {
    return _prefs.getString("depotTontine") ?? "";
  }

  set depotTontine(String value) {
    _prefs.setString("depotTontine", value);
  }

  get retraitTontine {
    return _prefs.getString("retraitTontine") ?? "";
  }

  set retraitTontine(String value) {
    _prefs.setString("retraitTontine", value);
  }

  /* Transactions end */

}
