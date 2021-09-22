import 'package:google_maps_flutter/google_maps_flutter.dart';

class Produto
{
  static List <Produto> fav = [];
  String linkImagem;
  String nome;
  double preco;
  int estoque;
  String farmacia;
  LatLng posFarmacia;
  double distancia;
  Produto(String this.linkImagem, String this.nome, double this.preco, int this.estoque, String this.farmacia, LatLng this.posFarmacia, double this.distancia) { }
}

class Remedio extends Produto {
  String dosagem;
  String tarja;
  String lab;
  String tipoAdm;
  String referencia;
  String categoria;
  Remedio(String _linkImagem, String _nome, double _preco, int _estoque, String _farmacia, LatLng _posFarmacia, String this.dosagem, String this.tarja, String this.lab, String this.tipoAdm, String this.referencia, String this.categoria, double _distancia) : super(_linkImagem, _nome, _preco, _estoque, _farmacia, _posFarmacia, _distancia) {}
}

class Cosmetico extends Produto {
  String conteudo;
  String marca;
  String categoria;
  Cosmetico(String _linkImagem, String _nome, double _preco, int _estoque, String _farmacia, LatLng _posFarmacia, String this.conteudo, String this.marca, String this.categoria, double _distancia) : super(_linkImagem, _nome, _preco, _estoque, _farmacia,_posFarmacia, _distancia) {}
}