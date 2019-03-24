import 'dart:async';
import 'dart:io';

import 'package:data/core/config/config.dart';
import 'package:domain/model/models.dart';
import 'package:flutter_votlin_app/app/core/injection/injector.dart';
import 'package:flutter_votlin_app/app/ui/talk_detail/talk_detail_model.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TalkDetailModel model;
  var mockServer;

  setUpAll(() async {
    Config.flavor = Flavor.MOCK_WEBSERVER;
    Injector.init();
    mockServer = MockWebServer(port: 8081);
    await mockServer.start();
  });

  setUp(() {
    model = TalkDetailModel();
  });

  test('get talk detail success', () async {
    _givenTalkDetailResponse(mockServer);
    Talk givenTalk = Talk(id: 37);

    expect(
        model.uiStateStream(),
        emitsInOrder(
            {CurrentState.LOADING_TALK_DETAIL, CurrentState.SHOW_TALK_DETAIL}));

    model.getTalkDetail(givenTalk);
    await _wait();

    expect(model.talk.id, 37);
    expect(model.talk.name, "Kotlin. un lenguaje para dominarlos a todos");
    expect(model.talk.description, isNotEmpty);
    expect(model.talk.track, Track.DEVELOPMENT);
    expect(model.talk.time.start, 1540654200000);
    expect(model.talk.time.end, 1540656900000);
    expect(model.talk.speakers, hasLength(2));
  });

  test('get talk detail throws an error', () async {
    mockServer.enqueue(httpCode: 401);
    Talk givenTalk = Talk(id: 37);

    expect(
        model.uiStateStream(),
        emitsInOrder({
          CurrentState.LOADING_TALK_DETAIL,
          CurrentState.SHOW_ERROR_TALK_DETAIL
        }));

    model.getTalkDetail(givenTalk);
  });

  test('rate talk success', () async {
    _givenTalkDetailResponse(mockServer);
    Talk givenTalk = Talk(id: 37);
    TalkRating givenTalkRating = TalkRating(talkId: 37, value: 4.0);

    expect(
        model.uiStateStream(),
        emitsInOrder({
          CurrentState.LOADING_TALK_DETAIL,
          CurrentState.SHOW_TALK_DETAIL,
          CurrentState.SHOW_TALK_DETAIL
        }));

    model.getTalkDetail(givenTalk);
    await _wait();
    model.rateTalk(givenTalkRating);
    await _wait();

    expect(model.talk.rating, givenTalkRating);
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
  await Future<Null>.delayed(Duration(seconds: 3));
}
