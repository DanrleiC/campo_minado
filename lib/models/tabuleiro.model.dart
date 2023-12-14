import 'dart:math';
import 'package:campo_minado/models/campo.model.dart';

class TabuleiroModel {
  final int linhas;
  final int colunas;
  final int qtdBombas;
  TabuleiroModel({
    required this.linhas,
    required this.colunas,
    required this.qtdBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }
  
  final List<CampoModel> _campos = [];

  TabuleiroModel copyWith({
    int? linhas,
    int? colunas,
    int? qtdBombas,
  }) {
    return TabuleiroModel(
      linhas: linhas ?? this.linhas,
      colunas: colunas ?? this.colunas,
      qtdBombas: qtdBombas ?? this.qtdBombas,
    );
  }

  void _criarCampos() {
    for (int l = 0; l < linhas; l++) {
      for (int c = 0; c < colunas; c++) {
        _campos.add(CampoModel(linha: l, coluna: c));
      }
    }
  }
  
  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adcVizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    int sorteadas = 0;

    if (qtdBombas > linhas * colunas) {
      return;
    }

    while (sorteadas < qtdBombas) {
      int i = Random().nextInt(_campos.length);

      if (!_campos[i].minado) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  void reiniciar() {
    for (var c in _campos) {
      c.reboot();
    }
    _sortearMinas();
  }

  void revelarBombas() {
    for (var c in _campos) {
      c.revelarBombas();
    }
  }

  List<CampoModel> get campos => _campos;

  bool get resolvido => _campos.every((c) => c.resolvido);
}
