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
          SizedBox(height: 10),
          Card(
            elevation: 12,
            margin: EdgeInsets.only(left: 8, right: 8),
            child: new Container(
              // padding: new EdgeInsets.all(32.0),
              child: new Column(
                children: <Widget>[
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
                      // tontine != null ? '${tontine["balance"]}' : '200000',
                      '${tontine["balance"]}',
                      style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    // isThreeLine: true,
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
                            image: AssetImage('images/recieved.png')),
                      ),
                    ),
                    title: Text(
                      'Cotisation du ',
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
