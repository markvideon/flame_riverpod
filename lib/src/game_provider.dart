import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Simple provider that returns a [FlameGame] instance.
final riverpodAwareGameProvider =
    StateNotifierProvider<RiverpodAwareGameNotifier, FlameGame?>((ref) {
  return RiverpodAwareGameNotifier();
});

/// Simple [StateNotifier] that holds the current [FlameGame] instance.
class RiverpodAwareGameNotifier extends StateNotifier<FlameGame?> {
  RiverpodAwareGameNotifier() : super(null);

  set(FlameGame candidate) {
    state = candidate;
  }
}
