import 'dart:async';
import 'package:flutter_votlin_app/features/talks/datasource/talks_datasources.dart';
import 'package:flutter_votlin_app/features/talks/models.dart';

class TalksMockDbDataSource implements TalksLocalDataSource {
  TalksMockDbDataSource();

  @override
  Future<TalkRating> getRatingForTalk(int talkId) async {
    return Future.value(TalkRating(talkId: 37, value: 5.0));
  }

  @override
  Future<bool> saveRatingForTalk(TalkRating talkRating) async {
    return Future.value(true);
  }
}
