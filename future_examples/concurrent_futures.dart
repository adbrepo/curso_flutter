import 'dart:async';

Future<String> async1() async {
  await Future.delayed(const Duration(seconds: 1));
  print('async1 finished');
  return 'Message from async1';
}

Future<int> async2() async {
  await Future.delayed(const Duration(seconds: 2));
  print('async2 finished');
  return 20;
}

Future<bool> async3() async {
  await Future.delayed(const Duration(seconds: 3));
  print('async3 finished');
  return true;
}

void main() async {
  print('Testing sequential code');
  final stopwatch = Stopwatch()..start();

  final result1 = await async1();
  print('Type: ${result1.runtimeType} - Value: $result1');
  final result2 = await async2();
  print('Type: ${result2.runtimeType} - Value: $result2');
  final result3 = await async3();
  print('Type: ${result3.runtimeType} - Value: $result3');

  print('Time elapsed: ${stopwatch.elapsed}');
  stopwatch.stop();
  stopwatch.reset();

  print('\nTesting parallel code');
  stopwatch.start();
  final results = await Future.wait(
    [async1(), async2(), async3()],
  );
  for (final result in results) {
    print('Type: ${result.runtimeType} - Value: $result');
  }

  print('Time elapsed: ${stopwatch.elapsed}');
  stopwatch.stop();
}
