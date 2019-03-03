import 'dart:io';

import 'package:data/core/config/config.dart';
import 'package:domain/model/models.dart';
import 'package:flutter_votlin_app/app/core/injection/injector.dart';
import 'package:flutter_votlin_app/app/ui/talks/talks_presenter.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTalksView extends Mock implements TalksView {}

void main() {
  TalksView mockTalksView;
  TalksPresenter talksPresenter;
  var mockServer;

  setUpAll(() async {
    Config.flavor = Flavor.MOCK_WEBSERVER;
    Injector.init();
    mockServer = MockWebServer(port: 8081);
    await mockServer.start();
  });

  setUp(() {
    mockTalksView = MockTalksView();
    talksPresenter = TalksPresenter(mockTalksView);
  });

  test('get all talks success', () async {
    _givenAllTalksResponses(mockServer);

    talksPresenter.getAllTalks();
    await _wait();

    verify(mockTalksView.showLoading()).called(1);
    verify(mockTalksView.showTalks()).called(1);
    expect(talksPresenter.model.alltalks, hasLength(38));
    expect(talksPresenter.model.businessTalks, hasLength(13));
    expect(talksPresenter.model.developmentTalks, hasLength(15));
    expect(talksPresenter.model.makerTalks, hasLength(6));
  });

  test('get all talks error', () async {
    mockServer.enqueue(httpCode: 401);

    talksPresenter.getAllTalks();
    await _wait();

    verify(mockTalksView.showLoading()).called(1);
    verify(mockTalksView.showError()).called(1);
  });

  test('get talks from track ALL success', () async {
    mockServer.enqueue(
        body: File('test/server_responses/all_talks.json').readAsStringSync());

    talksPresenter.onTrackSelected(Track.ALL);
    await _wait();

    verify(mockTalksView.showLoading()).called(1);
    verify(mockTalksView.showTalks()).called(1);
    expect(talksPresenter.model.alltalks, isNotEmpty);
  });

  test('get talks from track BUSINESS success', () async {
    mockServer.enqueue(
        body: File('test/server_responses/business_talks.json')
            .readAsStringSync());

    talksPresenter.onTrackSelected(Track.BUSINESS);
    await _wait();

    verify(mockTalksView.showLoading()).called(1);
    verify(mockTalksView.showTalks()).called(1);
    expect(talksPresenter.model.businessTalks, isNotEmpty);
  });

  test('get talks from track DEVELOPMENT success', () async {
    mockServer.enqueue(
        body: File('test/server_responses/business_talks.json')
            .readAsStringSync());

    talksPresenter.onTrackSelected(Track.DEVELOPMENT);
    await _wait();

    verify(mockTalksView.showLoading()).called(1);
    verify(mockTalksView.showTalks()).called(1);
    expect(talksPresenter.model.developmentTalks, isNotEmpty);
  });

  test('get talks from track MAKER success', () async {
    mockServer.enqueue(
        body:
            File('test/server_responses/maker_talks.json').readAsStringSync());

    talksPresenter.onTrackSelected(Track.MAKER);
    await _wait();

    verify(mockTalksView.showLoading()).called(1);
    verify(mockTalksView.showTalks()).called(1);
    expect(talksPresenter.model.makerTalks, isNotEmpty);
  });

  tearDownAll(() {
    if (mockServer != null) {
      mockServer.shutdown();
    }
  });

  test('get talks from track throws an error', () async {
    mockServer.enqueue(httpCode: 401);

    talksPresenter.onTrackSelected(Track.ALL);
    await _wait();

    verify(mockTalksView.showLoading()).called(1);
    verify(mockTalksView.showError()).called(1);
  });

  test('get all talks cancelled when presenter is destroyed', () async {
    _givenAllTalksResponses(mockServer);

    talksPresenter.getAllTalks();
    talksPresenter.destroy();
    await _wait();

    verify(mockTalksView.showLoading()).called(1);
    verifyNever(mockTalksView.showTalks());
    expect(talksPresenter.model.alltalks, isEmpty);
  });

  test('on track selected cancelled when presenter is destroyed', () async {
    mockServer.enqueue(
        body: File('test/server_responses/all_talks.json').readAsStringSync());

    talksPresenter.onTrackSelected(Track.ALL);
    talksPresenter.destroy();
    await _wait();

    verify(mockTalksView.showLoading()).called(1);
    verifyNever(mockTalksView.showTalks());
    expect(talksPresenter.model.alltalks, isEmpty);
  });

  tearDownAll(() {
    if (mockServer != null) {
      mockServer.shutdown();
    }
  });
}

void _givenAllTalksResponses(mockServer) {
  mockServer.enqueue(
      body: File('test/server_responses/all_talks.json').readAsStringSync());
  mockServer.enqueue(
      body:
          File('test/server_responses/business_talks.json').readAsStringSync());
  mockServer.enqueue(
      body: File('test/server_responses/development_talks.json')
          .readAsStringSync());
  mockServer.enqueue(
      body: File('test/server_responses/maker_talks.json').readAsStringSync());
}

Future _wait() async {
  await Future<Null>.delayed(Duration(milliseconds: 3000));
}
