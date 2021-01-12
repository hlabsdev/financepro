import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MFPAppBar {
  final String titre;
  var refreshPage;

  MFPAppBar(this.titre, this.refreshPage);

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: false,
      actions: [
        IconButton(
          tooltip: "Rafraichir la page",
          icon: Icon(Icons.refresh_rounded),
          onPressed: () {
            refreshPage();
          },
        ),
      ],
      title: Text(
        titre,
        style: GoogleFonts.arya(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal),
      ),
    );
  }
}
