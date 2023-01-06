Helpers for using Riverpod in conjunction with Flame - to share state from
the game into other parts of your application, or from other parts of your
application into your game.

## Getting started

Check out the example package to see a FlameGame with a custom Component being updated alongside a comparable Flutter 
widget. Both depend on a StreamProvider.

## Usage

RiverpodGameWidget is a simple ConsumerStatefulWidget wrapper around a GameWidget. 

`ComponentRef` should be passed from your RiverpodAwareGame to any Components interested in updates from a Provider. 
It exposes a subset of the functionality users of Riverpod will be familiar with - this is because Components are *not* 
Widgets! 

In Riverpod with Flame, you should use `listenManual` to subscribe to updates from a provider, and remember to close the 
subscription at the appropriate point in the Components lifecycle. Alternatively, you could use `ref.read` as you would 
elsewhere in Flutter.


```dart
/// An excerpt from the Example. Check it out!
class RiverpodAwareTextComponent extends PositionComponent with RiverpodComponentMixin {
  // ComponentRef is a wrapper around WidgetRef and exposes
  // a subset of its API.
  RiverpodAwareTextComponent(ComponentRef ref) {
    this.ref = ref;
  }

  // Remember to close your subscriptions as appropriate.
  late ProviderSubscription<AsyncValue<int>> subscription;
  late TextComponent textComponent;
  int currentValue = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(textComponent = TextComponent(position: position + Vector2(0, 27)));

    listen(countingStreamProvider, (p0, p1) {
      if (p1.hasValue) {
        currentValue = p1.value!;
        textComponent.text = '$currentValue';
      }
    });
  }
}
```
