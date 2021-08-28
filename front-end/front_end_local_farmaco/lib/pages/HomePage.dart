import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


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
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _pesq = TextEditingController();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-22.256897, -45.7011926),
    zoom: 14.4746,
  );
  


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
              child: Text('Opções',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13+13,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              title: const Text('Favoritos',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              leading: Icon(Icons.star, color: Colors.red),
              onTap: () {
                // Update the state of the app.
                // TODO: Abre os favoritos
              },
            ),
            ListTile(
              title: const Text('Configurações',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              leading: Icon(Icons.settings, color: Colors.red),
              onTap: () {
                // Update the state of the app.
                // TODO: Abre as configurações
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
        padding: EdgeInsets.only(top: 20, left: 20, right: 10),
        children: <Widget> [
          Center(
            child:
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _pesq,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pesquisa'
                  ),
                  onSubmitted: (String value){
                    // faz a busca pelo "value"
                  },
                ),
                Container(
                  height: 20,
                ),
                Text(
                  'Digite o que deseja procurar no espaço acima.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 20,
                ),
                SizedBox(
                  height: 400,
                  width: 400,
                  child: GoogleMap(
                    liteModeEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
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
