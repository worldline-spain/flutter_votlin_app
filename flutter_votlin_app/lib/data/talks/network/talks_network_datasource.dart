import 'package:flutter_votlin_app/core/data/network/core_http_client.dart';
import 'package:flutter_votlin_app/data/talks/talks_datasources.dart';
import 'package:flutter_votlin_app/domain/models.dart';

import 'edd_endpoints.dart';
import 'network_models.dart';

class TalksNetworkDataSource implements TalksRemoteDataSource {
  final CoreHttpClient _httpClient;

  TalksNetworkDataSource(this._httpClient);

  @override
  Future<List<Talk>> getTalks() async {
    var response =
        await _httpClient.get(EDDEndpoints.getAllTalks()) as List;
    var dynamicList =
        response.map((talkDto) => TalkDto.fromJson(talkDto).toModel()).toList();
    return List<Talk>.from(dynamicList);
  }

  @override
  Future<Talk> getTalkById(int talkId) async {
    var response =
        await _httpClient.get(EDDEndpoints.getTalksById(talkId)) as Map;
    return TalkDto.fromJson(response).toModel();
  }

  @override
  Future<List<Talk>> getTalksByTrack(Track track) async {
    final response = await _httpClient
        .get(EDDEndpoints.getTalkByTrack(track.value)) as List;
    var dynamicList =
        response.map((talkDto) => TalkDto.fromJson(talkDto).toModel()).toList();
    return List<Talk>.from(dynamicList);
  }
}
