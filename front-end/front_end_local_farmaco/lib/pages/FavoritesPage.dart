import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end_local_farmaco/produto/Farmaco.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'ProductPage.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  
  Widget Space(){
    return SizedBox(height: 20);
  }

  Widget Card(double fakeDistancia, Produto _q) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(prod:_q,pagFavoritos: true,),
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
        title: Text('Favoritos'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        children: [
          Card(0.3, Remedio('https://araujo.vteximg.com.br/arquivos/ids/4016625-1000-1000/07896714213736.jpg?v=637411331362470000','Dipirona', 4.95, 32, 'Drogarias Bifarma', LatLng(-22.2531,-45.7053), '500 g', 'Nenhuma', 'Neo Química', 'Via oral', 'Genérico', 'Analgésico')),
          Space(),
        ],
      ),
    );
  }
}
