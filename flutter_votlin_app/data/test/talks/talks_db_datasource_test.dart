import 'package:data/core/database/sqlite_helper.dart';
import 'package:data/talks/datasource/database/talks_db_datasource.dart';
import 'package:data/talks/datasource/talks_datasources.dart';
import 'package:domain/model/models.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockSqliteHelper extends Mock implements SqliteHelper {}

void main() {
  SqliteHelper mockSqliteHelper;
  TalksLocalDataSource talksDbDataSource;

  setUp(() {
    mockSqliteHelper = MockSqliteHelper();
    talksDbDataSource = TalksDbDataSource(mockSqliteHelper);
  });

  test('get rating for talk', () async {
    Future<List<Map<String, dynamic>>> givenTalkRatings = Future.value([
      {"talkId": 2, "value": 5.0},
      {"talkId": 24, "value": 4.0}
    ]);
    when(mockSqliteHelper.get(any)).thenAnswer((_) async => givenTalkRatings);

    TalkRating talkRating = await talksDbDataSource.getRatingForTalk(2);

    expect(talkRating.talkId, 2);
    expect(talkRating.value, 5.0);
  });

  test('save rating for talk', () async {
    Map<String, dynamic> givenTalkRating = {"talkId": 2, "value": 5.0};
    when(mockSqliteHelper.insertOrReplace(any, givenTalkRating))
        .thenAnswer((_) async => true);

    bool saved = await talksDbDataSource
        .saveRatingForTalk(TalkRating(talkId: 2, value: 5.0));

    expect(saved, true);
    verify(mockSqliteHelper.insertOrReplace(any, givenTalkRating)).called(1);
  });
}
