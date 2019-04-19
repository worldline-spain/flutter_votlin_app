import 'package:flutter_votlin_app/data/talks/datasource/talks_datasources.dart';
import 'package:flutter_votlin_app/domain/model/models.dart';
import 'package:flutter_votlin_app/domain/repository/talks_repository.dart';

class TalksRepositoryImpl implements TalksRepository {
  final TalksRemoteDataSource talksRemoteDataSource;
  final TalksLocalDataSource talksLocalDataSource;

  TalksRepositoryImpl(this.talksRemoteDataSource, this.talksLocalDataSource);

  @override
  Future<List<Talk>> getTalks() {
    return talksRemoteDataSource.getTalks();
  }

  @override
  Future<List<Talk>> getTalksByTrack(Track track) {
    return talksRemoteDataSource.getTalksByTrack(track);
  }

  @override
  Future<Talk> getTalkById(int talkId) async {
    Talk talk = await talksRemoteDataSource.getTalkById(talkId);
    TalkRating talkRating = await talksLocalDataSource.getRatingForTalk(talkId);
    talk.rating = talkRating;
    return talk;
  }

  @override
  Future<bool> rateTalk(TalkRating talkRating) {
    return talksLocalDataSource.saveRatingForTalk(talkRating);
  }
}
