import 'package:domain/interactor/talks/get_talk_detail_use_case.dart';
import 'package:domain/interactor/talks/rate_talk_use_case.dart';
import 'package:domain/model/models.dart';
import 'package:flutter_votlin_app/app/core/injection/injector.dart';
import 'package:flutter_votlin_app/app/core/mvp/mvp_pattern.dart';

abstract class TalkDetailView {
  void showLoading();

  void showTalkDetail();

  void showError();
}

class TalkDetailModel {
  Talk talk;
}

class TalkDetailPresenter extends Presenter<TalkDetailModel> {
  TalkDetailView _view;
  TalkDetailModel _model;

  GetTalkDetailUseCase getTalkDetailUseCase;
  RateTalkUseCase rateTalkUseCase;

  TalkDetailPresenter(TalkDetailView view) {
    this._view = view;
    this._model = TalkDetailModel();
    this.getTalkDetailUseCase = GetTalkDetailUseCase(Injector.talksRepository);
    this.rateTalkUseCase = RateTalkUseCase(Injector.talksRepository);
  }

  @override
  TalkDetailModel get model => _model;

  void getTalkDetail(Talk talk) {
    _view.showLoading();
    getTalkDetailUseCase.execute(
      params: talk,
      onData: (response) {
        print('onData');
        _model = TalkDetailModel()..talk = response.talk;

        _view.showTalkDetail();
      },
      onDone: () => print('onDone'),
      onError: (error) {
        print('onError');
        _view.showError();
      },
    );
  }

  void rateTalk(TalkRating talkRating) {
    model.talk.rating = talkRating;
    _view.showTalkDetail();

    rateTalkUseCase.execute(
      params: talkRating,
      onData: (success) {
        print('onData' + " updateRatingTalk success:" + success.toString());
      },
      onDone: () => print('onDone'),
      onError: (error) {
        print('onError');
      },
    );
  }

  @override
  void destroy() {
    getTalkDetailUseCase.unsubscribe();
    rateTalkUseCase.unsubscribe();
  }
}
