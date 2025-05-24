import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_agro/controllers/dados_controller.dart';
import '../widgets/custom_button.dart'; // Certifique-se de ter esse widget

class PreencherFormularioScreen extends StatefulWidget {
  const PreencherFormularioScreen({Key? key}) : super(key: key);

  @override
  State<PreencherFormularioScreen> createState() =>
      _PreencherFormularioScreenState();
}

class _PreencherFormularioScreenState extends State<PreencherFormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fazendaController = TextEditingController();
  final TextEditingController _plantacaoController = TextEditingController();
  bool _isLoading = false;

  void initState() {
    super.initState();

    _plantacaoController.addListener(() {
      final text = _plantacaoController.text;
      final transformed = text.replaceAll(' ', '|');

      if (text != transformed) {
        _plantacaoController.value = _plantacaoController.value.copyWith(
          text: transformed,
          selection: TextSelection.collapsed(offset: transformed.length),
        );
      }
    });
  }

  final _controller = DadosController();

  void _enviarFormulario() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final nomeFazenda = _fazendaController.text.trim();
      final tiposPlantacao =
          _plantacaoController.text.split(',').map((e) => e.trim()).toList();

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Token não encontrado. Faça login novamente.'),
          ),
        );
        setState(() => _isLoading = false);
        return;
      }

      final sucesso = await _controller.enviarFormulario(
        nome: nomeFazenda,
        tipoPlantacao: tiposPlantacao,
        token: token,
      );

      setState(() => _isLoading = false);

      if (sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Formulário enviado com sucesso!')),
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/menuScreen');
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao enviar formulário.')),
        );
      }
    }
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
                  'Cadastro da Fazenda',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _fazendaController,
                  decoration: const InputDecoration(
                    labelText: 'Nome da Fazenda',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Informe o nome da fazenda'
                              : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _plantacaoController,
                  decoration: const InputDecoration(
                    labelText: 'Tipos de Plantação (separados por pipe)',
                    hintText: 'Ex: Milho, Soja, Café',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Informe pelo menos uma plantação'
                              : null,
                ),

                const SizedBox(height: 30),
                CustomButton(
                  text: _isLoading ? 'Enviando...' : 'Enviar',
                  onPressed: _isLoading ? null : _enviarFormulario,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fazendaController.dispose();
    _plantacaoController.dispose();
    super.dispose();
  }
}
