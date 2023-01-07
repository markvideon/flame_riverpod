## 2.0.0

* Pruned the public API, removing custom widget definitions (these have now been defined inside the example for 
reference)
* Renamed [RiverpodAwareGameMixin] -> [HasComponentRef] to bring closer to the Flame 'house-style' for mixins.

## 1.1.0+2

* Another correction to README and example code. onMount should not call super.onLoad.

## 1.1.0+1

* Correction to README to reflect API change.

## 1.1.0

* Added [RiverpodComponentMixin] to handle disposing of [ProviderSubscription]s.
* Correction to the [RiverpodGameWidget] initialiseGame constructor - param is now 
 [RiverpodAwareGameMixin Function (ref)] as originally intended.

## 1.0.0+1

* Reduced package description length.
* Ran dart format.

## 1.0.0

* Initial release.
  * ComponentRef
  * riverpodAwareGameProvider
  * RiverpodAwareFlameGame
  * RiverpodAwareGame
  * RiverpodGameWidget
