import 'package:data/core/network/core_http_client.dart';
import 'package:data/talks/api/edd_endpoints.dart';
import 'package:data/talks/datasource/talks_datasources.dart';
import 'package:data/talks/datasource/network/network_models.dart';
import 'package:domain/model/models.dart';

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
