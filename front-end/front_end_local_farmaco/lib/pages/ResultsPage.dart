import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end_local_farmaco/produto/Farmaco.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'ProductPage.dart';

enum OpcaoOrdenacao { distance, price }
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
/*
  TODO:
    - Implementar pesquisa no banco e filtragem
    - Calcular as distâncias reais
 */

  TextEditingController _maxDist = TextEditingController();
  TextEditingController _minPreco = TextEditingController();
  TextEditingController _maxPreco = TextEditingController();
  double maxDist = double.infinity, minPreco = 0, maxPreco = double.infinity;
  OpcaoOrdenacao? _opOrd = OpcaoOrdenacao.distance;

  bool filtrado = false;
  void _filtrar() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Filtrar"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Faixa de preço:'),
                SizedBox(height: 5, width: 10,),
                TextField(
                  controller: _minPreco,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(), 
                    labelText: 'Preço mínimo em R\$',
                  ),
                ),
                SizedBox(height: 5, width: 10,),
                TextField(
                  controller: _maxPreco,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(), 
                    labelText: 'Preço máximo em R\$',
                  ),
                ),
                SizedBox(height: 15, width: 10,),
                Text('Distância'),
                SizedBox(height: 5, width: 10,),
                TextField(
                  controller: _maxDist,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(), 
                    labelText: 'Distância máxima em km',
                  ),
                ),
                SizedBox(height: 15, width: 10,),
                Text('Ordenar por: '),
                RadioListTile<OpcaoOrdenacao>(
                  title: const Text('Distância'),
                  value: OpcaoOrdenacao.distance,
                  groupValue: _opOrd,
                  onChanged: (OpcaoOrdenacao? value){
                    setState((){
                      _opOrd = value;
                    });
                  }
                ),
                RadioListTile<OpcaoOrdenacao>(
                  title: const Text('Preço'),
                  value: OpcaoOrdenacao.price,
                  groupValue: _opOrd,
                  onChanged: (OpcaoOrdenacao? value){
                    setState((){
                      _opOrd = value;
                    });
                  }
                ),
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
                  setState(() {
                    filtrado = true;
                    if(_maxDist.text != '')
                      maxDist = double.parse(_maxDist.text);
                    if(_minPreco.text != '')
                      minPreco = double.parse(_minPreco.text);
                    if(_maxPreco.text != '')
                      maxPreco = double.parse(_maxPreco.text);
                  });

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

  Widget Space(){
    return SizedBox(height: 20);
  }

  Widget Card(double fakeDistancia, Produto _q) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(prod:_q, pagFavoritos: false,),
          ),
        );
      },
      child: Container(
        height: 120,
        padding: EdgeInsets.only(left: 10,top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white54,
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.network(_q.linkImagem),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _q.nome,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                    'R\$ ' + '${_q.preco.toStringAsFixed(2)}',
                    style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                    'Distância: ' + '${fakeDistancia}' + ' km',
                    style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ), 
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Resultados da Pesquisa'),
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          children: [
            Text('Exibindo resultados para:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Text(widget.search,style: TextStyle(fontSize: 18)),
            Space(),
            if(filtrado)  
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Icon(Icons.close_rounded, color: Colors.red,size: 30,),
                    onTap: () {
                      // TODO: adicionar ou remover dos favoritos
                      filtrado = false;
                      setState(() {});
                    },                  
                  ),
                  Text(
                    '    Remover filtros',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            if(filtrado)
              Space(),
            Card(0.3, Remedio('https://araujo.vteximg.com.br/arquivos/ids/4016625-1000-1000/07896714213736.jpg?v=637411331362470000','Dipirona', 4.95, 32, 'Drogarias Bifarma', LatLng(-22.2531,-45.7053), '500 g', 'Nenhuma', 'Neo Química', 'Via oral', 'Genérico', 'Analgésico')),
            Space(),
            Card(0.4, Produto('https://cdn.ultrafarma.com.br/static/produtos/772338/large-637202403852182997-772338_2.png', 'Paracetamol', 6.99, 12,'Drogasil', LatLng(-22.2531,-45.7053))),
            Space(),
            if(!filtrado)
              Card(0.4, Produto('https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQKFOU6dLecaEdRRtU5--B_B0GA45ojNwzdN6YIfjM_CAHpV3WFWljnaMEP48EQCnD4hz33-blUpaG4B8u8r5N4-uElOa3EOw&usqp=CAY','Neosaldina', 16.90, 12,'Drogasil', LatLng(-22.2531,-45.7053))),
            if(!filtrado)
              Space(),
            if(!filtrado)
              Card(0.75, Produto('https://io2.convertiez.com.br/m/drogal/shop/products/images/5530014/large/ibuprofeno-400mg-10cp-g-n-q_7171.jpg','Ibuprofeno', 9.99, 12,'Drogasil', LatLng(-22.2531,-45.7053))),
            if(!filtrado)
              Space(),           
            Card(0.98, Produto('https://www.farmadelivery.com.br/media/catalog/product/cache/1/image/400x400/9df78eab33525d08d6e5fb8d27136e95/4/1/4124-paracetamol-750mg-c-20-comprimidos-generico-germed.jpg', 'Paracetamol', 6.50, 12,'Drogasil', LatLng(-22.2531,-45.7053))),
            Space(),

            if(!filtrado)
              Card(1.4, Produto('https://www.drogariaminasbrasil.com.br/media/product/4ea/dipirona-monoidratada-sabor-framboesa-50mg-ml-com-100-ml-generico-ems-c2b.jpg', 'Dipirona', 5.49, 12,'Drogasil', LatLng(-22.2531,-45.7053))),
            if(!filtrado)
              Space(),
            //Text('debug: ' + widget.search), // debug
            //Text('maxDist: ' + (maxDist.toString())),
            //Text('minPreco: ' + (minPreco.toString())),
            //Text('maxPreco: ' + (maxPreco.toString())),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _filtrar,
          tooltip: 'Filtrar',
          child: Icon(Icons.filter_list_alt),
        ));
  }
}
