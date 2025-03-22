import 'package:flutter/material.dart';

class CustomTextWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;

  // Construtor para receber o texto e o ícone como parâmetros
  CustomTextWithIcon({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8), // Adiciona um espaçamento entre o texto e o ícone
        Icon(icon, color: Colors.white),
      ],
    );
  }
}
