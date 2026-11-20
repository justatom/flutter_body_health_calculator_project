import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_body_health_calculator_project/app_theme.dart';
import 'package:flutter_body_health_calculator_project/main.dart';
import 'package:flutter_body_health_calculator_project/views/about_ui.dart';
import 'package:flutter_body_health_calculator_project/views/home_ui.dart';
import 'package:flutter_body_health_calculator_project/views/splash_screen_ui.dart';

/// iPhone 15 Pro Max: 1290 x 2796 px @3x = 430 x 932 logical pixels.
void useIPhone15ProMax(WidgetTester tester) {
  tester.view.physicalSize = const Size(1290, 2796);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);
}

/// Pumps [widget] and waits until the bundled Kanit fonts have loaded.
Future<void> pumpWithFonts(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(widget);
  await tester.runAsync(() => GoogleFonts.pendingFonts());
  await tester.pump();
}

Future<void> openHome(WidgetTester tester) async {
  useIPhone15ProMax(tester);
  await pumpWithFonts(
    tester,
    MaterialApp(theme: AppTheme.light, home: const HomeUI()),
  );
}

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('Splash shows first, then opens Home on the About tab',
      (tester) async {
    useIPhone15ProMax(tester);
    await pumpWithFonts(tester, const BodyHealthApp());
    expect(find.byType(SplashScreenUI), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.byType(HomeUI), findsOneWidget);
    expect(find.byType(AboutUI), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('BMI tab calculates 70 kg / 175 cm', (tester) async {
    await openHome(tester);
    await tester.tap(find.text('BMI'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), '70');
    await tester.enterText(fields.at(1), '175');
    await tester.tap(find.text('คำนวณ BMI'));
    await tester.pumpAndSettle();

    expect(find.text('22.86'), findsOneWidget);
    expect(find.text('น้ำหนักสมส่วน'), findsOneWidget);

    await tester.tap(find.text('ล้างข้อมูล').first);
    await tester.pumpAndSettle();
    expect(find.text('0.00'), findsWidgets);
  });

  testWidgets('BMR tab calculates for a woman', (tester) async {
    await openHome(tester);
    await tester.tap(find.text('BMR').last);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('หญิง'));
    // Hidden tabs in the IndexedStack are offstage, so only BMR's fields match.
    final fields = find.byType(TextField);
    expect(fields, findsNWidgets(3));
    await tester.enterText(fields.at(0), '60');
    await tester.enterText(fields.at(1), '165');
    await tester.enterText(fields.at(2), '30');
    await tester.ensureVisible(find.text('คำนวณ BMR'));
    await tester.tap(find.text('คำนวณ BMR'));
    await tester.pumpAndSettle();

    expect(find.text('1383.68'), findsOneWidget);
  });

  testWidgets('Empty input shows a warning', (tester) async {
    await openHome(tester);
    await tester.tap(find.text('BMI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('คำนวณ BMI'));
    await tester.pump();
    expect(find.text('กรุณากรอกน้ำหนักและส่วนสูงให้ถูกต้อง'), findsOneWidget);
  });
}
