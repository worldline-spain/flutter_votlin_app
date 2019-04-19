import 'package:flutter_votlin_app/app/core/injection/injector.dart';
import 'package:flutter_votlin_app/app/core/stream_builder/stream_builder_pattern.dart';
import 'package:flutter_votlin_app/domain/model/models.dart';
import 'package:flutter_votlin_app/domain/interactor/talks/get_talk_detail_use_case.dart';
import 'package:flutter_votlin_app/domain/interactor/talks/rate_talk_use_case.dart';

enum CurrentState {
  LOADING_TALK_DETAIL,
  SHOW_TALK_DETAIL,
  SHOW_ERROR_TALK_DETAIL
}

class TalkDetailModel extends UiModel<CurrentState> {
  GetTalkDetailUseCase getTalkDetailUseCase;
  RateTalkUseCase rateTalkUseCase;

  Talk talk;
  TalkRating talkRating;

  TalkDetailModel() {
    this.getTalkDetailUseCase = GetTalkDetailUseCase(Injector.talksRepository);
    this.rateTalkUseCase = RateTalkUseCase(Injector.talksRepository);
  }

  void getTalkDetail(Talk talk) {
    show(CurrentState.LOADING_TALK_DETAIL);

    getTalkDetailUseCase.execute(
      params: talk,
      onData: (response) {
        print('onData');
        this.talk = response.talk;

        show(CurrentState.SHOW_TALK_DETAIL);
      },
      onDone: () => print('onDone'),
      onError: (error) {
        print('onError');

        show(CurrentState.SHOW_ERROR_TALK_DETAIL);
      },
    );
  }

  void rateTalk(TalkRating talkRating) {
    this.talk.rating = talkRating;
    show(CurrentState.SHOW_TALK_DETAIL);

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
