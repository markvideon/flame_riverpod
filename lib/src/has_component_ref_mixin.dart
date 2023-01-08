import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'component_ref.dart';

mixin HasComponentRef on Component {
  ComponentRef get ref => _reference ?? _findComponentRef();
  static ComponentRef? _reference;
  static set widgetRef(WidgetRef value) => _reference = ComponentRef(value);

  List<ProviderSubscription> _subscriptions = [];

  @override
  onLoad() async {
    _reference ??= _findComponentRef();
    await super.onLoad();
  }

  ComponentRef _findComponentRef<T>() {
    final flameGameParent = super.findParent<FlameGame>();
    return (flameGameParent as HasComponentRef)._findComponentRef();
  }

  listen<T>(ProviderListenable<T> provider, void Function(T?, T) onChange,
      {void Function(Object error, StackTrace stackTrace)? onError}) {
    _subscriptions.add(ref.listenManual(provider, (p0, p1) {
      onChange(p0, p1);
    }, onError: onError));
  }

  @override
  void onRemove() {
    for (var listener in _subscriptions) {
      listener.close();
    }
    super.onRemove();
  }
}
