# Scoped model branch (multiple packages)
In this branch, the domain and data packages are equivalent to other branches implemented with multiple packages architecture, and they are not affected
by scoped model implementation.
In the app package, we have used the [scoped model library](https://pub.dartlang.org/packages/scoped_model)

Scoped model library is built on top of [Inherited Widget](https://www.youtube.com/watch?v=Zbm3hjPjQMk) that is a way of doing databinding in Flutter.

We have defined a abstraction [here](lib/app/core/scoped_model) to ensure that we override initState and dispose methods.

### UI
For every screen we create a package under [ui package](lib/app/ui).
The name of package should have the name of the implemented feature, that can be composed using different screens.

For every screen, we create 3 files:
- <screen_name>_screen.dart: Contains a Stateful Widget, based in scoped model pattern.
- <screen_name>_widgets.dart: Contains widgets that are only used in this screen
- <screen_name>_model.dart: Contains the scoped model related to the screen.

#### Screen
In the screen file, we use the scoped model pattern
We create the stateful widget as usual, but we add inheritance from our widget based in scoped model:
```
class _TalkDetailScreenState extends BaseScopedModelState<TalkDetailScreen> {
```
With the above line, we are forced to override some methods, so we can focus designing the screen
and reduce the boiler plate code that is identical in every screen.

Basically, the idea is create a instance of the scoped model, execute a initial method
in onInitState (equivalent to initState), and react in build to the view state.
Depending on the view state, show one widget or another.

#### Widgets
All widgets should be independent of the architecture when is possible.
For every screen, define your widgets in <screen_name>_widgets.dart

If you need to use the same widget in multiple screens (for instance, a loading widget),
create a separate class in another package, like this [common_widgets](lib/app/ui/common)

#### Model
In the model file, define the view states and the model.

```
enum _CurrentState { LOADING_TALKS, SHOW_TALKS, SHOW_ERROR_TALKS }

class TalksModel extends BaseScopedModel {
```

Although the implementation details may change, the main idea is
execute use cases and when we have the use case response,
call notifyListeners() to rebuild the widgets.

To understand how it works, take a look to [talks screen](lib/app/ui/talks/).

## Limitations of Scoped Model pattern
- Call notifyListeners() every time we want to rebuild screen is verbose.
- How can we unit test notifyListeners()?