import 'package:finance/api/api.dart';
import 'package:finance/models/index.dart';
import 'package:finance/services/app_services.dart';
import 'package:finance/utils/refreshable_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class Carnet extends StatefulWidget {
  @override
  _CarnetState createState() => _CarnetState();
}

class _CarnetState extends State<Carnet> {
  MyAppServices get service => GetIt.I<MyAppServices>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var userData;
  ApiResponse<List<Mois>> _apiResponse;
  bool _isLoading;
  // Account compte;

  @override
  void initState() {
    _fetchAccount();
    super.initState();
  }

  _fetchAccount() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getMoisList();

    setState(() {
      _isLoading = false;
    });
  }

  Future<Null> _refreshPage() async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mon Carnet",
          style: GoogleFonts.arya(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        // centerTitle: true,
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
        return RefreshableView(
          refreshIndicatorKey: _refreshIndicatorKey,
          refreshPage: _refreshPage(),
          child: SingleChildScrollView(
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
                        leading: Icon(Icons.date_range_rounded),
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
          ),
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
              color: Colors.black12,
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
