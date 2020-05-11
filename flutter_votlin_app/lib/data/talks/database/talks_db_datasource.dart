import 'dart:async';

import 'package:flutter_votlin_app/core/data/database/sqlite_helper.dart';
import 'package:flutter_votlin_app/domain/models.dart';
import 'package:flutter_votlin_app/data/talks/database/db_mappers.dart';

import '../talks_datasources.dart';

class TalksDbDataSource implements TalksLocalDataSource {
  SqliteHelper sqliteHelper;
  TalkRatingsDbMapper talkRatingsDbMapper;

  static const String _TABLE_NAME = "TalkRatings";

  TalksDbDataSource(this.sqliteHelper) {
    this.sqliteHelper = sqliteHelper;
    this.talkRatingsDbMapper = TalkRatingsDbMapper();
  }

  @override
  Future<TalkRating> getRatingForTalk(int talkId) async {
    var result = await sqliteHelper.get("SELECT * FROM $_TABLE_NAME");
    List<TalkRating> talkRatings =
        result.map((rowDb) => talkRatingsDbMapper.toModel(rowDb)).toList();

    return talkRatings.firstWhere(
      (talkRating) => talkRating.talkId == talkId,
      orElse: () => TalkRating(talkId: talkId, value: 0.0),
    );
  }

  @override
  Future<bool> saveRatingForTalk(TalkRating talkRating) async {
    await sqliteHelper.insertOrReplace(
        _TABLE_NAME, talkRatingsDbMapper.toMap(talkRating));
    return Future.value(true);
  }
}
