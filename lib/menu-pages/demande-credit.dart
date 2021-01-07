import 'package:flutter/cupertino.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 10,
              child: Container(
                child: ExpansionTile(
                  title: Text("Les Credits en cours"),
                  subtitle: Text(
                    "(Appuyez pour developpez)",
                    style: TextStyle(fontSize: 12),
                  ),
                  children: [
                    SizedBox(
                      height: 350,
                      child: Container(
                          child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              height: 40,
                              width: 70,
                              padding: EdgeInsets.all(8),
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
                                    style: GoogleFonts.lato(
                                      color: Colors.blue[600],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
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
                          );
                        },
                      )),
                    )
                  ],
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  expandedAlignment: Alignment.bottomCenter,
                  // leading: ,
                  childrenPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: Container(
                child: ExpansionTile(
                  title: Text("Les Credits deja remboursés"),
                  subtitle: Text(
                    "(Appuyez pour developpez)",
                    style: TextStyle(fontSize: 12),
                  ),
                  children: [
                    SizedBox(
                      height: 350,
                      child: Container(
                          child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              height: 40,
                              width: 70,
                              padding: EdgeInsets.all(8),
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
                                    style: GoogleFonts.lato(
                                      color: Colors.blue[600],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
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
                          );
                        },
                      )),
                    )
                  ],
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  expandedAlignment: Alignment.bottomCenter,
                  // leading: ,
                  childrenPadding: EdgeInsets.all(20),
                ),
              ),
            ),
          ],
        ),
        dragStartBehavior: DragStartBehavior.start,
      ),
    );
  }

  /* builPopup deb */
  Widget _buildPopupDialog(BuildContext context) {
    return new CupertinoAlertDialog(
      title: const Text('Demande de credit'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
    /* return new AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    ); */
  }
  /* builPopup end */
}
