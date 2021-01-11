import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreerDemande extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Demande de credit",
          style: GoogleFonts.arya(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Compte",
            ),
          ),
          Container(
            height: 8,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Montant",
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Envoyer"),
          )
        ],
      ),
    );
  }
}
