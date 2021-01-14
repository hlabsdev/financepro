import 'package:finance/models/transaction.dart';
import 'package:finance/models/type_acc.dart';
import 'package:finance/pages/transactions/mes_transactions.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class Epargne extends StatefulWidget {
  final Type_acc epargne;

  const Epargne({
    Key key,
    this.epargne,
  }) : super(key: key);

  @override
  _EpargneState createState() => _EpargneState();
}

class _EpargneState extends State<Epargne> {
  String _selectedItem = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => MyTransactions()));
        },
        child: Icon(Icons.transfer_within_a_station),
        tooltip: "Consultez vos Transactions",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
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
                          child: Text(
                            widget.epargne != null
                                ? 'Compte Epargne ${widget.epargne.acc_num}'
                                : "Compte Epargne ...",
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
                        'Solde',
                        style: GoogleFonts.cinzel(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        widget.epargne != null
                            ? '${widget.epargne.balance} FCFA'
                            : '... FCFA',
                        style: GoogleFonts.lato(
                            color: Colors.grey[600],
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
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
                              image: AssetImage('images/depot.png')),
                        ),
                      ),
                      title: Text(
                        'Dernier depot',
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
                        '5000 FCFA',
                        style: GoogleFonts.lato(
                            color: Colors.blue[600],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
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
                        'Dernier retrait',
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
                        '14500 FCFA',
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
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

/* Appeler le bottom sheet deb */
  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 180,
            child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  Column _buildBottomNavigationMenu() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('Flutter'),
          onTap: () => _selectItem('Flutter'),
        ),
        ListTile(
          leading: Icon(Icons.accessibility_new),
          title: Text('Android'),
          onTap: () => _selectItem('Android'),
        ),
        ListTile(
          leading: Icon(Icons.assessment),
          title: Text('Kotlin'),
          onTap: () => _selectItem('Kotlin'),
        ),
      ],
    );
  }

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      _selectedItem = name;
    });
  }
/* Appeler le bottom sheet end */
}

class OperationTile extends StatelessWidget {
  const OperationTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              image: DecorationImage(image: AssetImage('images/recieved.png')),
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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
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
    );
  }
}
