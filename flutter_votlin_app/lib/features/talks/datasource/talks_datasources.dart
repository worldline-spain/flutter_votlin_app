import 'package:flutter_votlin_app/features/talks/models.dart';

abstract class TalksRemoteDataSource {
  Future<List<Talk>> getTalks();

  Future<Talk> getTalkById(int talkId);

  Future<List<Talk>> getTalksByTrack(Track track);
}

abstract class TalksLocalDataSource {
  Future<TalkRating> getRatingForTalk(int talkId);

  Future<bool> saveRatingForTalk(TalkRating talkRating);
}
