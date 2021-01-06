import 'package:flutter/material.dart';
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

Future<void> launchUssd(String ussdCode) async {
  Ussd.runUssd(ussdCode);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Run moov ussd code Test '),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              // makeMyRequest("*444#");
              launchUssd("*101#");
            },
            child: Text("Consulter mon solde"),
          ),
          RaisedButton(
            onPressed: () {
              // makeMyRequest("*145*7*1*1999#");
              launchUssd("*155*6*1*1999#");
            },
            child: Text("Consulter mon solde Flooz"),
          ),
        ],
      )),
    );
  }
}
