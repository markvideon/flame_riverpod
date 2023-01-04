import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin RiverpodAwareGameMixin on Game {
  late WidgetRef ref;
}

abstract class RiverpodAwareGame extends Game with RiverpodAwareGameMixin {
  RiverpodAwareGame(WidgetRef ref) {
    this.ref = ref;
  }
}

abstract class RiverpodAwareFlameGame extends FlameGame with RiverpodAwareGameMixin {
  RiverpodAwareFlameGame(WidgetRef ref) {
    this.ref = ref;
  }
}