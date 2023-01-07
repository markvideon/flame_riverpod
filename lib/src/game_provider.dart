import 'package:flame_riverpod/src/riverpod_aware_game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Simple provider that returns a [RiverpodAwareGame] instance.
final riverpodAwareGameProvider =
    StateNotifierProvider<RiverpodAwareGameNotifier, HasComponentReference?>(
        (ref) {
  return RiverpodAwareGameNotifier();
});

/// Simple [StateNotifier] that holds the current [RiverpodAwareGame] instance.
class RiverpodAwareGameNotifier extends StateNotifier<HasComponentReference?> {
  RiverpodAwareGameNotifier() : super(null);

  set(HasComponentReference candidate) {
    state = candidate;
  }
}
