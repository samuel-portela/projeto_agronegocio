import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:smart_agro/controllers/previsao_controller.dart';
import 'package:smart_agro/models/previsao_dia.dart';
import 'package:smart_agro/widgets/app_bar.dart';
import 'package:smart_agro/widgets/menu_hamburguer.dart';



class TelaPrevisao extends StatefulWidget {
  @override
  _TelaPrevisaoState createState() => _TelaPrevisaoState();
}

class _TelaPrevisaoState extends State<TelaPrevisao> {
  final _controller = TextEditingController();
  List<PrevisaoDia> previsoes = [];

  Future<void> buscarPrevisao() async {
    final cityName = _controller.text.trim();
    if (cityName.isEmpty) return;

    final controller = PrevisaoController();

    final cityKey = await controller.buscarCityKey(cityName);
    if (cityKey != null) {
      final dados = await controller.buscarPrevisao5Dias(cityKey);
      setState(() {
        previsoes = dados;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cidade não encontrada')),
      );
    }
  }

   @override
  void initState() {
    super.initState();
    // Inicializa a localidade para garantir que a data será exibida em português
    initializeDateFormatting('pt_BR', null).then((_) {
     Intl.defaultLocale = 'pt_BR';
    _controller.text = 'São João da Boa Vista'; // Coloca o texto no campo de busca
    buscarPrevisao(); // Definir o locale como pt_BR
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: 'T'),
      drawer: DrawerWidget(nome: 'Trikas', email: 'trikas@exemplo.com'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barra de pesquisa
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Digite o nome da cidade',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: buscarPrevisao,
                ),
              ],
            ),
            SizedBox(height: 20),
            // Previsões
            Expanded(
              child: ListView.builder(
                itemCount: previsoes.length,
                itemBuilder: (context, index) {
                  final dia = previsoes[index];
                  return Card(
                    child: ListTile(
                      leading: Image.asset(
                        'images/${dia.icone}.png', // Coloque os ícones no assets
                        width: 40,
                        height: 40,
                      ),
                      title: Text(
                        '${DateFormat('EEEE', 'pt_BR').format(dia.data)[0].toUpperCase()}${DateFormat('EEEE, dd/MM/yyyy', 'pt_BR').format(dia.data).substring(1)} - ${dia.descricao}',
                      ),
                      subtitle: Text(
                        'Máx: ${dia.temperaturaMax}°C / Mín: ${dia.temperaturaMin}°C',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
