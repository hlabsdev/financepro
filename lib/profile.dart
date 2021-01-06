import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userData;
  // SharedPreferences localStorage = await SharedPreferences.getInstance();

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  Future<void> _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString("client");
    var user = json.decode(userJson);

    setState(() {
      userData = user;
    });
  }

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
                        userData != null
                            ? 'Nom: ${userData["fname"]} ${userData["lname"]}'
                            : 'Nom: ...',
                        style: GoogleFonts.cinzel(
                            color: Colors.white60,
                            fontSize: 18,
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
                                    'Modifier le profil',
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
            SizedBox(height: 8),
            Card(
              elevation: 5,
              // margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8, top: 5, bottom: 5),
                child: Column(
                  children: [
                    Text(
                      userData != null
                          ? 'Email: ${userData["email"]}'
                          : 'Email: ...',
                      style: GoogleFonts.cinzel(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      userData != null
                          ? 'Contact: ${userData["phone"]}'
                          : 'Contact: ...',
                      style: GoogleFonts.cinzel(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
