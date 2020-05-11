import 'package:flutter_votlin_app/core/data/database/db_mapper.dart';
import 'package:flutter_votlin_app/domain/models.dart';

class TalkRatingsDbMapper extends DbMapper<TalkRating> {
  static const String db_talkId = "talkId";
  static const String db_value = "value";

  TalkRatingsDbMapper();

  @override
  TalkRating toModel(Map<String, dynamic> map) {
    return TalkRating(
      talkId: map[db_talkId],
      value: map[db_value],
    );
  }

  @override
  Map<String, dynamic> toMap(TalkRating model) {
    return {
      db_talkId: model.talkId,
      db_value: model.value,
    };
  }
}
