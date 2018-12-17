# Flutter Votlin App

It would be fantastic if we find a way to separate the presentation layer into separate package,
but we have some issues with local assets, so by the moment, the presentation layer is within the
main module of the project.

This project is structured in the following way:

[flutter_votlin_app](/flutter_votlin_app) -> Flutter main module. Also contains the user interface.

[domain](domain) -> Business layer. Flutter dependences not allowed! Only dart dependencies allowed!

[data](data) -> Data sources layer. Flutter dependences not allowed! Only dart dependencies allowed

## Flutter main module

### Dependency injection
Not dagger :) We are using package [get_it](https://pub.dartlang.org/packages/get_it)

We have a injector class to encapsulate dependency injection properly: [Injector](lib/app/core/injection)

### App navigation
Actually, we are using a simple class with static methods: [AppNavigator](lib/app/core/navigation)

### Styles
Actually, we have defined the styles here: [Styles](lib/app/styles)

### Internationalization
TODO

### MVP pattern
We have defined a abstraction to help to reduce boiler plate in stateful widgets, using the [mvp pattern](lib/app/core/mvp)

### UI
For every screen we create a package under [ui package](lib/app/ui).
The name of package should have a the name of the implemented feature, that can be composed using different screens.

For every screen, we create 3 files:
- <screen_name>_screen.dart: Contains a Stateful Widget, based in MVP pattern.
- <screen_name>_widgets.dart: Contains widgets that are only used in this screen
- <screen_name>_presenter.dart: Contains the presenter related to the screen.

#### Screen
In the screen file, we define a enum with the view states:
```
enum _ViewStates {  LOADING_TALK_DETAIL,SHOW_TALK_DETAIL,SHOW_ERROR_TALK_DETAIL}
```
We create the stateful widget as usual, but we add inheritance from our widget based in mvp:
```
class _TalkDetailScreenState extends MvpState<TalkDetailScreen, _ViewStates>
    implements TalkDetailView {
```
With the above line, we are forced to override some methods, so we can focus designing the screen
and reduce the boiler plate code that is identical in every screen.

Basically, the idea is create a instance of the presenter, execute a initial method
in onInitState (equivalent to initState), and react in onBuild(equivalent to build) to the view state.
Depending on the view state, show one widget or another.

#### Widgets
All widgets should be independent of the architecture when is possible.
For every screen, define your widgets in <screen_name>_widgets.dart

If you need to use the same widget in multiple screens (for instance, a loading widget),
create a separate class in another package, like this [common_widgets](lib/app/ui/common)

#### Presenter
In the presenter file, define the view, the model, and the presenter class.
Although the implementation details may change, the main idea is
execute use cases in presenter methods and when we have the use case response,
call the view to rebuild the widgets.
Actually, we are not passing the model to the view. Due to flutter framework flow,
it is better encapsulate the model inside the presenter class.

To understand how it works, take a look to [talk detail](lib/app/ui/talk_detail/).

We have added some debug traces to help to understand what is happening in the presentation layer.
Take a look to the logs and look for `print(` to understand it better.

## Domain module
[More info here](domain)

## Data module
[More info here](data)

## Limitations
Actually, there are some boiler plate code that we are trying to reduce with a custom solution.
It would be good don't use a custom solution, but actually use things like StreamBuilder or
FutureBuilder has a lot of framework dependency.

We would like to maintain widgets implementation independent of any architecture.
In this way, we can switch the project architecture faster.