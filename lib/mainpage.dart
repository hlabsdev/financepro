import 'dart:convert';
import 'dart:io';

import 'package:finance/api/api.dart';
import 'package:finance/login.dart';
import 'package:finance/menu-pages/credits/mes-credit.dart';
import 'package:finance/menu-pages/mes-transactions.dart';
import 'package:finance/menu-pages/mon-agent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:finance/menu-pages/comptes/my-accounts.dart';
import 'package:finance/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var userData;

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString("client");
    var user = json.decode(userJson);

    setState(() {
      userData = user;
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text("Vous etes sur?"),
            content: new Text("Voulez-vous vraiment Quitter l'application"),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('NON'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('OUI'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: _onBackPressed,
      onWillPop: () => exit(0),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'MON COMPTE',
            style: GoogleFonts.arya(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle
                  // color: Colors.green,
                  ),
              onPressed: () {
                var route = MaterialPageRoute(
                  builder: (BuildContext context) => Profile(),
                );

                Navigator.of(context).push(route);
              },
            ),
          ],
        ),
        drawer: Drawer(
          elevation: 0,
          // semanticLabel: "Options",
          child: ListView(
            padding: EdgeInsets.only(top: 10),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      userData != null
                          ? '${userData["fname"]}' +
                              " " +
                              '${userData["lname"]}'
                          : "",
                    ),
                    onDetailsPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                    accountEmail: Text(
                      '${userData["email"]}',
                    ),
                    arrowColor: Colors.green[50],
                    currentAccountPicture: userData["profile_photo_url"] != null
                        ? CircleAvatar(
                            child: Image.network(
                              '${userData["profile_photo_url"]}',
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                          )
                        : CircleAvatar(
                            child: FlutterLogo(size: 50.0),
                          ),
                  ),
                ],
              ),
              ListTile(
                title: Text(
                  "Cotiser",
                ),
                leading: const Icon(Icons.money_rounded),
                onTap: () {
                  CallAPi().launchUssd("*155*6*1#");
                },
              ),
              ListTile(
                title: Text(
                  "Apropos",
                ),
                leading: const Icon(Icons.question_answer),
                onTap: () {
                  _showDialog();
                },
              ),
              Divider(
                height: 2,
              ),
              ListTile(
                title: Text(
                  "Parametres",
                ),
                leading: const Icon(Icons.settings),
                onTap: () {
                  _showDialog();
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  "Deconnexion",
                ),
                leading: const Icon(Icons.logout),
                onTap: () {
                  CallAPi().logout();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ],
          ),
        ),
        body: SizedBox(
          // height: MediaQuery.of(context).size.height - 90,
          child: CustomScrollView(
            primary: true,
            slivers: <Widget>[
              SliverPadding(
                padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
                sliver: SliverGrid.count(
                  // crossAxisSpacing: 2,
                  // mainAxisSpacing: 2,
                  crossAxisCount: 2,
                  children: <Widget>[
                    MenuCard(
                      title: Text(
                        "Mes Comptes",
                        style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      cardColor: Colors.deepPurple,
                      icon: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.yellow[200],
                        size: 70,
                      ),
                      routePage: MyAccounts(),
                    ),
                    MenuCard(
                      title: Text(
                        "Transfert",
                        style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      cardColor: Colors.deepPurple,
                      icon: Icon(
                        Icons.send_to_mobile,
                        color: Colors.yellow[200],
                        size: 70,
                      ),
                      routePage: MyAccounts(),
                    ),
                    MenuCard(
                      title: Text(
                        "Mes Transactions",
                        style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      cardColor: Colors.deepPurple,
                      icon: Icon(
                        Icons.transfer_within_a_station,
                        color: Colors.yellow[200],
                        size: 70,
                      ),
                      routePage: MyTransactions(),
                    ),
                    MenuCard(
                      title: Text(
                        "Mes Credits",
                        style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      cardColor: Colors.deepPurple,
                      icon: Icon(
                        Icons.credit_card_rounded,
                        color: Colors.yellow[200],
                        size: 70,
                      ),
                      routePage: MesCredit(),
                    ),
                    MenuCard(
                      title: Text(
                        "Mon Agent",
                        style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      // cardColor: Colors.deepPurple,
                      cardColor: Colors.deepPurple,
                      icon: Icon(
                        Icons.support_agent_rounded,
                        color: Colors.yellow[200],
                        size: 70,
                      ),
                      routePage: MyAgent(),
                    ),
                    MenuCard(
                      title: Text(
                        "Rendez-Vous",
                        style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      cardColor: Colors.deepPurple,
                      icon: Icon(
                        Icons.access_time,
                        color: Colors.yellow[200],
                        size: 70,
                      ),
                      routePage: MyAccounts(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* Show not Ready message deb */

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Effectuez votre cotisation"),
          content: SizedBox(
            height: 130,
            child: Text("En cours de developpement (^-^)"),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  /* Show not Ready message end */

}

class MenuCard extends StatelessWidget {
  final Text title;
  final Icon icon;
  final Color cardColor;
  final Widget routePage;

  const MenuCard({
    Key key,
    this.title,
    this.icon,
    this.cardColor,
    this.routePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            child: InkWell(
              child: icon,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => routePage),
                );
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          title,
        ],
      ),
    );
  }
}
