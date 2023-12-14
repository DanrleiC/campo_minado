import 'package:campo_minado/components/resultado.dart';
import 'package:campo_minado/components/tabuleiro.dart';
import 'package:campo_minado/models/campo.model.dart';
import 'package:campo_minado/models/explosao.exeption.model.dart';
import 'package:campo_minado/models/tabuleiro.model.dart';
import 'package:flutter/material.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  bool? _venceu;
  TabuleiroModel? _tabuleiro;

  void get _reboot {
    setState(() {
      _venceu = null;
      _tabuleiro?.reiniciar();
    });
  }

  void _abrir(CampoModel campo){
    if (_venceu != null) {
      return;
    }
    setState(() {
      try {
        campo.abrir();
        if (_tabuleiro!.resolvido) {
          _venceu = true;
        }
      } on ExplosaoExeceptionModel {
        _venceu = false;
        _tabuleiro!.revelarBombas();
      }
    });
  }

  void _onAlternarMarcacao(CampoModel campo) {
    setState(() {
      campo.alternarMarcacao();
      if (_tabuleiro!.resolvido) {
          _venceu = true;
        }
    });
  }

  TabuleiroModel? _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int? qtdColunas = 15;
      double? tamanhoCampo = largura / qtdColunas;
      int? qtdLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro = TabuleiroModel(linhas: qtdLinhas, colunas: qtdColunas, qtdBombas: 30);
    }
    return _tabuleiro;
  }

  Resultado get _appbar => Resultado(
    venceu: _venceu, 
    onReboot: () => _reboot
  );

  Widget get _content => LayoutBuilder(
    builder: (ctx, constraints) => Container(
      color: Colors.blueAccent,
      child: Tabuleiro(
        tabuleiro: _getTabuleiro(
          constraints.maxWidth, 
          constraints.maxHeight
        ),
        onAbrir: _abrir,
        onAlternarMarcacao: _onAlternarMarcacao,
      ),
    )
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _appbar,
        body: _content
      ),
    );
  }
}