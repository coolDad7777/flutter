// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/main.dart' as app;
import 'package:integration_test/integration_test.dart';

/// The following test is used as a simple smoke test for verifying Flutter
/// Framework and Flutter Web Engine integration.
void main() {
  group('Hello World App', () {
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('title is correct', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('title')), findsOneWidget);
    expect(find.text('Hello, world!'), findsOneWidget);
  });

  testWidgets('enable accessibility', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // TODO: Implement accessibility test using WidgetTester.
  });
}
