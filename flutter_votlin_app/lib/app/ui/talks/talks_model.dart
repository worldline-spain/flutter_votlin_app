import 'package:flutter_votlin_app/core/injection/injector.dart';
import 'package:flutter_votlin_app/core/stream_builder/stream_builder_pattern.dart';
import 'package:flutter_votlin_app/features/talks/interactor/get_all_talks_use_case.dart';
import 'package:flutter_votlin_app/features/talks/interactor/get_talks_by_track_use_case.dart';
import 'package:flutter_votlin_app/features/talks/models.dart';

enum TalksState { LOADING_TALKS, SHOW_TALKS, SHOW_ERROR_TALKS }

class TalksModel extends UiModel<TalksState> {
  GetAllTalksUseCase _getAllTalksUseCase;
  GetTalksByTrackUseCase _getTalksByTrackUseCase;

  List<Talk> alltalks = List();
  List<Talk> businessTalks = List();
  List<Talk> developmentTalks = List();
  List<Talk> makerTalks = List();

  TalksModel() {
    this._getAllTalksUseCase = GetAllTalksUseCase(Injector.talksRepository);
    this._getTalksByTrackUseCase =
        GetTalksByTrackUseCase(Injector.talksRepository);
  }

  @override
  TalksState initialState() {
    return TalksState.LOADING_TALKS;
  }

  void onTrackSelected(Track track) {
    _getTalksByTrack(track);
  }

  void getAllTalks() {
    _getAllTalksUseCase.execute(
      onData: (response) {
        print('onData');
        alltalks = response.allTalks;
        businessTalks = response.businessTalks;
        developmentTalks = response.developmentTalks;
        makerTalks = response.makerTalks;

        show(TalksState.SHOW_TALKS);
      },
      onDone: () => print('onDone'),
      onError: (error) {
        print('onError');
        show(TalksState.SHOW_ERROR_TALKS);
      },
    );
  }

  void _getTalksByTrack(Track track) {
    show(TalksState.LOADING_TALKS);

    _getTalksByTrackUseCase.execute(
      params: track,
      onData: (response) {
        print('onData');
        switch (track) {
          case Track.ALL:
            alltalks = response.talkList;
            break;
          case Track.BUSINESS:
            businessTalks = response.talkList;
            break;
          case Track.DEVELOPMENT:
            developmentTalks = response.talkList;
            break;
          case Track.MAKER:
            makerTalks = response.talkList;
            break;
        }

        show(TalksState.SHOW_TALKS);
      },
      onDone: () => print('onDone'),
      onError: (error) {
        print('onError');
        show(TalksState.SHOW_ERROR_TALKS);
      },
    );
  }

  @override
  void destroy() {
    _getAllTalksUseCase.unsubscribe();
    _getTalksByTrackUseCase.unsubscribe();
  }
}