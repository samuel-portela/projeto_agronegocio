import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:smart_agro/models/clima_model.dart';
import '../controllers/clima_controller.dart';
import '../models/clima_model.dart';

class InformacoesTempo extends StatefulWidget {
  @override
  _InformacoesTempoState createState() => _InformacoesTempoState();
}

class _InformacoesTempoState extends State<InformacoesTempo> {
  late Future<ClimaModel> _climaFuturo;

  @override
  void initState() {
    super.initState();
    _climaFuturo = ClimaController().buscarClimaAtual(cidade: 'São Paulo');
  }

 String _formatarDataAtual() {
  try {
    initializeDateFormatting('pt_BR', null);
    final agora = DateTime.now();
    final formatter = DateFormat('EEEE, d \'de\' MMMM \'de\' y', 'pt_BR');
    final dataFormatada = formatter.format(agora);
    return dataFormatada[0].toUpperCase() + dataFormatada.substring(1);
  } catch (e) {
    final fallback = DateFormat.yMd().format(DateTime.now());
    return fallback[0].toUpperCase() + fallback.substring(1);
  }
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClimaModel>(
      future: _climaFuturo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erro ao carregar o clima 🌩️');
        } else if (snapshot.hasData) {
          final clima = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Image.network(
                'https://openweathermap.org/img/wn/${clima.icone}@4x.png',
                width: 120,
                height: 120,
              ),
              Text(
                clima.descricao[0].toUpperCase() + clima.descricao.substring(1),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '${clima.temperatura.toStringAsFixed(0)} °C',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Text(
                _formatarDataAtual(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'Umidade: ${clima.umidade.toStringAsFixed(0)}%',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'Cidade: ${clima.cidade}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          );
        } else {
          return Text('Sem dados disponíveis.');
        }
      },
    );
  }
}
