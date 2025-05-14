import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_agro/screens/criar_conta.dart';


void main() {
  testWidgets('Deve mostrar erros ao tentar criar conta com campos vazios',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CriarConta(),
        routes: {
          '/': (context) => const Scaffold(body: Text('Login')),
        },
      ),
    );

    await tester.tap(find.text('Criar Conta'));
    await tester.pump();

    expect(find.text('Digite seu nome'), findsOneWidget);
    expect(find.text('Digite seu email'), findsOneWidget);
    expect(find.text('A senha deve ter pelo menos 6 caracteres'),
        findsOneWidget);
    expect(find.text('As senhas não coincidem'), findsOneWidget);
    expect(find.text('Digite seu telefone'), findsOneWidget);
  });

  testWidgets('Deve mostrar erro se termos de uso não forem aceitos',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CriarConta(),
        routes: {
          '/': (context) => const Scaffold(body: Text('Login')),
        },
      ),
    );

    // Preenche campos válidos
    await tester.enterText(find.byType(TextFormField).at(0), 'Felipe');
    await tester.enterText(find.byType(TextFormField).at(1), 'felipe@email.com');
    await tester.enterText(find.byType(TextFormField).at(2), '123456');
    await tester.enterText(find.byType(TextFormField).at(3), '123456');
    await tester.enterText(find.byType(TextFormField).at(4), '11999999999');

    // NÃO marca os termos
    await tester.tap(find.text('Criar Conta'));
    await tester.pump();

    expect(find.text('Você precisa aceitar os Termos de Uso'), findsOneWidget);
  });

  testWidgets('Deve aceitar cadastro com dados válidos e termos aceitos',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CriarConta(),
        routes: {
          '/': (context) => const Scaffold(body: Text('Login')),
        },
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'Felipe');
    await tester.enterText(find.byType(TextFormField).at(1), 'felipe@email.com');
    await tester.enterText(find.byType(TextFormField).at(2), '123456');
    await tester.enterText(find.byType(TextFormField).at(3), '123456');
    await tester.enterText(find.byType(TextFormField).at(4), '11999999999');

    // Marca o checkbox dos termos
    await tester.tap(find.byType(CheckboxListTile));
    await tester.pump();

    await tester.tap(find.text('Criar Conta'));
    await tester.pump();

    // Aqui você poderia validar que a navegação foi feita após 2 segundos,
    // mas sem mocks não conseguimos simular `controller.enviarDados()`
    expect(find.text('Sucesso ao cadastrar!'), findsOneWidget);
  });
}
