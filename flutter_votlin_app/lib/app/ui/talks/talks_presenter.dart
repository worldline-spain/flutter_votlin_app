import 'package:domain/interactor/talks/get_all_talks_use_case.dart';
import 'package:domain/interactor/talks/get_talks_by_track_use_case.dart';
import 'package:domain/model/models.dart';
import 'package:flutter_votlin_app/app/core/injection/injector.dart';
import 'package:flutter_votlin_app/app/core/mvp/mvp_pattern.dart';

abstract class TalksView {
  void showLoading();

  void showTalks();

  void showError();
}

class TalksModel {
  List<Talk> alltalks = List();
  List<Talk> businessTalks = List();
  List<Talk> developmentTalks = List();
  List<Talk> makerTalks = List();
}

class TalksPresenter extends Presenter<TalksModel> {
  TalksView _view;
  TalksModel _model;
  GetAllTalksUseCase _getAllTalksUseCase;
  GetTalksByTrackUseCase _getTalksByTrackUseCase;

  TalksPresenter(TalksView view) {
    this._view = view;
    this._model = TalksModel();
    this._getAllTalksUseCase = new GetAllTalksUseCase(Injector.talksRepository);
    this._getTalksByTrackUseCase =
        new GetTalksByTrackUseCase(Injector.talksRepository);
  }

  @override
  TalksModel get model => _model;

  void onTrackSelected(Track track) {
    _getTalksByTrack(track);
  }

  void getAllTalks() {
    _view.showLoading();
    _getAllTalksUseCase.execute(
      onData: (response) {
        print('onData');
        _model = TalksModel()
          ..alltalks = response.allTalks
          ..businessTalks = response.businessTalks
          ..developmentTalks = response.developmentTalks
          ..makerTalks = response.makerTalks;

        _view.showTalks();
      },
      onDone: () => print('onDone'),
      onError: (error) {
        print('onError');
        _view.showError();
      },
    );
  }

  void _getTalksByTrack(Track track) {
    _view.showLoading();
    _getTalksByTrackUseCase.execute(
      params: track,
      onData: (response) {
        print('onData');
        switch (track) {
          case Track.ALL:
            model.alltalks = response.talkList;
            break;
          case Track.BUSINESS:
            model.businessTalks = response.talkList;
            break;
          case Track.DEVELOPMENT:
            model.developmentTalks = response.talkList;
            break;
          case Track.MAKER:
            model.makerTalks = response.talkList;
            break;
        }
        _view.showTalks();
      },
      onDone: () => print('onDone'),
      onError: (error) {
        print('onError');
        _view.showError();
      },
    );
  }

  @override
  void destroy() {
    _getAllTalksUseCase.unsubscribe();
    _getTalksByTrackUseCase.unsubscribe();
  }
}
