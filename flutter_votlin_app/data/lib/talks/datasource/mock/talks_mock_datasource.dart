import 'package:data/talks/datasource/network/network_models.dart';
import 'package:data/talks/datasource/talks_datasources.dart';
import 'package:domain/model/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talks_mock_datasource.g.dart';

@JsonLiteral('schedule.json', asConst: true)
Map<String, dynamic> get mockTalks => _$mockTalksJsonLiteral;

class TalksMockDataSource implements TalksRemoteDataSource {
  final fakeDelayInMillis = 500;

  @override
  Future<List<Talk>> getTalks() async {
    return Future.delayed(
      Duration(milliseconds: fakeDelayInMillis),
      () => _allTalks,
    );
  }

  @override
  Future<Talk> getTalkById(int talkId) async {
    return Future.delayed(Duration(milliseconds: fakeDelayInMillis),
        () => _allTalks.firstWhere((talk) => talk.id == talkId));
  }

  @override
  Future<List<Talk>> getTalksByTrack(Track track) async {
    return Future.delayed(Duration(milliseconds: fakeDelayInMillis),
        () => _allTalks.where((talk) => talk.track == track).toList());
  }

  List<Talk> get _allTalks {
    var dynamicList = mockTalks['talks']
        .map((talkDto) => TalkDto.fromJson(talkDto).toModel())
        .toList();
    return List<Talk>.from(dynamicList);
  }
}
