import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:finance/api/api.dart';
import 'package:finance/models/type_acc.dart';

class Tontine extends StatefulWidget {
  final Type_acc tontine;

  const Tontine({
    Key key,
    this.tontine,
  }) : super(key: key);

  @override
  _TontineState createState() => _TontineState();
}

class _TontineState extends State<Tontine> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _refreshPage() async {
    // _fetchAccount();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () => _refreshPage(),
      child: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Informations du compte',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                      color: Colors.grey[700],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Card(
              elevation: 10,
              margin: EdgeInsets.only(left: 8, right: 8),
              child: Container(
                // padding: EdgeInsets.all(32.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          // child: Text("N°de compte: ${tontine['accId']}"),
                          child: Text(
                            widget.tontine != null
                                ? 'Compte Tontine ${widget.tontine.acc_num}'
                                : "Compte Tontine ...",
                            style: GoogleFonts.cinzel(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
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
                        widget.tontine != null
                            ? '${widget.tontine.balance} FCFA'
                            : '... FCFA',
                        style: GoogleFonts.lato(
                            color: Colors.grey[600],
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          _showDialog();
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
                                  spreadRadius: 2.0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    2.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 10, bottom: 10),
                              child: Text(
                                'Cotiser',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            )),
                      ),
                      /*  */
                    ),
                    ListTile(
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
                        'Derniere cotisation ',
                        style: GoogleFonts.cinzel(
                            color: Colors.black,
                            letterSpacing: 0,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Le 17 Dec, 2020',
                        style: GoogleFonts.lato(
                            color: Colors.grey[600],
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                      trailing: Text(
                        '550 FCFA',
                        style: GoogleFonts.lato(
                          color: Colors.blue[600],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    ListTile(
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
                              image: AssetImage('images/retrait.png')),
                        ),
                      ),
                      title: Text(
                        'Dernier retrait ',
                        style: GoogleFonts.cinzel(
                            color: Colors.black,
                            letterSpacing: 0,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Le 25 Dec, 2020',
                        style: GoogleFonts.lato(
                            color: Colors.grey[600],
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                      trailing: Text(
                        '25000 FCFA',
                        style: GoogleFonts.lato(
                          color: Colors.blue[600],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
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
                        ('10 Nov, 2020'),
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
                padding: const EdgeInsets.only(
                    left: 22, right: 22, top: 8, bottom: 8),
                child: Text('plus de details...',
                    style: GoogleFonts.lato(
                        letterSpacing: 3,
                        color: Colors.blue[900],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
              ),
            ),

            SizedBox(
              height: 30,
            ),
          ],
        ),
      )),
    );
  }

  void _showDialog() {
    TextEditingController sommeController = TextEditingController();
    setState(() {
      sommeController.text = widget.tontine.mise;
    });
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CupertinoAlertDialog(
          title: Text("Effectuez votre cotisation"),
          content: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                // padding: EdgeInsets.all(6),
                child: CupertinoTextField(
                  controller: sommeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  placeholder: "Montant",
                  // decoration: InputDecoration(
                  //     // border: OutlineInputBorder(),
                  //     border: UnderlineInputBorder(),
                  //     labelText: "Montant",

                  //     // errorText: _isLoading ? _validateEmail() : null,
                  //     errorStyle: TextStyle(
                  //       textBaseline: TextBaseline.ideographic,
                  //     )),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                  child: RaisedButton(
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Text('Valider'),
                onPressed: () {
                  CallAPi().launchUssd("*101#");
                },
              )),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Fermer"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    setState(() {
      sommeController.text = "";
    });
  }
}
