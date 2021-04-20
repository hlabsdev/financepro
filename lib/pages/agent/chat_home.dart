import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:finance/api/api.dart';
import 'package:finance/models/account.dart';
import 'package:finance/models/message.dart';
import 'package:finance/services/app_services.dart';
import 'package:finance/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  TextEditingController _messageController = new TextEditingController();

  MyAppServices get service => GetIt.I<MyAppServices>();

  // final Completer<WebViewController> _controller = Completer<WebViewController>();

  // static const kAndroidUserAgent = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

  // String selectedUrl = 'https://flutter.io';

// ignore: prefer_collection_literals
//   final Set<JavascriptChannel> jsChannels = [
//     JavascriptChannel(
//         name: 'Print',
//         onMessageReceived: (JavascriptMessage message) {
//           print(message.message);
//         }),
//   ].toSet();

  var userData;
  ApiResponse<Account> _apiResponse;
  bool _isLoading;
  // Account compte;

  @override
  void initState() {
    _fetchData(false);
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView(); else WebView.platform = SurfaceAndroidWebView();
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

  List<Message> messages = [
    Message(content: "Bonjour", type: "sender"),
    Message(content: "Quand passerez-vous prochainement?", type: "sender"),
    Message(
        content: "Salut, Je pense passer à 14h30. Serez-vous là?",
        type: "receiver"),
    Message(
        content: "Ah bon!? Je m'arrangerai pour etre là alors.",
        type: "sender"),
    Message(
        content: "Super alors. On se dit a cet apres-midi.", type: "receiver"),
    Message(content: "D'accord. Je vous attend donc", type: "sender"),
    Message(
        content:
            "Ah j'oubliais, il faut aussi preparer la cotisation du 28 que vous avez rater.",
        type: "receiver"),
    Message(
        content: "Ah oui merci beaucoup. J'avais completement oublié!!",
        type: "sender"),
  ];

  @override
  Widget build(BuildContext context){
    /*return Scaffold(
      appBar: AppBar(
        title: Text('InAppWebView Example'),
      ),
      body: Expanded(
        child: WebView(
          initialUrl: 'https://flutter.dev/',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );*/

    return WebviewScaffold(
      url: 'https://financepro.proxymall.store/mfp-chat-message',
      // javascriptChannels: jsChannels,
      withJavascript: true,
      allowFileURLs: true,
      mediaPlaybackRequiresUserGesture: false,
      appBar: AppBar(
        title: const Text('Mon Agent'),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.redAccent,
        child: const Center(
          child: Text('Chargement.....'),
        ),
      ),
     /* bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                flutterWebViewPlugin.goBack();
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                flutterWebViewPlugin.goForward();
              },
            ),
            IconButton(
              icon: const Icon(Icons.autorenew),
              onPressed: () {
                flutterWebViewPlugin.reload();
              },
            ),
          ],
        ),
      ),
    */);

   /* return Scaffold(
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
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  "Attention ceci ne se passe pas en temp réel!!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
            Container(
              height: 460,
              child: ListView.builder(
                itemCount: messages.length,
                // shrinkWrap: true,
                // primary: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                // physics: NeverScrollableScrollPhysics(),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messages[index].type == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].type == "receiver"
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          messages[index].content,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // padding: EdgeInsets.only(left: 10, bottom: 10),
                // height: 60,
                // width: double.infinity,
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
                        controller: _messageController,
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
                      onPressed: () {
                        messages.add(
                          Message(
                              content: _messageController.text,
                              type: this.messages.last.type == "sender"
                                  ? "receiver"
                                  : "sender"),
                        );

                        setState(() {
                          this.messages;
                        });
                        _messageController.text = "";

                        // setState(() {
                        //   messages.add(Message(
                        //       content: _messageController.text,
                        //       type: "sender"));
                        // });
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
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
 */ }
}
