import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_agro/screens/nova_senha.dart';


void main() {
  testWidgets('Deve exibir mensagens de erro para campos vazios',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NovaSenhaPage(),
        routes: {
          '/': (context) => const Scaffold(body: Text('Login')),
        },
      ),
    );

    // Pressiona o botão "Confirmar" sem preencher os campos
    await tester.tap(find.text('Confirmar'));
    await tester.pump();

    expect(find.text('Informe o e-mail'), findsOneWidget);
    expect(find.text('Informe o token'), findsOneWidget);
    expect(find.text('Senha muito curta'), findsOneWidget);
  });

  testWidgets('Deve validar que os campos aceitam dados corretos',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NovaSenhaPage(),
        routes: {
          '/': (context) => const Scaffold(body: Text('Login')),
        },
      ),
    );

    // Preenche todos os campos com dados válidos
    await tester.enterText(find.byType(TextFormField).at(0), 'teste@email.com');
    await tester.enterText(find.byType(TextFormField).at(1), '123456');
    await tester.enterText(find.byType(TextFormField).at(2), 'novaSenha');

    await tester.tap(find.text('Confirmar'));
    await tester.pump();

    // Nesse caso, não aparecerá erro porque tudo foi preenchido corretamente
    expect(find.text('Informe o e-mail'), findsNothing);
    expect(find.text('Informe o token'), findsNothing);
    expect(find.text('Senha muito curta'), findsNothing);
  });
}
