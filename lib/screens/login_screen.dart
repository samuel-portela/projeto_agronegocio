import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/login_controller.dart';
import '../models/user_login.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _loginController = LoginController();
  bool _isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      final user = UserLogin(
        email: _emailController.text.trim(),
        senha: _senhaController.text.trim(),
      );

      final success = await _loginController.login(user);

      setState(() => _isLoading = false);

      if (success) {
        Navigator.of(context).pushReplacementNamed('/menuScreen');
      } else {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text('Erro'),
                content: const Text('Email ou senha inválidos.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.jpg', height: 150),
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
                  'Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu email';
                    } else if (!value.contains('@')) {
                      return 'Email inválido';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite sua senha';
                    } else if (value.length < 4) {
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/recuperarSenha');
                    },
                    child: const Text(
                      'Esqueci a senha',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: _isLoading ? 'Entrando...' : 'Login',
                  onPressed: _isLoading ? null : _handleLogin,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/criarConta');
                  },
                  child: const Text(
                    'Não tem conta ? Crie uma',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
