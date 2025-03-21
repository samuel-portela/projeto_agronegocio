import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

class RecuperarConta extends StatelessWidget {
  const RecuperarConta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                'Recupere Sua Conta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const CustomTextField(label: 'Informe Seu Email'),
              const SizedBox(height: 20),
              const CustomTextField(label: 'Informe Seu Telefone'),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Recuperar Conta',
                onPressed: () {
                  // Lógica de recuperação de conta aqui
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
