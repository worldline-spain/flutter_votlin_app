import 'package:domain/interactor/talks/get_all_talks_use_case.dart';
import 'package:domain/interactor/talks/get_talks_by_track_use_case.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_votlin_app/app/core/injection/injector.dart';
import 'package:flutter_votlin_app/app/core/scoped_model/scoped_model_pattern.dart';
import 'package:scoped_model/scoped_model.dart';

enum _CurrentState { LOADING_TALKS, SHOW_TALKS, SHOW_ERROR_TALKS }

class TalksModel extends BaseScopedModel {
  static TalksModel of(BuildContext context) =>
      ScopedModel.of<TalksModel>(context);

  GetAllTalksUseCase _getAllTalksUseCase;
  GetTalksByTrackUseCase _getTalksByTrackUseCase;

  _CurrentState currentState;
  List<Talk> alltalks = List();
  List<Talk> businessTalks = List();
  List<Talk> developmentTalks = List();
  List<Talk> makerTalks = List();

  TalksModel() {
    this._getAllTalksUseCase = GetAllTalksUseCase(Injector.talksRepository);
    this._getTalksByTrackUseCase =
        GetTalksByTrackUseCase(Injector.talksRepository);
  }

  bool get showLoading => currentState == _CurrentState.LOADING_TALKS;

  bool get showTalks => currentState == _CurrentState.SHOW_TALKS;

  bool get showError => currentState == _CurrentState.SHOW_ERROR_TALKS;

  void onTrackSelected(Track track) {
    _getTalksByTrack(track);
  }

  void getAllTalks() {
    currentState = _CurrentState.LOADING_TALKS;
    notifyListeners();

    _getAllTalksUseCase.execute(
      onData: (response) {
        print('onData');
        alltalks = response.allTalks;
        businessTalks = response.businessTalks;
        developmentTalks = response.developmentTalks;
        makerTalks = response.makerTalks;

        currentState = _CurrentState.SHOW_TALKS;
        notifyListeners();
      },
      onDone: () => print('onDone'),
      onError: (error) {
        print('onError');
        currentState = _CurrentState.SHOW_ERROR_TALKS;
        notifyListeners();
      },
    );
  }

  void _getTalksByTrack(Track track) {
    currentState = _CurrentState.LOADING_TALKS;
    notifyListeners();

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

        currentState = _CurrentState.SHOW_TALKS;
        notifyListeners();
      },
      onDone: () => print('onDone'),
      onError: (error) {
        print('onError');
        currentState = _CurrentState.SHOW_ERROR_TALKS;
        notifyListeners();
      },
    );
  }

  @override
  void destroy() {
    _getAllTalksUseCase.unsubscribe();
    _getTalksByTrackUseCase.unsubscribe();
  }
}
