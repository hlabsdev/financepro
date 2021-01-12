import 'dart:convert';

import 'package:finance/api/api.dart';
import 'package:finance/models/index.dart';
import 'package:finance/services/app_services.dart';
import 'package:finance/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class Carnet extends StatefulWidget {
  @override
  _CarnetState createState() => _CarnetState();
}

class _CarnetState extends State<Carnet> {
  MyAppServices get service => GetIt.I<MyAppServices>();

  var userData;
  ApiResponse<List<Mois>> _apiResponse;
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
      var newApiResp = await service.getMoisList();
      setState(() {
        _apiResponse = newApiResp;
      });
      UserPreferences().carnet = json.encode(newApiResp.data);
    } else {
      if (UserPreferences().carnet.toString().isEmpty) {
        _apiResponse = await service.getMoisList();
        UserPreferences().carnet = json.encode(_apiResponse.data);
      } else {
        var listMois = <Mois>[];
        for (var index in json.decode(UserPreferences().carnet)) {
          // listMois.add(Mois.fromJson(json.decode(index)));
          listMois.add(Mois.fromJson(index));
        }
        _apiResponse = ApiResponse<List<Mois>>(
          data: listMois,
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

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
          "Mon Carnet",
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
            child: Text(_apiResponse.errorMessage),
          );
        }
        return SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(top: 8),
              child: ListView.separated(
                // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                shrinkWrap: true,
                primary: false,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: Theme.of(context).primaryColor,
                ),
                itemCount: _apiResponse.data.length,
                itemBuilder: ((BuildContext context, int index) {
                  return InkWell(
                    onTap: () => {
                      Navigator.of(context)
                          .push(PageRouteBuilder(pageBuilder: (_, __, ___) {
                        return MoisDetailGrid();
                      }))
                    },
                    child: ListTile(
                      autofocus: true,
                      focusNode: FocusNode(canRequestFocus: true),
                      title: Text(
                        _apiResponse.data != null
                            ? 'Mois ${_apiResponse.data[index].month}'
                            : "Mois ...",
                      ),
                      leading: Icon(
                        Icons.date_range_rounded,
                        color: Colors.blueAccent[500],
                      ),
                      subtitle: Text(
                        _apiResponse.data != null
                            ? 'Position: Jour ${_apiResponse.data[index].position}'
                            : "Position ...",
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _apiResponse.data[index].is_taken
                                  ? "Retiré"
                                  : "Non retitié",
                              style: GoogleFonts.lato(
                                color: Colors.blue[600],
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _apiResponse.data[index].is_taken
                                ? Icon(
                                    Icons.check_circle_outline_rounded,
                                    size: 20,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: Colors.red,
                                  )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )),
        );
      }),
    );
  }
}

class MoisDetailGrid extends StatelessWidget {
  const MoisDetailGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Deatil du mois",
          style: GoogleFonts.arya(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        // centerTitle: true,
      ),
      body: Center(
        child: GridView.builder(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.all(5),
          itemCount: 31,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          itemBuilder: ((BuildContext context, int index) {
            return new Card(
              color: Colors.blueAccent,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: new GridTile(
                  footer: Center(child: new Text("Jour ${index + 1}")),
                  child: new Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
