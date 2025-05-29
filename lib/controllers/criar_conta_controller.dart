import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as client;
import 'dart:convert';
import '../models/user_model.dart';

class CriarContaController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();
  final telefoneController = TextEditingController();

  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    telefoneController.dispose();
  }

  Future<bool?> enviarDados(UserModel user) async {
    try {

<<<<<<< HEAD
      final response = await client.post(
=======
      final response = await http.post(
>>>>>>> 45ed48c (Ajustes dos testes)
        Uri.parse('http://3.84.141.2:4040/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        jsonDecode(response.body);
        return true;
      } else {
        jsonDecode(response.body);
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
