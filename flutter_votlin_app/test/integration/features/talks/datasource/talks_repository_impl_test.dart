import 'package:flutter_votlin_app/features/talks/datasource/mock/talks_mock_datasource.dart';
import 'package:flutter_votlin_app/features/talks/datasource/talks_datasources.dart';
import 'package:flutter_votlin_app/features/talks/datasource/talks_repository_impl.dart';
import 'package:flutter_votlin_app/features/talks/models.dart';
import 'package:flutter_votlin_app/features/talks/repositories.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockTalksRemoteDataSource extends Mock implements TalksRemoteDataSource {}

class MockTalksLocalDataSource extends Mock implements TalksLocalDataSource {}

void main() {
  TalksRemoteDataSource mockTalksRemoteDataSource;
  TalksLocalDataSource mockTalksLocalDataSource;
  TalksRepository talksRepository;

  setUp(() {
    mockTalksRemoteDataSource = MockTalksRemoteDataSource();
    mockTalksLocalDataSource = MockTalksLocalDataSource();
    talksRepository = TalksRepositoryImpl(
        mockTalksRemoteDataSource, mockTalksLocalDataSource);
  });

  test('get all talks from remote datasource', () async {
    Future<List<Talk>> givenAllTalks =
        Future.value(TalksMockDataSource().getTalks());
    when(mockTalksRemoteDataSource.getTalks())
        .thenAnswer((_) async => givenAllTalks);

    List<Talk> talks = await talksRepository.getTalks();

    expect(talks, isNotEmpty);
    verify(mockTalksRemoteDataSource.getTalks()).called(1);
  });

  test('get development talks from remote datasource', () async {
    Future<List<Talk>> givenDevelopmentTalks =
        Future.value(TalksMockDataSource().getTalksByTrack(Track.DEVELOPMENT));
    when(mockTalksRemoteDataSource.getTalksByTrack(Track.DEVELOPMENT))
        .thenAnswer((_) async => givenDevelopmentTalks);

    List<Talk> talks = await talksRepository.getTalksByTrack(Track.DEVELOPMENT);

    expect(talks, isNotEmpty);
    verify(mockTalksRemoteDataSource.getTalksByTrack(Track.DEVELOPMENT))
        .called(1);
  });

  test('get a specific talk from remote datasource', () async {
    Future<Talk> givenTalk =
        await Future.value(TalksMockDataSource().getTalkById(2));
    Future<TalkRating> givenTalkRating =
        Future.value(TalkRating(talkId: 2, value: 5.0));
    when(mockTalksRemoteDataSource.getTalkById(2))
        .thenAnswer((_) async => givenTalk);
    when(mockTalksLocalDataSource.getRatingForTalk(2))
        .thenAnswer((_) async => givenTalkRating);

    Talk talk = await talksRepository.getTalkById(2);

    expect(talk.id, 2);
    expect(talk.rating.value, 5.0);
    verify(mockTalksRemoteDataSource.getTalkById(2)).called(1);
  });
}
