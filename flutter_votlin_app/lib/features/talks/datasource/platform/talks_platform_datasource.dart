import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_votlin_app/features/talks/datasource/network/network_models.dart';
import 'package:flutter_votlin_app/features/talks/datasource/talks_datasources.dart';
import 'package:flutter_votlin_app/features/talks/models.dart';

class TalksPlatformDataSource implements TalksRemoteDataSource {
  final fakeDelayInMillis = 500;

  static const PLATFORM_CHANNEL =
      const MethodChannel('com.worldline.fluttervotlinapp/fluttervotlinapp');

  @override
  Future<List<Talk>> getTalks() async {
    return _allTalks;
  }

  @override
  Future<Talk> getTalkById(int talkId) async {
    var allTalksResponse = await _allTalks;
    return allTalksResponse.firstWhere((talk) => talk.id == talkId);
  }

  @override
  Future<List<Talk>> getTalksByTrack(Track track) async {
    var allTalksResponse = await _allTalks;
    return allTalksResponse.where((talk) => talk.track == track).toList();
  }

  Future<List<Talk>> get _allTalks async {
    var jsonResponse = await PLATFORM_CHANNEL.invokeMethod('getTalks');
    final response = json.decode(jsonResponse)['talks'] as List;
    var dynamicList =
        response.map((talkDto) => TalkDto.fromJson(talkDto).toModel()).toList();
    return Future.delayed(
      Duration(milliseconds: fakeDelayInMillis),
      () => List<Talk>.from(dynamicList),
    );
  }
}
