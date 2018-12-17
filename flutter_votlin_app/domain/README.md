# Domain module

Domain layer.
Actually, this module only has dart dependencies.

This module contains:
- [use cases](lib/interactor/talks)
- [domain entities](lib/model)
- [repository interface](lib/repository)

## Interactor
Actually, the implementation of the interactor is a wrapper from StreamSubscription.
The reason to wrap in StreamSubscription is that Futures, unlike Streams, can't be canceled.
If we cancel the stream, we can't stop Future, but result will be ignored, so it is enough.

For instance, to create a use case to get all talks from Extremadura Digital Day, follow the steps:
- Think if your use case need input parameters or not.
- If your use case doesn't need input params:
    - Create classes GetAllTalksUseCase and GetAllTalksResponse
    - Add to GetAllTalksUseCase inheritance from FutureInteractorNoParams
    - Implement the run method
    - Define in GetAllTalksUseCase constructor all dependencies that you need
    - Define in GetAllTalksResponse all the info that you need to show to the user
- If you use case need input params, follow the above steps, but extends from FutureInteractorWithParams

Example:
```
class GetAllTalksUseCase extends FutureInteractorNoParams<GetAllTalksResponse> {
  final TalksRepository talksRepository;

  GetAllTalksUseCase(this.talksRepository);

  @override
  Future<GetAllTalksResponse> run() async {
    List<Talk> allTalks = await talksRepository.getTalks();
    List<Talk> businessTalks =
        await talksRepository.getTalksByTrack(Track.BUSINESS);
    List<Talk> developmentTalks =
        await talksRepository.getTalksByTrack(Track.DEVELOPMENT);
    List<Talk> makerTalks = await talksRepository.getTalksByTrack(Track.MAKER);

    return GetAllTalksResponse()
      ..allTalks = allTalks
      ..businessTalks = businessTalks
      ..developmentTalks = developmentTalks
      ..makerTalks = makerTalks;
  }
}

class GetAllTalksResponse {
  List<Talk> allTalks;
  List<Talk> businessTalks;
  List<Talk> developmentTalks;
  List<Talk> makerTalks;
}
```
Note: The .. syntax is a fantastic way to create a builder in dart :)

## Models
Just a bunch of POJO classes that define your domain entities.

Example:
```
class Talk {
  String name;
  int id;
  String description;
  Track track;
  Time time;
  List<Speaker> speakers;
  TalkRating rating;

  Talk({
    this.name,
    this.id,
    this.description,
    this.track,
    this.time,
    this.speakers,
    this.rating,
  });
}
```

Note: Enums are very limited in dart, so we use a enum custom type:
```
abstract class Enum<T> {
  final T _value;

  const Enum(this._value);

  T get value => _value;
}

class Track<String> extends Enum<String> {
  const Track(String val) : super(val);

  static const Track ALL = const Track("ALL");
  static const Track BUSINESS = const Track("BUSINESS");
  static const Track DEVELOPMENT = const Track("DEVELOPMENT");
  static const Track MAKER = const Track("MAKER");
}
```
This post was really helpful:
[How to build a enum in dart](https://stackoverflow.com/questions/15854549/how-can-i-build-an-enum-with-dart)

## Repository
Actually, repository layer returns Future type.

Example:
```
abstract class TalksRepository {
  Future<List<Talk>> getTalks();

  Future<List<Talk>> getTalksByTrack(Track track);

  Future<Talk> getTalkById(int talkId);

  Future<bool> rateTalk(TalkRating talkRating);
}
```
## Limitations
Actually, we don't expose a way of combine interactors. If we need to combine 2 interactors,
we can extract logic to common class and create a interactor that combines the logic from both interactors.

It would be nice if we can find a way of combine several interactors, using
streams or some external package like rxdart: https://pub.dartlang.org/packages/rxdart

We need to invest time to see how can integrate all the power of streams without adding
complexity and without breaking dependencies.

A recommended talk about being reactive in Flutter is
[ReactiveConf 2018 - Brian Egan & Filip Hracek: Practical Rx with Flutter](https://www.youtube.com/watch?v=7O1UO5rEpRc)