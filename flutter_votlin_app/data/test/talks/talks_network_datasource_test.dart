import 'dart:io';

import 'package:data/core/config/config.dart';
import 'package:data/core/network/dart_http_client.dart';
import 'package:data/talks/datasource/network/talks_network_datasource.dart';
import 'package:domain/model/models.dart';
import 'package:test/test.dart';
import 'package:mock_web_server/mock_web_server.dart';

void main() {
  TalksNetworkDataSource talksNetworkDataSource;
  var mockServer;

  setUpAll(() async {
    Config.flavor = Flavor.MOCK_WEBSERVER;
    mockServer = MockWebServer(port: 8081);
    await mockServer.start();
  });

  setUp(() async {
    talksNetworkDataSource = TalksNetworkDataSource(DartHttpClient());
  });

  test('get all talks', () async {
    var file = File('test/server_responses/all_talks.json');
    mockServer.enqueue(body: await file.readAsString());

    List<Talk> talks = await talksNetworkDataSource.getTalks();

    expect(talks, hasLength(38));
  });

  test('get business talks', () async {
    var file = File('test/server_responses/business_talks.json');
    mockServer.enqueue(body: await file.readAsString());

    List<Talk> talks =
        await talksNetworkDataSource.getTalksByTrack(Track.BUSINESS);

    expect(talks, hasLength(13));
  });

  test('get development talks', () async {
    var file = File('test/server_responses/development_talks.json');
    mockServer.enqueue(body: await file.readAsString());

    List<Talk> talks =
        await talksNetworkDataSource.getTalksByTrack(Track.DEVELOPMENT);

    expect(talks, hasLength(15));
  });

  test('get maker talks', () async {
    var file = File('test/server_responses/maker_talks.json');
    mockServer.enqueue(body: await file.readAsString());

    List<Talk> talks =
        await talksNetworkDataSource.getTalksByTrack(Track.MAKER);

    expect(talks, hasLength(6));
  });

  tearDownAll(() {
    if (mockServer != null) {
      mockServer.shutdown();
    }
  });
}
