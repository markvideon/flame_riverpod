import 'package:flame/game.dart';
import 'package:flame_riverpod/src/game_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'riverpod_aware_game.dart';

class RiverpodGameWidget extends ConsumerStatefulWidget {
  const RiverpodGameWidget.readFromProvider({super.key}) : uninitialisedGame = null;
  const RiverpodGameWidget.initialiseWithGame({super.key, required this.uninitialisedGame});

  final RiverpodAwareGameMixin Function(WidgetRef ref)? uninitialisedGame;

  @override
  ConsumerState<RiverpodGameWidget> createState() => _RiverpodGameWidgetState();
}

class _RiverpodGameWidgetState extends ConsumerState<RiverpodGameWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.uninitialisedGame is RiverpodAwareGameMixin Function(WidgetRef ref)) {
        ref.read(riverpodAwareGameProvider.notifier).set(widget.uninitialisedGame!(ref));
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
