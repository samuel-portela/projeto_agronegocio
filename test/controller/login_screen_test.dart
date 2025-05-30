import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_agro/screens/login_screen.dart';


void main() {
  testWidgets('Deve exibir erro se os campos estiverem vazios',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(),
        routes: {
          '/menuScreen': (context) => Scaffold(body: Text('Menu')),
        },
      ),
    );

    // Tenta pressionar o botão de login sem preencher os campos
    final loginButton = find.text('Login');
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pump(); // Atualiza a tela

    expect(find.text('Digite seu email'), findsOneWidget);
    expect(find.text('Digite sua senha'), findsOneWidget);
  });

  testWidgets('Deve validar email e senha inválidos',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LoginScreen()),
    );

    // Preenche campos com dados inválidos
    await tester.enterText(find.byType(TextFormField).at(0), 'email_invalido');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Email inválido'), findsOneWidget);
    expect(find.text('Senha muito curta'), findsOneWidget);
  });
}
