import 'package:flutter_votlin_app/domain/model/models.dart';

abstract class TalksRemoteDataSource {
  Future<List<Talk>> getTalks();

  Future<Talk> getTalkById(int talkId);

  Future<List<Talk>> getTalksByTrack(Track track);
}

abstract class TalksLocalDataSource {
  Future<TalkRating> getRatingForTalk(int talkId);

  Future<bool> saveRatingForTalk(TalkRating talkRating);
}
