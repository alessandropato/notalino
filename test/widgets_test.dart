import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notalino/app/theme/app_theme.dart';
import 'package:notalino/presentation/widgets/app_buttons.dart';
import 'package:notalino/presentation/widgets/status_badge.dart';

/// Widget test dei componenti chiave del design system (SRD §13).
Widget _wrap(Widget child) => MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  testWidgets('StatusBadge mostra l\'etichetta', (WidgetTester tester) async {
    await tester.pumpWidget(_wrap(
      const StatusBadge(label: 'Completata', tone: StatusTone.success),
    ));
    expect(find.text('Completata'), findsOneWidget);
  });

  testWidgets('PrimaryButton invoca onPressed al tap',
      (WidgetTester tester) async {
    int taps = 0;
    await tester.pumpWidget(_wrap(
      PrimaryButton(label: 'Salva', onPressed: () => taps++),
    ));
    await tester.tap(find.text('Salva'));
    await tester.pump();
    expect(taps, 1);
  });

  testWidgets('PrimaryButton disabilitato (onPressed null) non risponde',
      (WidgetTester tester) async {
    await tester.pumpWidget(_wrap(
      const PrimaryButton(label: 'Disabilitato', onPressed: null),
    ));
    await tester.tap(find.text('Disabilitato'));
    await tester.pump();
    // Nessuna eccezione: il bottone è inerte ma renderizzato.
    expect(find.text('Disabilitato'), findsOneWidget);
  });

  testWidgets('PrimaryButton in loading mostra lo spinner e non il testo',
      (WidgetTester tester) async {
    await tester.pumpWidget(_wrap(
      PrimaryButton(label: 'Carica', loading: true, onPressed: () {}),
    ));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Carica'), findsNothing);
  });
}
