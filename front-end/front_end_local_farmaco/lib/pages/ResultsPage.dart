import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResultsPage extends StatefulWidget {
  ResultsPage({Key? key, required this.search}) : super(key: key);
  //final String title;
  // search -> Produto a ser pesquisado
  // para utilizar, chamar "widget.search"
  final String search;
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  void _filtrar() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Filtrar"),
            content: 
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Opção 1"),
                  Text("Opção 2"),
                  Text("Opção 3"),
                  Text(" . . ."),
                  Text("Opção N"),
                ],
              ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(88, 44),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  // Faz o que tiver que fazer e fecha

                  Navigator.of(context).pop();
                },
                child: Text(
                  "Aplicar filtros",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Resultados da Pesquisa'),
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          children: [
            Text('debug: ' + widget.search) // debug
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _filtrar,
          tooltip: 'Filtrar',
          child: Icon(Icons.filter_list_alt),
        ));
  }
}
