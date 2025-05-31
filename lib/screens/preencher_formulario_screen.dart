import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_agro/controllers/dados_controller.dart';
import '../widgets/custom_button.dart'; // Seu botão customizado

class PreencherFormularioScreen extends StatefulWidget {
  const PreencherFormularioScreen({Key? key}) : super(key: key);

  @override
  State<PreencherFormularioScreen> createState() =>
      _PreencherFormularioScreenState();
}

class _PreencherFormularioScreenState extends State<PreencherFormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _fazendaControllers = [];
  final List<TextEditingController> _plantacaoControllers = [];
  bool _isLoading = false;
  final _controller = DadosController();

  @override
  void initState() {
    super.initState();
    _addNovaFazenda();
  }

  void _addNovaFazenda() {
    setState(() {
      _fazendaControllers.add(TextEditingController());
      _plantacaoControllers.add(TextEditingController());
    });
  }

  void _removerFazenda(int index) {
    setState(() {
      _fazendaControllers[index].dispose();
      _plantacaoControllers[index].dispose();
      _fazendaControllers.removeAt(index);
      _plantacaoControllers.removeAt(index);
    });
  }

  void _enviarFormulario() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

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

      List<Map<String, dynamic>> dadosFazendas = [];

      for (int i = 0; i < _fazendaControllers.length; i++) {
        final nomeFazenda = _fazendaControllers[i].text.trim();
        final tiposPlantacao =
            _plantacaoControllers[i].text
                .split(',')
                .map((e) => e.trim())
                .toList();

        dadosFazendas.add({'nome': nomeFazenda, 'plantacoes': tiposPlantacao});
      }

      final sucesso = await _controller.enviarFormularioMultiplo(
        fazendas: dadosFazendas,
        token: token,
      );

      setState(() => _isLoading = false);

      if (sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Formulários enviados com sucesso!')),
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

  void _mostrarTermosDeUso() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Termos de Uso'),
            content: const SingleChildScrollView(
              child: Text(
                'Ao cadastrar a fazenda no aplicativo AgroSmart, você declara estar ciente e de acordo com os Termos de Uso e a Política de Privacidade. '
                'Os dados fornecidos serão utilizados exclusivamente para fins de análise, melhoria contínua dos nossos serviços, personalização da experiência do usuário '
                'e para garantir o funcionamento adequado da plataforma.\n\n'
                'Em conformidade com a Lei Geral de Proteção de Dados (LGPD), garantimos que todas as informações são armazenadas de forma segura, com uso de tecnologias de '
                'criptografia e boas práticas de segurança da informação.\n\n'
                'Nenhum dado será compartilhado com terceiros sem o seu consentimento expresso.',
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Fechar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    for (final c in _fazendaControllers) {
      c.dispose();
    }
    for (final c in _plantacaoControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildFormularioContent(),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFormularioContent() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
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
                'Cadastro das Fazendas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _fazendaControllers.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _fazendaControllers[index],
                        decoration: InputDecoration(
                          labelText: 'Nome da Fazenda ${index + 1}',
                          border: const OutlineInputBorder(),
                          suffixIcon:
                              _fazendaControllers.length > 1
                                  ? IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _removerFazenda(index),
                                  )
                                  : null,
                        ),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Informe o nome da fazenda'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _plantacaoControllers[index],
                        decoration: const InputDecoration(
                          labelText:
                              'Tipos de Plantação (separados por vírgula)',
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
                    ],
                  );
                },
              ),
              ElevatedButton.icon(
                onPressed: _addNovaFazenda,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar outra fazenda'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: _isLoading ? 'Enviando...' : 'Enviar',
                onPressed: _isLoading ? null : _enviarFormulario,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _mostrarTermosDeUso,
                child: const Text.rich(
                  TextSpan(
                    text: 'Ao cadastrar, você aceita os ',
                    children: [
                      TextSpan(
                        text: 'Termos de Uso',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
