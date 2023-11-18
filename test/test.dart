import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void empty() {

}

void main() {
  test('Test listeners', () {
    ValueNotifier<bool> ayo = ValueNotifier(false);
    expect(ayo.hasListeners, false);
    ayo.addListener(empty);
    expect(ayo.hasListeners, true);
    ayo.removeListener(empty);
    expect(ayo.hasListeners, false);
    ayo.dispose();
  });
}