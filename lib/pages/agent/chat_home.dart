import 'dart:convert';

import 'package:finance/api/api.dart';
import 'package:finance/models/account.dart';
import 'package:finance/models/message.dart';
import 'package:finance/services/app_services.dart';
import 'package:finance/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  MyAppServices get service => GetIt.I<MyAppServices>();

  var userData;
  ApiResponse<Account> _apiResponse;
  bool _isLoading;
  // Account compte;

  @override
  void initState() {
    _fetchData(false);
    super.initState();
  }

  _fetchData(bool getNew) async {
    setState(() {
      _isLoading = true;
    });
    if (getNew) {
      var newApiResp = await service.getAccount();
      setState(() {
        _apiResponse = newApiResp;
      });
      UserPreferences().comptes = json.encode(newApiResp.data);
    } else {
      if (UserPreferences().comptes.toString().isEmpty) {
        _apiResponse = await service.getAccount();
        UserPreferences().comptes = json.encode(_apiResponse.data);
      } else {
        _apiResponse = ApiResponse<Account>(
          data: Account.fromJson(json.decode(UserPreferences().comptes)),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Bonjour", messageType: "sender"),
    ChatMessage(
        messageContent: "Quand passerez-vous prochainement?",
        messageType: "sender"),
    ChatMessage(
        messageContent: "Salut, Je pense passer à 14h30. Serez-vous là?",
        messageType: "receiver"),
    ChatMessage(
        messageContent: "Abn!? Je m'arragerai ppour etre là alors.",
        messageType: "sender"),
    ChatMessage(
        messageContent: "Super alors. On se dit a cet apres-midi.",
        messageType: "receiver"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: "Rafraichir la page",
            icon: Icon(Icons.refresh_rounded),
            onPressed: () {
              _fetchData(true);
            },
          ),
        ],
        title: Text(
          "Mon Agent",
          style: GoogleFonts.arya(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
        ),
      ),
      body: Builder(builder: (_) {
        if (_isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (_apiResponse.error) {
          return Center(
            child: Text(
              _apiResponse.errorMessage,
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          );
        }
        // ignore: unrelated_type_equality_checks
        if (_apiResponse.data == []) {
          return Center(
            child: Text(
              "Aucune donnée pour le moment",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          );
        }
        return Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].messageType == "receiver"
                            ? Colors.grey.shade200
                            : Colors.blue[200]),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        messages[index].messageContent,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Ecrivez votre message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
