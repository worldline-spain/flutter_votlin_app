import 'dart:async';

import 'package:flutter_votlin_app/app/injection/injector.dart';
import 'package:flutter_votlin_app/core/stream_builder/stream_builder_pattern.dart';
import 'package:flutter_votlin_app/features/talks/models.dart';
import 'package:flutter_votlin_app/features/talks/repositories.dart';

enum TalksState { LOADING_TALKS, SHOW_TALKS, SHOW_ERROR_TALKS }

class TalksModel extends UiModel<TalksState> {
  TalksRepository talksRepository;

  List<Talk> allTalks = List();
  List<Talk> businessTalks = List();
  List<Talk> developmentTalks = List();
  List<Talk> makerTalks = List();

  TalksModel() {
    this.talksRepository = Injector.talksRepository;
  }

  @override
  TalksState initialState() {
    return TalksState.LOADING_TALKS;
  }

  void getAllTalks() {
    execute(
      _getAllTalks(),
      onData: (success) {
        show(TalksState.SHOW_TALKS);
      },
      onError: (error) {
        show(TalksState.SHOW_ERROR_TALKS);
      },
    );
  }

  void onTrackSelected(Track track) {
    show(TalksState.LOADING_TALKS);

    execute(
      _getTalksByTrack(track),
      onData: (talkList) {
        switch (track) {
          case Track.ALL:
            allTalks = talkList;
            break;
          case Track.BUSINESS:
            businessTalks = talkList;
            break;
          case Track.DEVELOPMENT:
            developmentTalks = talkList;
            break;
          case Track.MAKER:
            makerTalks = talkList;
            break;
        }
        show(TalksState.SHOW_TALKS);
      },
      onError: (error) {
        show(TalksState.SHOW_ERROR_TALKS);
      },
    );
  }

  Future<bool> _getAllTalks() async {
    this.allTalks = await talksRepository.getTalks();
    this.businessTalks = await talksRepository.getTalksByTrack(Track.BUSINESS);
    this.developmentTalks =
        await talksRepository.getTalksByTrack(Track.DEVELOPMENT);
    this.makerTalks = await talksRepository.getTalksByTrack(Track.MAKER);
    return Future.value(true);
  }

  Future<List<Talk>> _getTalksByTrack(Track track) async {
    List<Talk> talkList;
    if (track == Track.ALL) {
      talkList = await talksRepository.getTalks();
    } else {
      talkList = await talksRepository.getTalksByTrack(track);
    }
    return Future.value(talkList);
  }

  @override
  void destroy() {}
}
