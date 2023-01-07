import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'component_ref.dart';

/// Simple provider that returns a Riverpod-Aware Game instance.
final riverpodAwareGameProvider =
    StateNotifierProvider<RiverpodAwareGameNotifier, HasComponentRef?>(
        (ref) {
  return RiverpodAwareGameNotifier();
});

/// Simple [StateNotifier] that holds the current [RiverpodAwareGame] instance.
class RiverpodAwareGameNotifier extends StateNotifier<HasComponentRef?> {
  RiverpodAwareGameNotifier() : super(null);

  set(HasComponentRef candidate) {
    state = candidate;
  }
}
