import 'package:flutter/material.dart';
import 'package:smart_agro/route_observer/rota_observer.dart';
import 'package:smart_agro/widgets/app_bar.dart';
import 'package:smart_agro/widgets/custom_button.dart';
import 'package:smart_agro/widgets/informacoes_tempo.dart';
import 'package:smart_agro/widgets/menu_hamburguer.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    rotaObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    rotaObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    debugPrint('🟢 Entrou na MenuScreen');
  }

  @override
  void didPop() {
    debugPrint('🔴 Saiu da MenuScreen');
  }

  @override
  void didPushNext() {
    debugPrint('➡️ Foi para outra tela a partir da MenuScreen');
  }

  @override
  void didPopNext() {
    debugPrint('⬅️ Voltou para a MenuScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: 'T'),
      drawer: DrawerWidget(nome: 'Trikas', email: 'trikas@exemplo.com'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 80),
            InformacoesTempo(),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Informações Plantio',
              icon: Icons.agriculture, // 🌾
              onPressed: () {
                Navigator.of(context).pushNamed('/plantacao');
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Localização e mapas',
              icon: Icons.map, // 🗺️
              onPressed: () {
                Navigator.of(context).pushNamed('/telaLocalizacao');
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Preços das sacas',
              icon: Icons.attach_money, // 💰
              onPressed: () {
                Navigator.of(context).pushNamed('/precosacaScreen');
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Previsão dos próximos 5 dias',
              icon: Icons.wb_sunny, // ☀️
              onPressed: () {
                Navigator.of(context).pushNamed('/previsao-tempo');
              },
            ),
          ],
        ),
      ),
    );
  }
}
