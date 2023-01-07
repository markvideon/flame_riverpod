import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'component_ref.dart';

mixin HasComponentReference on Game {
  late ComponentRef ref;
}

abstract class RiverpodAwareGame extends Game with HasComponentReference {
  RiverpodAwareGame(WidgetRef ref) {
    this.ref = ComponentRef(ref);
  }
}

abstract class RiverpodAwareFlameGame extends FlameGame
    with HasComponentReference {
  RiverpodAwareFlameGame(WidgetRef ref) {
    this.ref = ComponentRef(ref);
  }
}
