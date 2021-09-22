import 'package:flutter/material.dart';
import 'package:front_end_local_farmaco/produto/Farmaco.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key? key, required this.prod}) : super(key: key);
  final Produto prod;
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  
  Widget Space(){
    return SizedBox(height: 20);
  }

  Widget ItemDescricao(String item, String descricao){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          item + ': ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          descricao,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal
          ),
        )
      ],
    );
  }

  Widget InfosRemedio(){
    Remedio r = widget.prod as Remedio;
    return Column(
      children: [
        ItemDescricao('Tarja', r.tarja),
        ItemDescricao('Dosagem', r.dosagem),
        ItemDescricao('Referência', r.referencia),
        ItemDescricao('Laboratório', r.lab),
        ItemDescricao('Tipo de administração', r.tipoAdm),
        ItemDescricao('Categoria', r.categoria),
      ],
    );
  }
  
  Widget InfosCosmetico(){
    Cosmetico c = widget.prod as Cosmetico;
    return Column(
      children: [
        ItemDescricao("Conteúdo", c.conteudo),
        ItemDescricao("Marca", c.marca),
        ItemDescricao("Categoria", c.categoria),
      ],
    );
  }

  Set<Marker> ponteiros = {};

  bool liked = false; // TODO: adicionar leitura de "está ou nao curtido" no initState
  
  @override
  void initState() {
    super.initState();
    liked = Produto.fav.contains(widget.prod);
    ponteiros.add(Marker(
      markerId: MarkerId(widget.prod.farmacia),
      draggable: true,
      position: widget.prod.posFarmacia,
      onTap: (){
        
      }
    ));
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.prod.nome),
        backwardsCompatibility: true,
      ),
      body:
        ListView(
          padding: EdgeInsets.only(top:10, left: 10, right: 10),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  liked?'Remover dos favoritos   ':'Adicionar aos favoritos  ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                GestureDetector(
                  child: Icon(liked?Icons.star:Icons.star_border, color: Colors.red,size: 30,),
                  onTap: () {
                    liked = !liked;
                    setState(() {
                      if(liked) {
                        Produto.fav.add(widget.prod);
                      }
                      else {
                        Produto.fav.remove(widget.prod);
                      }
                    });
                  },                  
                )
              ],
            ),
            Space(),
            Image.network(widget.prod.linkImagem, width: MediaQuery.of(context).size.width,),
            Space(),
            ItemDescricao('Preço', 'R\$ ' + '${widget.prod.preco.toStringAsFixed(2)}'),
            ItemDescricao('Quantidade em estoque', widget.prod.estoque.toString()),
            if(widget.prod is Remedio)
              InfosRemedio(),
            if(widget.prod is Cosmetico)
              InfosCosmetico(),
            Space(),
            ItemDescricao('Farmácia', widget.prod.farmacia),
            ItemDescricao('Localização', ''),
            Space(),
            Container(
              height: 600,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                  liteModeEnabled: false,
                  mapToolbarEnabled: false,
                  mapType: MapType.terrain,
                  initialCameraPosition: CameraPosition(target: widget.prod.posFarmacia, zoom: 16),
                  myLocationEnabled: false,
                  markers: ponteiros,
                ),
            ),
          ],
        ),
    );
  }
  
}