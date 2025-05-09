import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NovaSenhaPage extends StatefulWidget {
  const NovaSenhaPage({Key? key}) : super(key: key);

  @override
  State<NovaSenhaPage> createState() => _NovaSenhaPageState();
}

class _NovaSenhaPageState extends State<NovaSenhaPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _tokenController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _tokenController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _enviarNovaSenha() async {
    if (_formKey.currentState!.validate()) {
      final body = {
        'email': _emailController.text.trim(),
        'token': _tokenController.text.trim(),
        'novaSenha': _senhaController.text.trim(),
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:4040/enviar-nova-senha'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );

        final data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Senha redefinida com sucesso')),
          );

          // Aguarda 2 segundos e volta para login
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, '/');
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Erro ao redefinir a senha')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro de conexão: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redefinir Senha')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Informe o token enviado por SMS e crie uma nova senha.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe o e-mail' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _tokenController,
                  decoration: const InputDecoration(
                    labelText: 'Token',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe o token' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Nova senha',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.length < 6 ? 'Senha muito curta' : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _enviarNovaSenha,
                  child: const Text('Confirmar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
