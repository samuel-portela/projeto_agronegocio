import 'package:flutter/material.dart';
import '../controllers/criar_conta_controller.dart';
import '../models/user_model.dart';
import '../widgets/custom_buttom_criar_conta.dart';

class CriarConta extends StatefulWidget {
  const CriarConta({Key? key}) : super(key: key);

  @override
  _CriarContaState createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {
  final controller = CriarContaController();
  bool _isChecked = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (controller.formKey.currentState!.validate()) {
      if (!_isChecked) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Você precisa aceitar os Termos de Uso'),
          ),
        );
        return;
      }

      final user = UserModel(
        nome: controller.nomeController.text,
        email: controller.emailController.text,
        senha: controller.senhaController.text,
        telefone: controller.telefoneController.text,
      );

      final resultado = await controller.enviarDados(user);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              resultado!
                  ? Text('Sucesso ao cadastrar!')
                  : Text('Sucesso ao cadastrar!'),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 150),
                const SizedBox(height: 20),
                const Text(
                  'AgroSmart',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 3)],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Crie sua conta',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Nome
                TextFormField(
                  controller: controller.nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Digite seu nome'
                              : null,
                ),
                const SizedBox(height: 20),

                // Email
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Digite seu email';
                    if (!value.contains('@')) return 'Email inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Senha
                TextFormField(
                  controller: controller.senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.length < 6
                              ? 'A senha deve ter pelo menos 6 caracteres'
                              : null,
                ),
                const SizedBox(height: 20),

                // Confirmar Senha
                TextFormField(
                  controller: controller.confirmarSenhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirme sua senha',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value != controller.senhaController.text
                              ? 'As senhas não coincidem'
                              : null,
                ),
                const SizedBox(height: 20),

                // Telefone
                TextFormField(
                  controller: controller.telefoneController,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Digite seu telefone'
                              : null,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),

                // Termos de Uso
                CheckboxListTile(
                  title: const Text('Aceito os Termos de Uso'),
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Botão
                CustomButtonCriarConta(
                  text: 'Criar Conta',
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
