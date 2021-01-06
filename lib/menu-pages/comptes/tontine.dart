import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tontine extends StatefulWidget {
  @override
  _TontineState createState() => _TontineState();
}

class _TontineState extends State<Tontine> {
  var tontine;

  @override
  void initState() {
    getTontine();
    super.initState();
  }

  Future<void> getTontine() async {
    SharedPreferences localStrorage = await SharedPreferences.getInstance();
    var tontJson = localStrorage.getString("Tontine");
    var tont = json.decode(tontJson);
    setState(() {
      tontine = tont;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: Text(
                  'Informations du compte',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                      color: Colors.grey[700],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Card(
            elevation: 10,
            margin: EdgeInsets.only(left: 8, right: 8),
            child: new Container(
              // padding: new EdgeInsets.all(32.0),
              child: new Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        // child: Text("N°de compte: ${tontine['accId']}"),
                        child: Text(
                          "Compte N°: T309",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                        child: Text(
                          "|",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, right: 10),
                        // child: Text("N°de compte: ${tontine['accId']}"),
                        child: Text(
                          "Crée le: 22/09/2020",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  new ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(5.0),
                          bottomRight: const Radius.circular(5.0),
                          topLeft: const Radius.circular(5.0),
                          topRight: const Radius.circular(5.0),
                        ),
                        image: DecorationImage(
                          // image: NetworkImage(
                          //     "https://1001freedownloads.s3.amazonaws.com/icon/thumb/100/Money.png"),
                          image: AssetImage("images/Money.png"),
                        ),
                      ),
                    ),
                    title: Text(
                      'Solde ',
                      style: GoogleFonts.cinzel(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      tontine != null
                          ? '${tontine["balance"]} FCFA'
                          : '200000 FCFA',
                      // '${tontine["balance"]}',
                      style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    // isThreeLine: true,
                  ),
                  new ListTile(
                    leading: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(5.0),
                          bottomRight: const Radius.circular(5.0),
                          topLeft: const Radius.circular(5.0),
                          topRight: const Radius.circular(5.0),
                        ),
                        image: DecorationImage(
                            image: AssetImage('images/recieved.png')),
                      ),
                    ),
                    title: Text(
                      'Derniere cotisation le ',
                      style: GoogleFonts.cinzel(
                          color: Colors.black,
                          letterSpacing: 0,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '17 Dec, 2020',
                      style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: Text(
                      '550 FCFA',
                      style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 70.0, top: 6),
                child: Text(
                  'Operations Recentes',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                      color: Colors.grey[700],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          //========= Liste of operations =========
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(5.0),
                        bottomRight: const Radius.circular(5.0),
                        topLeft: const Radius.circular(5.0),
                        topRight: const Radius.circular(5.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: 6.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            0, // Move to right 10  horizontally
                            4, // Move to bottom 10 Vertically
                          ),
                        )
                      ]),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(5.0),
                          bottomRight: const Radius.circular(5.0),
                          topLeft: const Radius.circular(5.0),
                          topRight: const Radius.circular(5.0),
                        ),
                        image: DecorationImage(
                            image: AssetImage('images/recieved.png')),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          'Cotisation du ',
                          style: GoogleFonts.cinzel(
                              color: Colors.black,
                              letterSpacing: 0,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      '17 Dec, 2020',
                      style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\550 FCFA',
                            style: GoogleFonts.cinzel(
                                color: Colors.black,
                                letterSpacing: 0,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.cancel_outlined,
                            size: 20,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                    isThreeLine: false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(5.0),
                        bottomRight: const Radius.circular(5.0),
                        topLeft: const Radius.circular(5.0),
                        topRight: const Radius.circular(5.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: 6.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            0, // Move to right 10  horizontally
                            4, // Move to bottom 10 Vertically
                          ),
                        )
                      ]),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(5.0),
                          bottomRight: const Radius.circular(5.0),
                          topLeft: const Radius.circular(5.0),
                          topRight: const Radius.circular(5.0),
                        ),
                        image: DecorationImage(
                            image: AssetImage('images/recieved.png')),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          'Cotisation du ',
                          style: GoogleFonts.cinzel(
                              color: Colors.black,
                              letterSpacing: 0,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      '10 Nov, 2020',
                      style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\550 FCFA',
                            style: GoogleFonts.cinzel(
                                color: Colors.black,
                                letterSpacing: 0,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.check_circle_outlined,
                            size: 20,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            autofocus: true,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 22, right: 22, top: 8, bottom: 8),
              child: Text('plus de details...',
                  style: GoogleFonts.lato(
                      letterSpacing: 3,
                      color: Colors.blue[900],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic)),
            ),
          ),
        ],
      ),
    );
  }
}
