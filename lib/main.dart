import 'package:flutter/material.dart';
import 'package:smart_agro/screens/login_screen.dart';


void main() {
  runApp(SmartAgro());
}

class SmartAgro extends StatelessWidget {
  const SmartAgro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agro Smart | Bem vindo(a)!',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
