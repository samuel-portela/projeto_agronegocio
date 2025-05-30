import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_agro/screens/menu_screen.dart';


void main() {
  testWidgets('Deve renderizar todos os botões principais',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const MenuScreen(),
        routes: {
          '/plantacao': (context) => const Scaffold(body: Text('Plantio')),
          '/telaLocalizacao': (context) => const Scaffold(body: Text('Mapa')),
          '/precosacaScreen': (context) => const Scaffold(body: Text('Sacas')),
          '/previsao-tempo': (context) =>
              const Scaffold(body: Text('Previsão')),
        },
      ),
    );

    expect(find.text('Informações Plantio'), findsOneWidget);
    expect(find.text('Localização e mapas'), findsOneWidget);
    expect(find.text('Preços das sacas'), findsOneWidget);
    expect(find.text('Previsão dos próximos 5 dias'), findsOneWidget);
  });

  testWidgets('Deve navegar para a tela de Plantio ao clicar no botão',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const MenuScreen(),
        routes: {
          '/plantacao': (context) => const Scaffold(body: Text('Plantio')),
        },
      ),
    );

    await tester.tap(find.text('Informações Plantio'));
    await tester.pumpAndSettle();

    expect(find.text('Plantio'), findsOneWidget);
  });

  testWidgets('Deve abrir o Drawer ao clicar no botão do menu',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const MenuScreen(),
      ),
    );

    // Abre o Drawer
    final scaffoldState =
        tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('Trikas'), findsOneWidget);
    expect(find.text('trikas@exemplo.com'), findsOneWidget);
  });
}
