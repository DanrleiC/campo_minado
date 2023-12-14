// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:campo_minado/models/explosao.exeption.model.dart';

class CampoModel {
  final int linha;
  final int coluna;
  List<CampoModel>? vizinhos = [];

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  CampoModel({
    required this.linha,
    required this.coluna,
  });


  void adcVizinho(CampoModel vizinho){

    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    if (deltaLinha == 0 && deltaColuna == 0) {
      return;
    }

    if (deltaLinha <= 1 && deltaColuna <= 1) {
      vizinhos?.add(vizinho);
    }
  }

  void abrir() {
    if(_aberto){
      return;
    }

    _aberto = true;

    if(_minado){
      _explodido = true;
      throw ExplosaoExeceptionModel();
    }

    if (safeVizinhanca != null && safeVizinhanca!) {
      for (var e in vizinhos!) {
        e.abrir();
      }
    }
  }

  void revelarBombas() {
    if (_minado) {
      _aberto = true;
    }
  }

  void minar() {
    _minado = true;
  }

  void alternarMarcacao() {
    _marcado = !_marcado;
  }

  void reboot(){
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  bool get minado => _minado;

  bool get explodido => _explodido;

  bool get aberto => _aberto;

  bool get marcado => _marcado;

  bool get resolvido {
    bool minadoMarcado = minado && marcado;
    bool seguroAberto = !minado && aberto;

    return minadoMarcado || seguroAberto;
  }

  int? get qtdMinasVizinhanca => vizinhos?.where((e) => e.minado).length;

  bool? get safeVizinhanca =>vizinhos?.every((e) => !e.minado);
}
