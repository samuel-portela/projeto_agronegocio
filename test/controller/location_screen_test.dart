import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_agro/screens/location_screen.dart'; // Ajuste o caminho

void main() {
  testWidgets('Deve renderizar texto e switch de localização',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LocationScreen(),
      ),
    );

    expect(find.text('Ativar localização'), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
  });

  testWidgets('Switch deve alterar o estado de isLocationEnabled',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LocationScreen(),
      ),
    );

    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);

    // Verifica o estado inicial (true)
    final Switch switchWidget =
        tester.widget<Switch>(switchFinder);
    expect(switchWidget.value, isTrue);

    // Toca para mudar
    await tester.tap(switchFinder);
    await tester.pump();

    // Testa se o estado mudou (agora deve ser false)
    final Switch newSwitchWidget =
        tester.widget<Switch>(switchFinder);
    expect(newSwitchWidget.value, isFalse);
  });
}
