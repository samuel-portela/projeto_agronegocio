import 'package:flutter/material.dart';
import 'package:smart_agro/widgets/app_bar.dart';
import 'package:smart_agro/widgets/custom_button.dart';
import 'package:smart_agro/widgets/informacoes_tempo.dart';
import 'package:smart_agro/widgets/menu_hamburguer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MenuScreen());
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: 'A'),
      drawer: DrawerWidget(nome: 'Antonio', email: 'joao.silva@exemplo.com'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InformacoesTempo(),
            SizedBox(height: 20),
            CustomButton(
              text: 'Informações Plantio',
              onPressed: () {
                Navigator.of(context).pushNamed('/plantacao');
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Dados Atuais',
              onPressed: () {
                Navigator.of(context).pushNamed('/menuScreen');
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Localização e mapas',
              onPressed: () {
                Navigator.of(context).pushNamed('/telaLocalizacao');
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Possiveis previsões de Safra',
              onPressed: () {
                Navigator.of(context).pushNamed('/menuScreen');
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Preços das sacas',
              onPressed: () {
                Navigator.of(context).pushNamed('/menuScreen');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
