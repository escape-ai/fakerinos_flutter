import '../lib/src/logic/counter.dart';
// import 'package:/counter.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('Counter value should be increased', () {
    final counter = GameCounter();

    counter.increase(1);

    expect(counter.value, 1);
  });

  test('Counter value should be increased, non-zero initial value', () {
    final counter = GameCounter(initialValue: 3);

    counter.increase(1);

    expect(counter.value, 4);
  });

  test('Counter value should be increased, non-zero initial value, increase value > 1', () {
    final counter = GameCounter(initialValue: 3);

    counter.increase(3);

    expect(counter.value, 6);
  });

  test('Counter value should be decreased, non-zero initial value', () {
    final counter = GameCounter(initialValue: 4);

    counter.decrease(1);

    expect(counter.value, 3);
  });

  test('Minimum score after decreasing should be 0', () {
    final counter = GameCounter(initialValue: 1);

    counter.decrease(2);

    expect(counter.value, 0);
  });

  test('Cannot increase after timing out', () {
    final counter = GameCounter(initialValue: 2); 
    counter.start(); 
    print("Sleeping for 2 seconds");
    counter.timer = true; 
    sleep(const Duration(seconds:2));

    counter.increase(2);
    expect(counter.value, 2);
  
  });

  test('Cannot decrease after timing out', () {
    final counter = GameCounter(initialValue: 2, gameDuration: 2); 
    counter.start(); 
    print("Sleeping for 2 seconds");
    counter.timer = true; 
    sleep(const Duration(seconds:2));

    counter.decrease(2);
    expect(counter.value, 2);
  
  });
}