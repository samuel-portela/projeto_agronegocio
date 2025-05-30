import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_agro/screens/menu_screen.dart';

void main() {
  testWidgets('Deve renderizar a estrutura inicial da AgroScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MenuScreen(),
      ),
    );

    // Verifica presença dos textos principais
    expect(find.text('Plantio Ideal:'), findsOneWidget);
    expect(find.text('Informações:'), findsOneWidget);
    expect(find.text('Agrotóxicos recomendados:'), findsOneWidget);
    expect(find.text('Dicas de Cultivo:'), findsOneWidget);
    expect(find.text('Alerta Climático:'), findsOneWidget);

    // Verifica texto padrão de carregamento
    expect(find.text('Carregando...'), findsWidgets);
  });

  testWidgets('Deve exibir ícones e containers de conteúdo',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MenuScreen(),
      ),
    );

    expect(find.byIcon(Icons.agriculture), findsOneWidget);
    expect(find.byIcon(Icons.info), findsOneWidget);
    expect(find.byIcon(Icons.warning), findsOneWidget);

    // Verifica que existem ao menos 3 containers decorados
    final containers = find.byWidgetPredicate((widget) =>
        widget is Container &&
        widget.decoration is BoxDecoration &&
        (widget as Container).child is Column);
    expect(containers, findsWidgets);
  });
}
