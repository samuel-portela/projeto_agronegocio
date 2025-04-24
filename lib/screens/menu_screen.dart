import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:smart_agro/widgets/app_bar.dart';
import 'package:smart_agro/widgets/custom_button.dart';
import 'package:smart_agro/widgets/informacoes_tempo.dart';
import 'package:smart_agro/widgets/menu_hamburguer.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
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
      appBar: AppBarWidget(text: 'T'),
      drawer: DrawerWidget(nome: 'Trikas', email: 'trikas@exemplo.com'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80),
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
                text: 'Preços das sacas',
                onPressed: () {
                  Navigator.of(context).pushNamed('/precosacaScreen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
