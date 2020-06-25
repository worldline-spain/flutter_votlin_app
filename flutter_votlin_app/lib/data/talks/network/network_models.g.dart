// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalksResponseDto _$TalksResponseDtoFromJson(Map<String, dynamic> json) {
  return TalksResponseDto(
    talks: (json['talks'] as List)
        ?.map((e) =>
            e == null ? null : TalkDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TalksResponseDtoToJson(TalksResponseDto instance) =>
    <String, dynamic>{
      'talks': instance.talks,
    };

TalkDto _$TalkDtoFromJson(Map<String, dynamic> json) {
  return TalkDto(
    name: json['name'] as String,
    id: json['id'] as int,
    description: json['description'] as String,
    track: json['track'] as String,
    time: json['time'] == null
        ? null
        : TimeDto.fromJson(json['time'] as Map<String, dynamic>),
    speakers: (json['speakers'] as List)
        ?.map((e) =>
            e == null ? null : SpeakerDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TalkDtoToJson(TalkDto instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'description': instance.description,
      'track': instance.track,
      'time': instance.time,
      'speakers': instance.speakers,
    };

TimeDto _$TimeDtoFromJson(Map<String, dynamic> json) {
  return TimeDto(
    start: json['start'] as int,
    end: json['end'] as int,
  );
}

Map<String, dynamic> _$TimeDtoToJson(TimeDto instance) => <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

SpeakerDto _$SpeakerDtoFromJson(Map<String, dynamic> json) {
  return SpeakerDto(
    twitter: json['twitter'] as String,
    linkedin: json['linkedin'] as String,
    name: json['name'] as String,
    bio: json['bio'] as String,
    photoUrl: json['photoUrl'] as String,
  );
}

Map<String, dynamic> _$SpeakerDtoToJson(SpeakerDto instance) =>
    <String, dynamic>{
      'twitter': instance.twitter,
      'linkedin': instance.linkedin,
      'name': instance.name,
      'bio': instance.bio,
      'photoUrl': instance.photoUrl,
    };
