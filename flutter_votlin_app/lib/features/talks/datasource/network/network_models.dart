import 'package:flutter_votlin_app/features/talks/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package:flutter_votlin_app/features/talks/datasource/network/network_models.g.dart';

@JsonSerializable()
class TalksResponseDto {
  final List<TalkDto> talks;

  TalksResponseDto({this.talks});

  factory TalksResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TalksResponseDtoFromJson(json);

  List<Talk> toModel() {
    List<Talk> talksModel = [];
    for (var talkDto in talks) {
      var talkModel = talkDto.toModel();
      if (talkModel != null) {
        talksModel.add(talkModel);
      }
    }
    return talksModel;
  }
}

@JsonSerializable()
class TalkDto {
  String name;
  int id;
  String description;
  String track;
  TimeDto time;
  List<SpeakerDto> speakers;

  TalkDto(
      {this.name,
      this.id,
      this.description,
      this.track,
      this.time,
      this.speakers});

  factory TalkDto.fromJson(Map<String, dynamic> json) =>
      _$TalkDtoFromJson(json);

  Talk toModel() {
    List<Speaker> speakersModel = [];
    for (var speakerDto in speakers) {
      var speaker = speakerDto.toModel();
      if (speaker != null) {
        speakersModel.add(speaker);
      }
    }

    Track _mapTrack() {
      if (track == "ALL") {
        return Track.ALL;
      } else if (track == "BUSINESS") {
        return Track.BUSINESS;
      } else if (track == "DEVELOPMENT") {
        return Track.DEVELOPMENT;
      } else if (track == "MAKER") {
        return Track.MAKER;
      }
    }

    return Talk(
        name: name,
        id: id,
        description: description,
        track: _mapTrack(),
        time: time.toModel(),
        speakers: speakersModel,
        rating: TalkRating(talkId: id, value: 0.0));
  }
}

@JsonSerializable()
class TimeDto {
  int start;
  int end;

  TimeDto({this.start, this.end});

  factory TimeDto.fromJson(Map<String, dynamic> json) =>
      _$TimeDtoFromJson(json);

  Time toModel() {
    return Time(
      start: start,
      end: end,
    );
  }
}

@JsonSerializable()
class SpeakerDto {
  final String twitter;
  final String linkedin;
  final String name;
  final String bio;
  final String photoUrl;

  SpeakerDto({this.twitter, this.linkedin, this.name, this.bio, this.photoUrl});

  factory SpeakerDto.fromJson(Map<String, dynamic> json) =>
      _$SpeakerDtoFromJson(json);

  Speaker toModel() {
    return Speaker(
      twitter: twitter,
      linkedin: linkedin,
      name: name,
      bio: bio,
      photoUrl: photoUrl,
    );
  }
}
