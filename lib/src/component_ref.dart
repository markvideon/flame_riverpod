import 'package:flame/game.dart' show Game;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin HasComponentRef on Game {
  late ComponentRef ref;
}

/// A wrapper around [WidgetRef]. Methods that correspond to interactions with
/// the widget tree, such as [WidgetRef.watch] are not exposed.
class ComponentRef {
  ComponentRef(this.ref);
  WidgetRef ref;

  BuildContext get context => ref.context;

  bool exists(ProviderBase<Object?> provider) {
    return ref.exists(provider);
  }

  /// A subscription that should be closed at the appropriate point in the
  /// lifecycle of the listening component.
  ProviderSubscription<T> listenManual<T>(
    ProviderListenable<T> provider,
    void Function(T?, T) onChange, {
    void Function(Object error, StackTrace stackTrace)? onError,
    bool fireImmediately = true,
  }) {
    return ref.listenManual<T>(provider, onChange,
        onError: onError, fireImmediately: fireImmediately);
  }

  T read<T>(Provider<T> provider) {
    return ref.read(provider);
  }

  T refresh<T>(Refreshable<T> provider) {
    return ref.refresh(provider);
  }

  void invalidate(ProviderOrFamily provider) {
    ref.invalidate(provider);
  }
}
