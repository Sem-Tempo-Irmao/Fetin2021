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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados da Pesquisa'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        children: [
          Text('debug: '+widget.search) // debug
        ],
      ),
      
    );
  }
}