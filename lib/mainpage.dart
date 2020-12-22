import 'package:finance/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/cupertino.dart';

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
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
      //darkTheme: ThemeData(
      //brightness: Brightness.dark,
      //primarySwatch: Colors.black,
      //visualDensity: VisualDensity.adaptivePlatformDensity,
      //),
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
                        "Username",
                      ),
                      accountEmail: Text(
                        "Email",
                      ),
                      arrowColor: Colors.green[50],
                      currentAccountPicture: const CircleAvatar(
                        child: FlutterLogo(size: 50.0),
                      ),
                      otherAccountsPictures: [
                        CircleAvatar(
                          child: InkWell(
                            onTap: () {
                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Profile(),
                              );

                              Navigator.of(context).push(route);
                            },
                            child: Icon(Icons.person),
                          ),
                        )
                      ],
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
          body: CustomScrollView(
            primary: true,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text("Mes Comptes"),
                      color: Colors.green[100],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Transfert'),
                      color: Colors.green[200],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Mes Transactions'),
                      color: Colors.green[300],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      // decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadiusGeometry(context)),
                      child: const Text('Demandes Credits'),
                      color: Colors.green[400],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Mon Agent'),
                      color: Colors.green[500],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('A Propos'),
                      color: Colors.green[600],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Parametre'),
                      color: Colors.green[400],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Deconnexion'),
                      color: Colors.green[500],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Revolution, they...'),
                      color: Colors.green[600],
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
}
