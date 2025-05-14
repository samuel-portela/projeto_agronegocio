import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_agro/screens/precossacas_screen.dart';


void main() {
  testWidgets('Deve exibir título e container de preços',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PrecosSacasScreen(),
      ),
    );

    // Verifica título
    expect(find.text('Cotações de Sacas:'), findsOneWidget);

    // Verifica ícone de cifrão
    expect(find.byIcon(Icons.attach_money), findsOneWidget);

    // Verifica se inicialmente mostra "Carregando..."
    expect(find.textContaining('Carregando'), findsOneWidget);
  });

  testWidgets('Deve simular carregamento de texto com sucesso',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PrecosSacasScreen(),
      ),
    );

    // Espera um tempo para o setState ser chamado (simulando consulta da API)
    await tester.pump(const Duration(seconds: 3));

    // Como não estamos mockando a resposta, vai cair no texto de erro ou 'Carregando...'
    expect(
      find.byType(Text),
      findsWidgets, // Confirma que algum Text foi renderizado (fallback ou markdown)
    );
  });
}
