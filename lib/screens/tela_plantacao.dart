import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:smart_agro/controllers/plantacao_controller.dart';
import 'package:smart_agro/widgets/app_bar.dart';
import 'package:smart_agro/widgets/informacoes_tempo.dart';
import 'package:smart_agro/widgets/menu_hamburguer.dart';

class AgroScreen extends StatefulWidget {
  @override
  _AgroScreenState createState() => _AgroScreenState();
}

class _AgroScreenState extends State<AgroScreen> {
  final controller = PlantacaoController();

  String plantioIdeal = 'Carregando...';
  String descricaoAgrotoxicos = 'Carregando...';
  String dicasCultivo = 'Carregando...';
  String alertaClimatico = 'Carregando...';
  String alertaTemperatura = 'Carrregando...';

  @override
  void initState() {
    super.initState();
    carregarInformacoes();
  }

  void carregarInformacoes() async {
    final plantio = await controller.gerarConteudoGemini(
      'Resuma em tópicos. Qual o plantio ideal para Curitiba no mês de abril? Responda de forma direta.',
    );

    final agrotoxicos = await controller.gerarConteudoGemini(
      'Quais agrotóxicos são recomendados para esse tipo de plantio em Curitiba em abril? Fale de forma breve.',
    );

    final dicas = await controller.gerarConteudoGemini(
      'Dicas para cultivar essa plantação em Curitiba no mês de abril. Me diga a previsão de colheita também no final.',
    );

    final resultadoAlertaClimatico = await controller.gerarConteudoGemini(
      'Hipoteticamente Consulte a previsão do tempo atual para a cidade de Curitiba, considerando o dia de hoje. Com base nas informações meteorológicas, diga se há ou não algum alerta climático ativo, como chuvas intensas, geadas, ventos fortes, calor extremo ou qualquer outro fenômeno relevante. Seja direto e objetivo na resposta.',
    );

    final alerta = await controller.buscarAlertaClimatico();

    setState(() {
      plantioIdeal = plantio ?? 'Erro ao buscar informação.';
      descricaoAgrotoxicos = agrotoxicos ?? 'Erro ao buscar informação.';
      dicasCultivo = dicas ?? 'Erro ao buscar informação.';
      alertaClimatico = resultadoAlertaClimatico ?? 'Erro ao buscar informação.';
      alertaTemperatura = alerta;
    });
  }

  bool temMarkdown(String texto) {
    return texto.contains('*') || texto.contains('- ') || texto.contains('#') || texto.contains('\n');
  }

 Widget renderTexto(String texto, BuildContext context) {
  return temMarkdown(texto)
      ? MarkdownBody(
          data: texto,
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            p: const TextStyle(color: Colors.white),
            listBullet: const TextStyle(color: Colors.white),
          ),
        )
      : Text(
          texto,
          style: const TextStyle(color: Colors.white),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: 'T'),
      drawer: DrawerWidget(nome: 'Trikas', email: 'trikas@exemplo.com'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InformacoesTempo(),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.agriculture, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Plantio Ideal:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    renderTexto(plantioIdeal, context),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          'Informações:',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Agrotóxicos recomendados:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    renderTexto(descricaoAgrotoxicos, context),
                    SizedBox(height: 10),
                    Text(
                      'Dicas de Cultivo:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    renderTexto(dicasCultivo, context),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          'Alerta Climático:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    renderTexto(alertaTemperatura, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
