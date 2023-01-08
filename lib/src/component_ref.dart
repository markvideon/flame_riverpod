import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A wrapper around [WidgetRef]. Methods that correspond to interactions with
/// the widget tree, such as [WidgetRef.watch] are not exposed.
class ComponentRef {
  ComponentRef(this.widgetRef);
  WidgetRef widgetRef;

  BuildContext get context => widgetRef.context;

  bool exists(ProviderBase<Object?> provider) {
    return widgetRef.exists(provider);
  }

  /// A subscription that should be closed at the appropriate point in the
  /// lifecycle of the listening component.
  ProviderSubscription<T> listenManual<T>(
    ProviderListenable<T> provider,
    void Function(T?, T) onChange, {
    void Function(Object error, StackTrace stackTrace)? onError,
    bool fireImmediately = true,
  }) {
    return widgetRef.listenManual<T>(provider, onChange,
        onError: onError, fireImmediately: fireImmediately);
  }

  T read<T>(Provider<T> provider) {
    return widgetRef.read(provider);
  }

  T refresh<T>(Refreshable<T> provider) {
    return widgetRef.refresh(provider);
  }

  void invalidate(ProviderOrFamily provider) {
    widgetRef.invalidate(provider);
  }
}
