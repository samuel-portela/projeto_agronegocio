import 'package:flutter/material.dart';

class AgroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            'T',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.wb_sunny, size: 80, color: Colors.orange),
            Text(
              'Ensolarado',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '26°C',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Máxima: 28°C  Mínima: 18°C'),
            Text('Sensação térmica: 24°C'),
            SizedBox(height: 10),
            Text(
              'São João da Boa Vista - SP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
                  Text(
                    'Plantio Ideal: Tomate ',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.emoji_food_beverage, color: Colors.white),
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
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Agrotóxicos ideais:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text('• Benalaxyl', style: TextStyle(color: Colors.white)),
                  Text('• Chlorothalonil', style: TextStyle(color: Colors.white)),
                  Text('• Methomyl', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                  Text(
                    'Previsão de Colheita: 90 Dias',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
