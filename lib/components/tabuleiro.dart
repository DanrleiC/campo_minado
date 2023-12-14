import 'package:campo_minado/components/campo.dart';
import 'package:campo_minado/models/campo.model.dart';
import 'package:campo_minado/models/tabuleiro.model.dart';
import 'package:flutter/material.dart';

class Tabuleiro extends StatelessWidget {

  final TabuleiroModel? tabuleiro;
  final void Function(CampoModel) onAbrir;
  final void Function(CampoModel) onAlternarMarcacao;
  
  const Tabuleiro({
    super.key,
    required this.tabuleiro,
    required this.onAbrir,
    required this.onAlternarMarcacao,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: tabuleiro!.colunas,
      children: tabuleiro!.campos.map((c) {
        return Campo(
          campo: c, 
          onAbrir: onAbrir, 
          onAlternarMarcacao: onAlternarMarcacao
        );
      }).toList(), 
    );
  }
}