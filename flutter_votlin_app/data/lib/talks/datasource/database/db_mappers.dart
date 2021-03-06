import 'package:domain/model/models.dart';
import 'package:data/core/database/db_mapper.dart';

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
