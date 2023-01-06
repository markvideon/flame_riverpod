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

In Riverpod with Flame, you should use `listen` to subscribe to updates from a provider. Alternatively, you could use 
`ref.read` as you would elsewhere in Flutter.


```dart
/// An excerpt from the Example. Check it out!
class RiverpodAwareTextComponent extends PositionComponent with RiverpodComponentMixin {
  // ComponentRef is a wrapper around WidgetRef and exposes
  // a subset of its API.
  RiverpodAwareTextComponent(ComponentRef ref) {
    this.ref = ref;
  }

  late TextComponent textComponent;
  int currentValue = 0;

  /// [onMount] should be used over [onLoad], as subscriptions are cancelled
  /// inside [onRemove], which is only called if the [Component] was mounted.
  @override
  Future<void> onMount() async {
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
