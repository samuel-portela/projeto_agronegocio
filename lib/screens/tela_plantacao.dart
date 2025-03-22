import 'package:flutter/material.dart';
import 'package:smart_agro/widgets/app_bar.dart';
import 'package:smart_agro/widgets/custom_textfield_com_icone.dart';
import 'package:smart_agro/widgets/informacoes_tempo.dart';
import 'package:smart_agro/widgets/menu_hamburguer.dart';

class AgroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: 'A'),
      drawer: DrawerWidget(nome: 'Antonio', email: 'joao.silva@exemplo.com'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextWithIcon(
                    text: 'Plantio Ideal: Tomate',
                    icon: Icons.emoji_food_beverage,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade300,
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
                    'Agrotóxicos ideais:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text('• Benalaxyl', style: TextStyle(color: Colors.white)),
                  Text(
                    '• Chlorothalonil',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text('• Methomyl', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                  Text(
                    'Previsão de Colheita: 90 Dias',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    'Nenhum alerta climático reportado',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
