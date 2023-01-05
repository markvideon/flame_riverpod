import 'package:flame/game.dart';
import 'package:flame_riverpod/src/game_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'riverpod_aware_game.dart';

class RiverpodGameWidget extends ConsumerStatefulWidget {
  const RiverpodGameWidget.readFromProvider({super.key}) : game = null;
  const RiverpodGameWidget.initialiseWithGame({super.key, required this.game});

  final RiverpodAwareGameMixin? game;

  @override
  ConsumerState<RiverpodGameWidget> createState() => _RiverpodGameWidgetState();
}

class _RiverpodGameWidgetState extends ConsumerState<RiverpodGameWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.game is RiverpodAwareGameMixin) {
        ref.read(riverpodAwareGameProvider.notifier).set(widget.game!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(riverpodAwareGameProvider);

    if (game is! Game) {
      return Container();
    }

    return GameWidget(game: game!);
  }
}