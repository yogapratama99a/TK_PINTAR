// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:tk_pertiwi/screens/out/splash.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/main.dart'; // Menggunakan MyApp dari main.dart

void main() {
  testWidgets('SplashScreen muncul dan berpindah ke /choice', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Pastikan teks "Teka.In" muncul di SplashScreen
    expect(find.text('Teka.In'), findsOneWidget);

    // Tunggu selama 3 detik (sesuai timer di SplashScreen)
    await tester.pump(const Duration(seconds: 3));

    // Pastikan berpindah ke halaman /choice setelah SplashScreen
    expect(find.text('Teka.In'), findsNothing); // SplashScreen seharusnya hilang
    expect(find.byType(Scaffold), findsOneWidget); // Pastikan masih ada tampilan setelah navigasi
  });
}


