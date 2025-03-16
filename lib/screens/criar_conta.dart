import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

class CriarConta extends StatefulWidget {
  const CriarConta({Key? key}) : super(key: key);

  @override
  _CriarContaState createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {
  bool _isChecked = false;

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
                'Crie sua conta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              CustomTextField(label: 'Informe Seu Email'),
              const SizedBox(height: 20),
              CustomTextField(label: 'Crie uma senha', obscureText: true),
              const SizedBox(height: 20),
              CustomTextField(label: 'Confirme sua senha', obscureText: true),
              const SizedBox(height: 20),
              CustomTextField(label: 'Informe seu telefone', obscureText: true),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text('Aceito os Termos de Uso'),
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    _isChecked
                        ? () {
                          // Ação quando os termos forem aceitos
                          print('Termos aceitos!');
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isChecked
                          ? Colors.green
                          : Colors.grey, // Cor de fundo do botão
                  foregroundColor: Colors.white, // Cor do texto
                ),
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
