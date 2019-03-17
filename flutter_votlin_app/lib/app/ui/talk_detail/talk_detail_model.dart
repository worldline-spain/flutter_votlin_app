import 'package:domain/interactor/talks/get_talk_detail_use_case.dart';
import 'package:domain/interactor/talks/rate_talk_use_case.dart';
import 'package:domain/model/models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_votlin_app/app/core/injection/injector.dart';
import 'package:flutter_votlin_app/app/core/scoped_model/scoped_model_pattern.dart';
import 'package:scoped_model/scoped_model.dart';

enum _CurrentState {
  LOADING_TALK_DETAIL,
  SHOW_TALK_DETAIL,
  SHOW_ERROR_TALK_DETAIL
}

class TalkDetailModel extends BaseScopedModel {
  static TalkDetailModel of(BuildContext context) =>
      ScopedModel.of<TalkDetailModel>(context);

  GetTalkDetailUseCase getTalkDetailUseCase;
  RateTalkUseCase rateTalkUseCase;

  _CurrentState currentState;
  Talk talk;
  TalkRating talkRating;

  TalkDetailModel() {
    this.getTalkDetailUseCase = GetTalkDetailUseCase(Injector.talksRepository);
    this.rateTalkUseCase = RateTalkUseCase(Injector.talksRepository);
  }

  bool get showLoading => currentState == _CurrentState.LOADING_TALK_DETAIL;

  bool get showTalkDetail => currentState == _CurrentState.SHOW_TALK_DETAIL;

  bool get showError => currentState == _CurrentState.SHOW_ERROR_TALK_DETAIL;

  void getTalkDetail(Talk talk) {
    currentState = _CurrentState.LOADING_TALK_DETAIL;
    notifyListeners();

    getTalkDetailUseCase.execute(
      params: talk,
      onData: (response) {
        print('onData');
        this.talk = response.talk;

        currentState = _CurrentState.SHOW_TALK_DETAIL;
        notifyListeners();
      },
      onDone: () => print('onDone'),
      onError: (error) {
        print('onError');

        currentState = _CurrentState.SHOW_ERROR_TALK_DETAIL;
        notifyListeners();
      },
    );
  }

  void rateTalk(TalkRating talkRating) {
    this.talk.rating = talkRating;
    currentState = _CurrentState.SHOW_TALK_DETAIL;
    notifyListeners();

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
