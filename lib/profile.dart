import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
//   var userData;
//   SharedPreferences localStorage;

//   @override
//   void initState() {
//     _getUserInfo();
//     super.initState();
//   }

//   Future<void> _getUserInfo() async {
//     var userJson = localStorage.getString("user");
//     var user = json.decode(userJson);

//     setState(() {
//       userData = user;
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(5.0),
                        bottomRight: const Radius.circular(5.0),
                        topLeft: const Radius.circular(5.0),
                        topRight: const Radius.circular(5.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            0, // Move to right 10  horizontally
                            4, // Move to bottom 10 Vertically
                          ),
                        )
                      ]),
                  height: 280,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Icon(Icons.arrow_back_ios_rounded,
                                  color: Colors.grey[600], size: 23),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'images/6.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 70,
                      ),
                      Text(
                        'Hermann HLabs',
                        style: GoogleFonts.cinzel(
                            color: Colors.grey[900],
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 27,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              /*var route = MaterialPageRoute(
                                    builder: (BuildContext context) => Recent(),
                                  );
    
                                  Navigator.of(context).push(route);*/
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[800],
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    //background color of box
                                    BoxShadow(
                                      color: Colors.blue[200],
                                      blurRadius: 3.0, // soften the shadow
                                      spreadRadius: 0.0, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        2.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 22, right: 22, top: 12, bottom: 12),
                                  child: Text(
                                    'Cotisations',
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        letterSpacing: 1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ))),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Text(
                    'Operations Recentes',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cinzel(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            //========= Liste of operations =========
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 25),
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
                        blurRadius: 10.0, // soften the shadow
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
                          '\200F CFA',
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
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 25),
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
                        blurRadius: 10.0, // soften the shadow
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
                          '\200F CFA',
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
                  isThreeLine: false,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 25),
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
                        blurRadius: 10.0, // soften the shadow
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
                    '12 Oct, 2020',
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
                          '\200F CFA',
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
                  isThreeLine: false,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
