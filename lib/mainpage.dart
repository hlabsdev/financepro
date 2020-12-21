import 'package:finance/mes-transactions.dart';
import 'package:finance/mon-agent.dart';
import 'package:finance/my-account.dart';
import 'package:finance/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            bottom: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black54,
              tabs: [
                Tab(
                  icon: Icon(Icons.account_balance),
                  text: 'MyAcount',
                ),
                Tab(
                  icon: Icon(Icons.account_box),
                  text: 'MyAgent',
                ),
                Tab(
                  icon: Icon(Icons.track_changes),
                  text: 'Transactions',
                ),
              ],
            ),
            title: Text(
              'My_ACCOUNT',
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
          body: TabBarView(
            children: [
              MyAccount(),
              Agent(),
              Transactions(),
            ],
          ),
        ),
      ),
    );
  }
}
