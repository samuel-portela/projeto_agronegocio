import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      final response = await http.post(
        Uri.parse('http://localhost:4040/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return true;
      } else {
        final error = jsonDecode(response.body);
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
