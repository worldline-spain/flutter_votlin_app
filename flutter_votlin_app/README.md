# Single package
In this branch, we have app, domain and data but we have one single flutter package.
We have used the [stream builder](https://www.youtube.com/watch?v=MkKEWHfy99Y), in combination with [rxdart behavior subjects](https://pub.dartlang.org/packages/rxdart)

With this combination, we can implement some kind of MVVM pattern.

We have defined a abstraction [here](lib/app/core/stream_builder) to reduce boilerplate.

### UI
For every screen we create a package under [ui package](lib/app/ui).
The name of package should have the name of the implemented feature, that can be composed using different screens.

For every screen, we create 3 files:
- <screen_name>_screen.dart: Contains a Stateful Widget, based in stream builder pattern.
- <screen_name>_widgets.dart: Contains widgets that are only used in this screen
- <screen_name>_model.dart: Contains the ui model related to the screen.

#### Screen
In the screen file, we use stream builder to react to ui model changes
We create the stateful widget as usual, but we add inheritance from our widget based in stream builder:
```
class _TalksScreenState extends StreamBuilderState<TalksScreen> {
```
With the above line, we are forced to override some methods, so we can focus designing the screen
and reduce the boiler plate code that is identical in every screen.

Basically, the idea is create a instance of the ui model, execute a initial method
in onInitState (equivalent to initState), and react in build to the ui model state.
To listen changes from ui model state, we create a stream.

Widget is subscribed to the stream, so every time we update the ui model stream, stream builder apply the changes.
Depending on the ui model state, show one widget or another.

#### Widgets
All widgets should be independent of the architecture when is possible.
For every screen, define your widgets in <screen_name>_widgets.dart

If you need to use the same widget in multiple screens (for instance, a loading widget),
create a separate class in another package, like this [common_widgets](lib/app/ui/common)

#### Model
In the model file, define the view states and the model.

```
enum CurrentState { LOADING_TALKS, SHOW_TALKS, SHOW_ERROR_TALKS }

class TalksModel extends UiModel<CurrentState> {
```

Although the implementation details may change, the main idea is
execute use cases and when we have the use case response,
update the ui model state using behavior subjects.

Stream builder is subscribed to behavior subject stream, so when we update behavior subject, stream builder will be notified.

To reduce boilerplate, we have created a base ui model. With this base ui model, update the view 
is easy: for instance, when talks are ready to show, just call method 'show(CurrentState.SHOW_TALKS)' and stream builder will be notified.

To understand how it works, take a look to [talks screen](lib/app/ui/talks/).

## Limitations of Stream builder pattern
- We need add BehaviorSubjects from rxdart to make things easier.
- Unit testing looks difficult. Testing asynchronous code is always more diffcult than testing synchronous code.
- It looks more complex than scope model, but it is possible to put some code in base classes to reduce complexity.

## Limitations of single package approach
- If we are not strict with pull requests, project can be destroyed.