import 'dart:convert';

import 'package:finance/pages/rendez-vous/rendez_vous.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:finance/api/api.dart';
import 'package:finance/pages/agent/mon_agent.dart';
import 'package:finance/pages/comptes/my_accounts.dart';
import 'package:finance/pages/credits/mes_credit.dart';
import 'package:finance/pages/login.dart';
import 'package:finance/pages/profile.dart';
import 'package:finance/pages/transactions/mes_transactions.dart';
import 'package:finance/pages/transferts/mes_transferts.dart';

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

/* 
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
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
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
                        ? '${userData["fname"]}' + " " + '${userData["lname"]}'
                        : "",
                  ),
                  onDetailsPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                  accountEmail: Text(
                    userData != null ? '${userData["email"]}' : "",
                  ),
                  arrowColor: Colors.green[50],
                  currentAccountPicture: userData != null
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
                _showDialog("Bientot Diosponible", "En cours de developpement.", false);
              },
            ),
            Divider(
              height: 2,
            ),
            /*
            ListTile(
              title: Text(
                "Parametres",
              ),
              leading: const Icon(Icons.settings),
              onTap: () {
                _showDialog("Bientot Diosponible");
                // Navigator.pop(context);
              },
            ),*/
            ListTile(
              title: Text(
                "Deconnexion",
              ),
              leading: const Icon(Icons.logout),
              onTap: () {
                _showDialog("Etes-vous sur?", "Voulez-vous vraiment vous deconnecter!?", true);
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
                children: [
                  MenuIconCard(
                    title: "Mes Comptes",
                    image: Image(
                      image: AssetImage("images/menu/mes_comptes.png"),
                      height: 50,
                      width: 50,
                    ),
                    routePage: MyAccounts(),
                  ),
                  MenuIconCard(
                    title: "Mes Credits",
                    image: Image(
                      image: AssetImage("images/menu/credits.png"),
                      height: 50,
                      width: 50,
                    ),
                    routePage: MesCredit(),
                  ),
                  MenuIconCard(
                    title: "Transfert",
                    image: Image(
                      image: AssetImage("images/menu/transferts.png"),
                      height: 50,
                      width: 50,
                    ),
                    routePage: MesTansfert(),
                  ),
                  MenuIconCard(
                    title: "Mes Transactions",
                    image: Image(
                      image: AssetImage("images/menu/transactions.png"),
                      height: 50,
                      width: 50,
                    ),
                    routePage: MyTransactions(),
                  ),
                  MenuIconCard(
                    title: "Mon Agent",
                    image: Image(
                      image: AssetImage("images/menu/agents.png"),
                      height: 50,
                      width: 50,
                    ),
                    routePage: MyAgent(),
                  ),
                  MenuIconCard(
                    title: "Rendez-vous",
                    image: Image(
                      image: AssetImage("images/menu/rdv.png"),
                      height: 40,
                      width: 50,
                    ),
                    routePage: RendezVous(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* Show not Ready message deb */
  void _showDialog(String titre, String text, bool isDecon) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(titre),
          content: Text(text),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Fermer"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            isDecon ? FlatButton(
              child: Text("Valider"),
              onPressed: () {
                CallAPi().logout();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ): null,
          ],
        );
      },
    );
  }
  /* Show not Ready message end */

}

class MenuIconCard extends StatelessWidget {
  final String title;
  final Image image;
  final Widget routePage;

  const MenuIconCard({
    Key key,
    this.title,
    this.image,
    this.routePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => routePage),
        );
      },
      child: Card(
        // color: Colors.white38,
        color: Colors.white,
        elevation: 6,
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, right: 6, left: 6, bottom: 8),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: image,
                ),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: Text(
                    title,
                    style: GoogleFonts.cairo(
                        color: Colors.blue[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
