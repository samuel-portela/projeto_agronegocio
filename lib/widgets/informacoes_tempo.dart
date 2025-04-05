import 'package:flutter/material.dart';

class InformacoesTempo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 0),
        Image.asset(
          'assets/images/ensolarado2.gif',
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
        Text(
          'Ensolarado',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Text(
          '26 °C',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(
          'Segunda-feira,\n10 de Fevereiro de 2025',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
