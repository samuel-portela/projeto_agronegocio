import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_agro/screens/recuperar_conta.dart'; 

void main() {
  testWidgets('Deve mostrar erros se os campos estiverem vazios',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RecuperarConta(),
        routes: {
          '/enviar-nova-senha': (context) =>
              const Scaffold(body: Text('Nova senha')),
        },
      ),
    );

    // Tenta pressionar o botão sem preencher os campos
    final button = find.text('Recuperar Conta');
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pump(); // Atualiza o estado após o tap

    expect(find.text('Informe o e-mail'), findsOneWidget);
    expect(find.text('Informe o telefone'), findsOneWidget);
  });

  testWidgets('Deve aceitar dados válidos e chamar o método',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RecuperarConta(),
        routes: {
          '/enviar-nova-senha': (context) =>
              const Scaffold(body: Text('Nova senha')),
        },
      ),
    );

    // Preenche os campos com dados válidos
    await tester.enterText(
        find.byType(TextFormField).at(0), 'teste@email.com');
    await tester.enterText(find.byType(TextFormField).at(1), '11999999999');

    await tester.tap(find.text('Recuperar Conta'));
    await tester.pump(); // Atualiza

    // Neste ponto, como não temos lógica real de envio, apenas verificamos que não deu erro de validação
    expect(find.text('Informe o e-mail'), findsNothing);
    expect(find.text('Informe o telefone'), findsNothing);
  });
}
