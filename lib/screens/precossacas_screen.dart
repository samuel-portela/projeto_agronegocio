import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:smart_agro/controllers/precossacas_controller.dart';
import 'package:smart_agro/widgets/app_bar.dart';
import 'package:smart_agro/widgets/menu_hamburguer.dart';

class PrecosSacasScreen extends StatefulWidget {
  const PrecosSacasScreen({super.key});

  @override
  _PrecosSacasScreenState createState() => _PrecosSacasScreenState();
}

class _PrecosSacasScreenState extends State<PrecosSacasScreen> {
  final controller = PrecossacasController();

  String precoSacas = 'Carregando...';

  @override
  void initState() {
    super.initState();
    carregarInformacoes();
  }

  void carregarInformacoes() async {
    final plantio = await controller.consultarPrecoSaca(
      'Me diga diretamente em tópicos as cotações dos preços das sacas de milho, café, soja, arroz, feijão, cana de açuçar, sendo direto e objetivo. Apenas falando os preços pela região do brasil. Sem colocar textos avulsos. Me forneça a cotação em dólar e real.',
    );

    setState(() {
      precoSacas = plantio ?? 'Erro ao buscar informação.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: 'T'),
      drawer: DrawerWidget(nome: 'Trikas', email: 'trikas@exemplo.com'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cotações atuais:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              MarkdownBody(
                data: precoSacas,
                styleSheet: MarkdownStyleSheet(
                  p: const TextStyle(fontSize: 16),
                  h2: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  strong: const TextStyle(fontWeight: FontWeight.bold),
                  listBullet: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
