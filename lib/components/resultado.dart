// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class Resultado extends StatelessWidget implements PreferredSizeWidget{

  final bool? venceu;
  final void Function() onReboot;

  const Resultado({
    super.key, 
    required this.venceu,
    required this.onReboot
  });

  Color? get _getColor => venceu == null ? Colors.yellow : venceu! ? Colors.green.shade300 : Colors.red.shade300;

  IconData get _getIcon => venceu == null ? Icons.sentiment_satisfied : venceu! ? Icons.sentiment_very_satisfied : Icons.sentiment_very_dissatisfied;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: onReboot, 
              icon: Icon(
                _getIcon,
                color: Colors.black,
                size: 35,
              )
            ),
          ),
        )
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(120);
}