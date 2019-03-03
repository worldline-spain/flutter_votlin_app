import 'dart:io';

import 'package:data/core/config/config.dart';
import 'package:domain/model/models.dart';
import 'package:flutter_votlin_app/app/core/injection/injector.dart';
import 'package:flutter_votlin_app/app/ui/talk_detail/talk_detail_presenter.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTalkDetailView extends Mock implements TalkDetailView {}

void main() {
  TalkDetailView mockTalkDetailView;
  TalkDetailPresenter talkDetailPresenter;
  var mockServer;

  setUpAll(() async {
    Config.flavor = Flavor.MOCK_WEBSERVER;
    Injector.init();
    mockServer = MockWebServer(port: 8081);
    await mockServer.start();
  });

  setUp(() {
    mockTalkDetailView = MockTalkDetailView();
    talkDetailPresenter = TalkDetailPresenter(mockTalkDetailView);
  });

  test('get talk detail success', () async {
    _givenTalkDetailResponse(mockServer);
    Talk givenTalk = Talk(id: 37);

    talkDetailPresenter.getTalkDetail(givenTalk);
    await _wait();

    verify(mockTalkDetailView.showLoading()).called(1);
    verify(mockTalkDetailView.showTalkDetail()).called(1);
    expect(talkDetailPresenter.model.talk.id, 37);
    expect(talkDetailPresenter.model.talk.name,
        "Kotlin. un lenguaje para dominarlos a todos");
    expect(talkDetailPresenter.model.talk.description, isNotEmpty);
    expect(talkDetailPresenter.model.talk.track, Track.DEVELOPMENT);
    expect(talkDetailPresenter.model.talk.time.start, 1540654200000);
    expect(talkDetailPresenter.model.talk.time.end, 1540656900000);
    expect(talkDetailPresenter.model.talk.speakers, hasLength(2));
  });

  test('get talk detail throws an error', () async {
    mockServer.enqueue(httpCode: 401);
    Talk givenTalk = Talk(id: 37);

    talkDetailPresenter.getTalkDetail(givenTalk);
    await _wait();

    verify(mockTalkDetailView.showLoading()).called(1);
    verify(mockTalkDetailView.showError()).called(1);
  });

  test('rate talk success', () async {
    _givenTalkDetailResponse(mockServer);
    Talk givenTalk = Talk(id: 37);
    TalkRating givenTalkRating = TalkRating(talkId: 37, value: 4.0);

    talkDetailPresenter.getTalkDetail(givenTalk);
    await _wait();

    talkDetailPresenter.rateTalk(givenTalkRating);

    verify(mockTalkDetailView.showTalkDetail()).called(2);
    expect(talkDetailPresenter.model.talk.rating, givenTalkRating);
  });

  tearDownAll(() {
    if (mockServer != null) {
      mockServer.shutdown();
    }
  });
}

void _givenTalkDetailResponse(mockServer) {
  mockServer.enqueue(
      body: File('test/server_responses/talk_detail.json').readAsStringSync());
}

Future _wait() async {
  await Future<Null>.delayed(Duration(milliseconds: 3000));
}
