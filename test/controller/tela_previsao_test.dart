import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_agro/screens/previsao_tempo.dart';

void main() {
  testWidgets('Deve renderizar campo de busca e botão de pesquisa', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: TelaPrevisao()));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.text('Digite o nome da cidade'), findsOneWidget);
  });

  testWidgets('Deve permitir digitar no campo de cidade', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: TelaPrevisao()));

    await tester.enterText(find.byType(TextField), 'São Paulo');
    expect(find.text('São Paulo'), findsOneWidget);
  });

  testWidgets('Deve exibir snackBar se cidade não for encontrada', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: TelaPrevisao()));

    await tester.enterText(find.byType(TextField), '');
    await tester.tap(find.byIcon(Icons.search));

    // Aguarda o SnackBar aparecer (pode precisar de pumpAndSettle dependendo do código)
    await tester.pumpAndSettle();

    // Verifica se a SnackBar foi exibida
    expect(find.text('Cidade não encontrada'), findsOneWidget);
  });
}
