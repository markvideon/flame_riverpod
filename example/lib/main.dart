import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countingStreamProvider = StreamProvider<int>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (inc) => inc);
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
      home: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Expanded(child: FlutterCountingComponent()),
        Expanded(
            child: RiverpodGameWidget.initialiseWithGame(
                game: RefExampleGame(ref)))
      ]),
    );
  }
}

class FlutterCountingComponent extends ConsumerWidget {
  const FlutterCountingComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle =
        Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white);

    final stream = ref.watch(countingStreamProvider);
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Text('Flutter', style: textStyle),
          stream.when(
              data: (value) => Text('$value', style: textStyle),
              error: (error, stackTrace) => Text('$error', style: textStyle),
              loading: () => Text('Loading...', style: textStyle))
        ],
      ),
    );
  }
}

class RefExampleGame extends RiverpodAwareFlameGame {
  RefExampleGame(super.ref);

  @override
  onLoad() async {
    await super.onLoad();
    add(TextComponent(text: 'Flame'));
    add(RiverpodAwareTextComponent(ref));
  }
}

class RiverpodAwareTextComponent extends PositionComponent {
  RiverpodAwareTextComponent(this.ref);

  /// ComponentRef is a wrapper around WidgetRef and exposes
  /// a subset of its API.
  ///
  /// It does not expose [ref.watch] from Riverpod as it is
  /// not applicable to our use case!
  ComponentRef ref;

  /// Remember to close your subscriptions as appropriate.
  late ProviderSubscription<AsyncValue<int>> subscription;
  late TextComponent textComponent;
  int currentValue = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(textComponent = TextComponent(position: position + Vector2(0, 27)));

    subscription = ref.listenManual(countingStreamProvider, (p0, p1) {
      if (p1.hasValue) {
        currentValue = p1.value!;
        textComponent.text = '$currentValue';
      }
    });
  }

  @override
  void onRemove() {
    subscription.close();
    super.onRemove();
  }
}
