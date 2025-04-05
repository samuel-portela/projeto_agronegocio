import 'package:flutter/material.dart';

class InformacoesTempo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Image.asset(
          'assets/images/ensolarado.gif',
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 1),
        Text(
          'Ensolarado',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text(
          '26°C',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 1),
        Text(
          'Segunda-feira,\n10 de Fevereiro',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
