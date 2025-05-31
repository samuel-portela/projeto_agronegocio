import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_agro/controllers/plantacao_controller.dart';
import 'package:smart_agro/widgets/app_bar.dart';
import 'package:smart_agro/widgets/informacoes_tempo.dart';
import 'package:smart_agro/widgets/menu_hamburguer.dart';
import 'package:smart_agro/widgets/green_gradient_background.dart';
import 'package:http/http.dart' as http;

class AgroScreen extends StatefulWidget {
  @override
  _AgroScreenState createState() => _AgroScreenState();
}

class _AgroScreenState extends State<AgroScreen> {
  final controller = PlantacaoController(client: http.Client());

  String plantioIdeal = 'Carregando...';
  String descricaoAgrotoxicos = 'Carregando...';
  String dicasCultivo = 'Carregando...';
  String alertaClimatico = 'Carregando...';
  String alertaTemperatura = 'Carrregando...';
  String _email = '';
  String _primeiraLetra = '';

  List<Map<String, dynamic>> fazendas = [];
  Map<String, dynamic>? fazendaSelecionada;

  @override
  void initState() {
    super.initState();
    carregarInformacoes();
    _carregarEmail();
  }

  Future<void> _carregarEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final emailSalvo = prefs.getString('email') ?? '';

    setState(() {
      _email = emailSalvo;
      _primeiraLetra = emailSalvo.isNotEmpty ? emailSalvo[0].toUpperCase() : '';
    });
  }

  void carregarInformacoes() async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt_token') ?? '';

    try {
      final response = await http.get(
        Uri.parse('http://34.201.128.160:4040/buscar-dados'),
        headers: {'Authorization': 'Bearer $jwt'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['message'] is List && data['message'].isNotEmpty) {
          setState(() {
            fazendas = List<Map<String, dynamic>>.from(data['message']);
            fazendaSelecionada = fazendas[0];
          });

          _carregarInformacoesDaFazenda(fazendaSelecionada!);
        } else {
          _mostrarErro('Dados da fazenda não encontrados.');
        }
      } else {
        _mostrarErro('Erro ao buscar dados da fazenda.');
      }
    } catch (e) {
      _mostrarErro('Erro inesperado.');
    }
  }

  void _mostrarErro(String mensagem) {
    setState(() {
      plantioIdeal = mensagem;
      descricaoAgrotoxicos = mensagem;
      dicasCultivo = mensagem;
      alertaClimatico = mensagem;
      alertaTemperatura = mensagem;
    });
  }

  Future<void> _carregarInformacoesDaFazenda(
    Map<String, dynamic> fazenda,
  ) async {
    final nomeFazenda = fazenda['nome'] ?? 'fazenda desconhecida';
    final tiposPlantacao = (fazenda['tipo_plantacao'] ?? '')
        .toString()
        .replaceAll('|', ', ');

    try {
      final plantio = await controller.gerarConteudoGemini(
        'Resuma em tópicos. Considerando a fazenda "$nomeFazenda", com as plantações de: $tiposPlantacao, qual o plantio ideal? Seja direto.',
      );

      final agrotoxicos = await controller.gerarConteudoGemini(
        'Quais agrotóxicos são recomendados para as plantações de $tiposPlantacao? Seja breve.',
      );

      final dicas = await controller.gerarConteudoGemini(
        'Dicas para cultivar $tiposPlantacao na fazenda "$nomeFazenda". Inclua a previsão de colheita no final.',
      );

      final resultadoAlertaClimatico = await controller.gerarConteudoGemini(
        'Hipoteticamente, consulte a previsão do tempo atual para Curitiba. Existe algum alerta climático ativo (chuva intensa, geada, calor extremo etc.)? Responda de forma objetiva.',
      );

      final alerta = await controller.buscarAlertaClimatico();

      setState(() {
        plantioIdeal = plantio ?? 'Erro ao buscar informação.';
        descricaoAgrotoxicos = agrotoxicos ?? 'Erro ao buscar informação.';
        dicasCultivo = dicas ?? 'Erro ao buscar informação.';
        alertaClimatico =
            resultadoAlertaClimatico ?? 'Erro ao buscar informação.';
        alertaTemperatura = alerta;
      });
    } catch (e) {
      _mostrarErro('Erro inesperado.');
    }
  }

  bool temMarkdown(String texto) {
    return texto.contains('*') ||
        texto.contains('- ') ||
        texto.contains('#') ||
        texto.contains('\n');
  }

  Widget renderTexto(String texto, BuildContext context) {
    return temMarkdown(texto)
        ? MarkdownBody(
          data: texto,
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            p: GoogleFonts.roboto(color: Colors.white),
            listBullet: GoogleFonts.roboto(color: Colors.white),
          ),
        )
        : Text(
          texto,
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
        );
  }

  Widget renderConteudoOuLoading(String texto, BuildContext context) {
    if (texto == 'Carregando...' || texto == 'Carrregando...') {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    } else {
      return renderTexto(texto, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GreenGradientBackground(
      child: Scaffold(
        appBar: AppBarWidget(text: _primeiraLetra),
        drawer: DrawerWidget(nome: _email, email: ''),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InformacoesTempo(),
                SizedBox(height: 20),

                // Dropdown de seleção de fazenda
                if (fazendas.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<Map<String, dynamic>>(
                      value: fazendaSelecionada,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      dropdownColor: Colors.green.shade800,
                      underline: SizedBox(),
                      onChanged: (novaFazenda) {
                        setState(() {
                          fazendaSelecionada = novaFazenda;
                          plantioIdeal = 'Carregando...';
                          descricaoAgrotoxicos = 'Carregando...';
                          dicasCultivo = 'Carregando...';
                          alertaClimatico = 'Carregando...';
                          alertaTemperatura = 'Carrregando...';
                        });
                        _carregarInformacoesDaFazenda(novaFazenda!);
                      },
                      items:
                          fazendas.map((fazenda) {
                            return DropdownMenuItem<Map<String, dynamic>>(
                              value: fazenda,
                              child: Text(
                                fazenda['nome'],
                                style: GoogleFonts.quicksand(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),

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
                          Icon(FontAwesomeIcons.seedling, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Plantio Ideal:',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      renderConteudoOuLoading(plantioIdeal, context),
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
                          Icon(
                            FontAwesomeIcons.circleInfo,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Informações:',
                            style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Agrotóxicos recomendados:',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      renderConteudoOuLoading(descricaoAgrotoxicos, context),
                      SizedBox(height: 10),
                      Text(
                        'Dicas de Cultivo:',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      renderConteudoOuLoading(dicasCultivo, context),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.triangleExclamation,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Alerta Climático:',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      renderConteudoOuLoading(alertaTemperatura, context),
                    ],
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
