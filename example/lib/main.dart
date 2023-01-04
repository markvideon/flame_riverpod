import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myStreamProvider = StreamProvider<int>((ref) => Stream.periodic(Duration(seconds: 1), (inc) => inc));
final myIntProvider = Provider((ref) => 7);

void main() {
  runApp(const MyApp());
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: RiverpodGameWidget.initialiseWithGame(game: RefExampleGame(ref)),
    );
  }
}

class RefExampleGame extends RiverpodAwareFlameGame {
  RefExampleGame(super.ref);

  @override
  onLoad() async {
    await super.onLoad();
  }
}