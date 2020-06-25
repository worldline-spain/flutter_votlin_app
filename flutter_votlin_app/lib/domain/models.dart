import 'package:flutter_votlin_app/core/model/base_models.dart';

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

class TalkRating {
  int talkId;
  double value = 0.0;

  TalkRating({
    this.talkId,
    this.value,
  });
}

class Track<String> extends Enum<String> {
  const Track(String val) : super(val);

  static const Track ALL = const Track("ALL");
  static const Track BUSINESS = const Track("BUSINESS");
  static const Track DEVELOPMENT = const Track("DEVELOPMENT");
  static const Track MAKER = const Track("MAKER");
}

class Time {
  int start;
  int end;

  Time({this.start, this.end});
}

class Speaker {
  final String twitter;
  final String linkedin;
  final String name;
  final String bio;
  final String photoUrl;

  Speaker({
    this.twitter,
    this.linkedin,
    this.name,
    this.bio,
    this.photoUrl,
  });

  String avatarInitials() {
    var fullNameArray = name.split(" ").take(2);
    String initials = "";
    for (var value in fullNameArray) {
      initials = initials + value[0];
    }
    return initials;
  }
}
