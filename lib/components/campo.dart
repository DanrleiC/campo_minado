import 'package:campo_minado/models/campo.model.dart';
import 'package:flutter/material.dart';

class Campo extends StatelessWidget {

  final CampoModel campo;
  final void Function(CampoModel) onAbrir;
  final void Function(CampoModel) onAlternarMarcacao;

  const Campo({
    super.key, 
    required this.campo,
    required this.onAbrir,
    required this.onAlternarMarcacao,
  });

  Widget get _getImage {
    int? qtd = campo.qtdMinasVizinhanca;
    if (campo.aberto && campo.minado && campo.explodido) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (campo.aberto && campo.minado) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (campo.aberto) {
      return Image.asset('assets/images/aberto_$qtd.jpeg');
    }else if(campo.marcado) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAbrir(campo),
      onLongPress: () => onAlternarMarcacao(campo),
      child: _getImage,
    );
  }
}