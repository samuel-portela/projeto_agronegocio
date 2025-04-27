import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:smart_agro/models/clima_model.dart';
import 'package:smart_agro/controllers/clima_controller.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:smart_agro/utils/icon_map.dart';

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
    initializeDateFormatting('pt_BR', null);
    final agora = DateTime.now();
    final formatter = DateFormat('EEEE, d \'de\' MMMM \'de\' y', 'pt_BR');
    final dataFormatada = formatter.format(agora);
    return dataFormatada[0].toUpperCase() + dataFormatada.substring(1);
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
        } else if (!snapshot.hasData) {
          return Text('Sem dados disponíveis.');
        }

        final clima = snapshot.data!;
        final icone = obterIcone(clima.icone);
        final cor   = obterCor(clima.icone);


        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icone,
              size: 100,
              color: cor,
            ),
            SizedBox(height: 15),
            Text(
              clima.descricao[0].toUpperCase() + clima.descricao.substring(1),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              '${clima.temperatura.toStringAsFixed(0)} °C',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              _formatarDataAtual(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 5),
            Text(
              'Umidade: ${clima.umidade.toStringAsFixed(0)}%',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            Text(
              'Cidade: ${clima.cidade}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        );
      },
    );
  }
}
