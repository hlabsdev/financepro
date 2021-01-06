import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DemandeCredit extends StatefulWidget {
  @override
  _DemandeCreditState createState() => _DemandeCreditState();
}

class _DemandeCreditState extends State<DemandeCredit> {
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
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
        dragStartBehavior: DragStartBehavior.start,
      ),
    );
  }
}
