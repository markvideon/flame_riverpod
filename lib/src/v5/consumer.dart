import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/src/v5/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Two outstanding problems with the same root cause:
// Context may not be available when methods are invoked.:
// - When listen, watch are called, subscriptions may not be
//   registered with ProviderContainer
// - When watch, read etc are called, a non-null result can not be returned
class NewComponentRef implements WidgetRef {
  NewComponentRef(this.game);

  /// Reference to the game this component is on.
  RiverpodGameMixin game;

  @override
  BuildContext get context => game.buildContext!;

  RiverpodAwareGameWidgetState? get _container {
    return game.key?.currentState;
  }

  @override
  Res watch<Res>(ProviderListenable<Res> target) {
    return _container!.watch(target);
  }

  @override
  void listen<T>(
    ProviderListenable<T> provider,
    void Function(T? previous, T value) listener, {
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    _container!.listen(provider, listener, onError: onError);
  }

  @override
  bool exists(ProviderBase<Object?> provider) {
    return _container!.exists(provider);
  }

  @override
  T read<T>(ProviderListenable<T> provider) {
    return _container!.read(provider);
  }

  @override
  State refresh<State>(Refreshable<State> provider) {
    return _container!.refresh(provider);
  }

  @override
  void invalidate(ProviderOrFamily provider) {
    _container!.invalidate(provider);
  }

  @override
  ProviderSubscription<T> listenManual<T>(
    ProviderListenable<T> provider,
    void Function(T? previous, T next) listener, {
    void Function(Object error, StackTrace stackTrace)? onError,
    bool fireImmediately = false,
  }) {
    return _container!.listenManual(
      provider,
      listener,
      onError: onError,
      fireImmediately: fireImmediately,
    );
  }
}

mixin RiverpodComponentMixin on Component {
  late NewComponentRef ref;

  @override
  void onLoad() {
    ref = NewComponentRef(findGame()! as RiverpodGameMixin);
    super.onLoad();
  }

  void onGameAttach(Function() cb) {
    (findGame()! as RiverpodGameMixin)._onAttachCallbacks.add(cb);
  }

  /// Adds a callback method to be invoked in the build method of
  /// [RiverpodAwareGameWidgetState].
  ///
  /// The `fireAsap` parameter is used to determine whether the build method of
  /// [RiverpodAwareGameWidgetState] should be invoked immediately after
  /// `cb` has been added to the list of callbacks executed inside the build
  /// method of [RiverpodAwareGameWidgetState].
  void addToGameWidgetBuild(Function() cb, {bool fireAsap = true}) {
    final game = findGame()! as RiverpodGameMixin;
    debugPrint(
        'onGameWidgetBuild, callback length: ${game._onBuildCallbacks.length}');
    game._onBuildCallbacks.add(cb);

    if (game.isMounted && fireAsap) {
      game.key!.currentState!.forceBuild();
    }

    debugPrint(
        'onGameWidgetBuild, callback length: ${game._onBuildCallbacks.length}');
  }

  void removeFromGameWidgetBuild(Function() cb) {
    (findGame()! as RiverpodGameMixin)._onBuildCallbacks.remove(cb);
  }

  void onGameDetach(Function() cb) {
    (findGame()! as RiverpodGameMixin)._onDetachCallbacks.add(cb);
  }
}

mixin RiverpodGameMixin on FlameGame {
  GlobalKey<RiverpodAwareGameWidgetState>? key;

  final List<Function()> _onAttachCallbacks = [];
  final List<Function()> _onBuildCallbacks = [];
  final List<Function()> _onDetachCallbacks = [];

  @override
  void onAttach() {
    super.onAttach();
    for (final callback in _onAttachCallbacks) {
      callback.call();
    }
  }

  @override
  void onDispose() {
    // TODO: implement onDispose
    super.onDispose();
  }

  void onBuild() {
    debugPrint(
        'RiverpodGameMixin onBuild. Callbacks: ${_onBuildCallbacks.length}');
    for (final callback in _onBuildCallbacks) {
      callback.call();
    }
  }

  @override
  void onDetach() {
    for (final callback in _onDetachCallbacks) {
      callback.call();
    }
    super.onDetach();
  }
}
