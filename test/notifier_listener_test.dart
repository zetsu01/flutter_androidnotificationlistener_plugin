import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notifier_listener/notifier_listener.dart';

void main() {
  const MethodChannel channel = MethodChannel('notifier_listener');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await NotifierListener.platformVersion, '42');
  });
}
