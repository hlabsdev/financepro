import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Theme.of(context).primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: DefaultTabController(
        length: 3,
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
                      currentAccountPicture:
                          userData["profile_photo_url"] != null
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
                    "Parametres",
                  ),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    "Deconnexion",
                  ),
                  leading: const Icon(Icons.logout),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    "Apropos",
                  ),
                  leading: const Icon(Icons.question_answer),
                  onTap: () {
                    Navigator.pop(context);
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
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 8, bottom: 8),
                  sliver: SliverGrid.count(
                    // crossAxisSpacing: 2,
                    // mainAxisSpacing: 2,
                    crossAxisCount: 2,
                    children: <Widget>[
                      MenuCard(
                        title: Text(
                          "Mes Comptes",
                          style: GoogleFonts.cairo(
                              color: Colors.white70,
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
                              color: Colors.white70,
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
                              color: Colors.white70,
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
                          "Demandes Credits",
                          style: GoogleFonts.cairo(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        cardColor: Colors.deepPurple,
                        icon: Icon(
                          Icons.credit_card_rounded,
                          color: Colors.yellow[200],
                          size: 70,
                        ),
                        routePage: MyAccounts(),
                      ),
                      MenuCard(
                        title: Text(
                          "Mon Agent",
                          style: GoogleFonts.cairo(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        // cardColor: Colors.deepPurple,
                        cardColor: Colors.white10,
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
                        cardColor: Colors.black,
                        icon: Icon(
                          Icons.access_time,
                          color: Colors.red[200],
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
      ),
    );
  }
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
