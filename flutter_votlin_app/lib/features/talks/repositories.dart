import 'package:flutter_votlin_app/features/talks/models.dart';

abstract class TalksRepository {
  Future<List<Talk>> getTalks();

  Future<List<Talk>> getTalksByTrack(Track track);

  Future<Talk> getTalkById(int talkId);

  Future<bool> rateTalk(TalkRating talkRating);
}
