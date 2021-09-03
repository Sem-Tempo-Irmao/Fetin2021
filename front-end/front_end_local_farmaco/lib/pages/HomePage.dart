import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'FavoritesPage.dart';
import 'ResultsPage.dart';
import 'SettingsPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GoogleMapController _controller;
  TextEditingController _pesq = TextEditingController();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-22.256897, -45.7011926),
    zoom: 16,
  );
  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 16),
        ),
      );
    });
  }

  Location _location = Location();
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      // menu lateral -> drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: 40),
          children: [
            const DrawerHeader(
              child: Text(
                'Opções',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              title: const Text(
                'Favoritos',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              leading: Icon(Icons.star, color: Colors.red),
              // Abre os favoritos
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Configurações',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              leading: Icon(Icons.settings, color: Colors.red),
              // Abre as Configurações
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),

      body: ListView(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _pesq,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Pesquisa'),
                  onSubmitted: (String value) {
                    if (value.isNotEmpty)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsPage(search: value),
                        ),
                      );
                    else
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("Erro"),
                              content:
                                  new Text("Digite o fármaco a ser pesquisado"),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    minimumSize: Size(88, 44),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2.0)),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          });
                  },
                ),
                Container(
                  height: 20,
                ),
                Text(
                  'Digite o que deseja procurar no espaço acima.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    liteModeEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
