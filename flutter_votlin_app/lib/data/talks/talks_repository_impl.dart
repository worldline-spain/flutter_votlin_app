
import 'package:flutter_votlin_app/domain/models.dart';
import 'package:flutter_votlin_app/domain/repositories.dart';

import 'talks_datasources.dart';

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
