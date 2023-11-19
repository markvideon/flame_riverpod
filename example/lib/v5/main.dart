import 'dart:async';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countingStreamProvider = StreamProvider<int>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (inc) => inc);
});

/// Simple provider that returns a [FlameGame] instance.
final riverpodAwareGameProvider =
    StateNotifierProvider<RiverpodAwareGameNotifier, FlameGame?>((ref) {
  return RiverpodAwareGameNotifier();
});

/// Simple [StateNotifier] that holds the current [FlameGame] instance.
class RiverpodAwareGameNotifier extends StateNotifier<FlameGame?> {
  RiverpodAwareGameNotifier() : super(null);

  void set(FlameGame candidate) {
    state = candidate;
  }
}

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final gameInstance = RefExampleGame();
final GlobalKey<RiverpodAwareGameWidgetState> gameWidgetKey =
    GlobalKey<RiverpodAwareGameWidgetState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(child: FlutterCountingComponent()),
          Expanded(
            child: RiverpodAwareGameWidget(
              key: gameWidgetKey,
              game: gameInstance,
            ),
          )
        ],
      ),
    );
  }
}

class FlutterCountingComponent extends ConsumerWidget {
  const FlutterCountingComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(color: Colors.white);

    final stream = ref.watch(countingStreamProvider);
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Text('Flutter', style: textStyle),
          stream.when(
            data: (value) => Text('$value', style: textStyle),
            error: (error, stackTrace) => Text('$error', style: textStyle),
            loading: () => Text('Loading...', style: textStyle),
          )
        ],
      ),
    );
  }
}

class RefExampleGame extends FlameGame with RiverpodGameMixin {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(TextComponent(text: 'Flame'));
    add(RiverpodAwareTextComponent());
  }
}

class RiverpodAwareTextComponent extends PositionComponent
    with RiverpodComponentMixin {
  late TextComponent textComponent;
  int currentValue = 0;
  ComponentKey key = ComponentKey.unique();

  @override
  void onLoad() {
    // TODO: implement onLoad
    super.onLoad();

  }
  void listenToCount() {
    ref.listen(countingStreamProvider, (p0, p1) {
      if (p1.hasValue) {
        currentValue = p1.value!;
        textComponent.text = '$currentValue';
      }
    });
  }

  /// [onMount] should be used over [onLoad] to initialize subscriptions,
  /// cancellation is handled for the user inside [onRemove],
  /// which is only called if the [Component] was mounted.

  @override
  void onMount() {
    addToGameWidgetBuild(listenToCount);
    super.onMount();
    add(textComponent = TextComponent(position: position + Vector2(0, 27)));
  }
}
