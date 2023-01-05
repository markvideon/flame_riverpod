import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'component_ref.dart';

mixin RiverpodAwareGameMixin on Game {
  late ComponentRef ref;
}

abstract class RiverpodAwareGame extends Game with RiverpodAwareGameMixin {
  RiverpodAwareGame(WidgetRef ref) {
    this.ref = ComponentRef(ref);
  }
}

abstract class RiverpodAwareFlameGame extends FlameGame with RiverpodAwareGameMixin {
  RiverpodAwareFlameGame(WidgetRef ref) {
    this.ref = ComponentRef(ref);
  }
}