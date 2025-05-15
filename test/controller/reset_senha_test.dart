import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_agro/screens/reset_senha.dart'; 

void main() {
  testWidgets('Deve renderizar todos os elementos visuais da tela ResetSenha',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ResetSenha(),
      ),
    );

    // Verifica presença do logo
    expect(find.byType(Image), findsOneWidget);

    // Verifica textos principais
    expect(find.text('AgroSmart'), findsOneWidget);
    expect(find.text('Reset Sua Senha'), findsOneWidget);

    // Verifica campos de senha
    expect(find.text('Informe Sua Nova Senha'), findsOneWidget);
    expect(find.text('Confirme a Senha'), findsOneWidget);

    // Verifica botão
    expect(find.text('Resetar'), findsOneWidget);
  });
}
