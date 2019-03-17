import 'dart:io';

import 'package:data/core/config/config.dart';
import 'package:domain/model/models.dart';
import 'package:flutter_votlin_app/app/core/injection/injector.dart';
import 'package:flutter_votlin_app/app/ui/talks/talks_model.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TalksModel talksModel;
  var mockServer;

  setUpAll(() async {
    Config.flavor = Flavor.MOCK_WEBSERVER;
    Injector.init();
    mockServer = MockWebServer(port: 8081);
    await mockServer.start();
  });

  setUp(() {
    talksModel = TalksModel();
  });

  test('get all talks success', () async {
    _givenAllTalksResponses(mockServer);

    talksModel.getAllTalks();
    await _wait();

    expect(talksModel.alltalks, hasLength(38));
    expect(talksModel.businessTalks, hasLength(13));
    expect(talksModel.developmentTalks, hasLength(15));
    expect(talksModel.makerTalks, hasLength(6));
    expect(talksModel.showTalks, true);
  });

  test('get all talks error', () async {
    mockServer.enqueue(httpCode: 401);

    talksModel.getAllTalks();
    await _wait();

    expect(talksModel.showError, true);
  });

  test('get talks from track ALL success', () async {
    mockServer.enqueue(
        body: File('test/server_responses/all_talks.json').readAsStringSync());

    talksModel.onTrackSelected(Track.ALL);
    await _wait();

    expect(talksModel.alltalks, isNotEmpty);
    expect(talksModel.showTalks, true);
  });

  test('get talks from track BUSINESS success', () async {
    mockServer.enqueue(
        body: File('test/server_responses/business_talks.json')
            .readAsStringSync());

    talksModel.onTrackSelected(Track.BUSINESS);
    await _wait();

    expect(talksModel.businessTalks, isNotEmpty);
    expect(talksModel.showTalks, true);
  });

  test('get talks from track DEVELOPMENT success', () async {
    mockServer.enqueue(
        body: File('test/server_responses/business_talks.json')
            .readAsStringSync());

    talksModel.onTrackSelected(Track.DEVELOPMENT);
    await _wait();

    expect(talksModel.developmentTalks, isNotEmpty);
    expect(talksModel.showTalks, true);
  });

  test('get talks from track MAKER success', () async {
    mockServer.enqueue(
        body:
            File('test/server_responses/maker_talks.json').readAsStringSync());

    talksModel.onTrackSelected(Track.MAKER);
    await _wait();

    expect(talksModel.makerTalks, isNotEmpty);
    expect(talksModel.showTalks, true);
  });

  tearDownAll(() {
    if (mockServer != null) {
      mockServer.shutdown();
    }
  });

  test('get talks from track throws an error', () async {
    mockServer.enqueue(httpCode: 401);

    talksModel.onTrackSelected(Track.ALL);
    await _wait();

    expect(talksModel.showError, true);
  });

  test('get all talks cancelled when presenter is destroyed', () async {
    _givenAllTalksResponses(mockServer);

    talksModel.getAllTalks();
    talksModel.destroy();
    await _wait();

    expect(talksModel.alltalks, isEmpty);
    expect(talksModel.showLoading, true);
  });

  test('on track selected cancelled when presenter is destroyed', () async {
    mockServer.enqueue(
        body: File('test/server_responses/all_talks.json').readAsStringSync());

    talksModel.onTrackSelected(Track.ALL);
    talksModel.destroy();
    await _wait();


    expect(talksModel.alltalks, isEmpty);
    expect(talksModel.showLoading, true);
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
