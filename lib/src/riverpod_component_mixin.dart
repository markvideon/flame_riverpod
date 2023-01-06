import 'package:flame/components.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'component_ref.dart';

mixin RiverpodComponentMixin on Component {
  late ComponentRef ref;
  List<ProviderSubscription> _subscriptions = [];

  listen<T>(ProviderListenable<T> provider,
    void Function(T?, T) onChange, {
    void Function(Object error, StackTrace stackTrace)? onError
  }) {
    _subscriptions.add(
      ref.listenManual(provider, (p0, p1) {
        onChange(p0, p1);
      }, onError: onError)
    );
  }

  @override
  void onRemove() {
    for (var listener in _subscriptions) {
      listener.close();
    }
    super.onRemove();
  }
}
