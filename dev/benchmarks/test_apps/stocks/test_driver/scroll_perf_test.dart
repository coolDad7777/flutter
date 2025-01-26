// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart' hide TypeMatcher, isInstanceOf;
void main() {
  group('scrolling performance test', () {
    enableFlutterDriverExtension();

    test('measure', () async {
      final FlutterDriver driver = await FlutterDriver.connect();
      final Timeline timeline = await driver.traceAction(() async {
        // Find the scrollable stock list
        final SerializableFinder stockList = find.byValueKey('stock-list');
        expect(stockList, isNotNull);

        // Scroll down
        for (int i = 0; i < 5; i++) {
          await driver.traceAction(() async {
            await driver.scroll(
                stockList, 0.0, -300.0, const Duration(milliseconds: 300));
            await Future<void>.delayed(const Duration(milliseconds: 500));
          });
        }

        // Scroll up
        for (int i = 0; i < 5; i++) {
          await driver.traceAction(() async {
            await driver.scroll(
                stockList, 0.0, 300.0, const Duration(milliseconds: 300));
            await Future<void>.delayed(const Duration(milliseconds: 500));
          });
        }
      });

      final TimelineSummary summary = TimelineSummary.summarize(timeline);
      await summary.writeTimelineToFile('stocks_scroll_perf', pretty: true);
      final List<int> frameTimes = <int>[];
      final Stopwatch stopwatch = Stopwatch()..start();

      // Find the scrollable stock list
      final SerializableFinder stockList = find.byValueKey('stock-list');
      expect(stockList, isNotNull);

      // Scroll down
      for (int i = 0; i < 5; i++) {
        await driver.traceAction(() async {
          await driver.scroll(
              stockList, 0.0, -300.0, const Duration(milliseconds: 300));
          await Future<void>.delayed(const Duration(milliseconds: 500));
        });
      }

      // Scroll up
      for (int i = 0; i < 5; i++) {
        await driver.traceAction(() async {
          await driver.scroll(
              stockList, 0.0, 300.0, const Duration(milliseconds: 300));
          await Future<void>.delayed(const Duration(milliseconds: 500));
        });
      }

      stopwatch.stop();
            frameTimes.add(stopwatch.elapsedMilliseconds);
          });
        });
      }
