import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ussd/ussd.dart';
// import 'package:ussd_service/ussd_service.dart';

class MyTransactions extends StatefulWidget {
  @override
  _MyTransactionsState createState() => _MyTransactionsState();
}

@override
void initState() {
  // super.initState();
}

/* makeMyRequest(String code) async {
  int subscriptionId = 2; // sim card subscription ID
  //String code = "*444#"; // ussd code payload
  try {
    String ussdResponseMessage = await UssdService.makeRequest(
      subscriptionId,
      code,
      Duration(seconds: 10), // timeout (optional) - default is 10 seconds
    );
    print("succes! message: $ussdResponseMessage");
  } catch(e) {
    debugPrint("error! code: ${e.code} - message: ${e.message}");
  }
}
 */

class _MyTransactionsState extends State<MyTransactions> {
  String _selectedItem = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mes Transactions detaillées",
          style: GoogleFonts.arya(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
        ),
      ),
      body: Container(
        child: ListView.builder(
          /* separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          }, */
          itemBuilder: (BuildContext context, int index) {
            // print(opreationItem);
            return InkWell(
                onTap: () {
                  _onButtonPressed();
                },
                child: OperationTile());
          },
          itemCount: 10,
          padding: EdgeInsets.only(bottom: 20),
        ),
        // margin: EdgeInsets.only(bottom: 20),
        // padding: EdgeInsets.only(bottom: 20),
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

/* hors classe */

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
