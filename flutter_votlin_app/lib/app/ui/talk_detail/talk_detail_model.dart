import 'package:flutter_votlin_app/core/injection/injector.dart';
import 'package:flutter_votlin_app/core/stream_builder/stream_builder_pattern.dart';
import 'package:flutter_votlin_app/features/talks/models.dart';
import 'package:flutter_votlin_app/features/talks/interactor/get_talk_detail_use_case.dart';
import 'package:flutter_votlin_app/features/talks/interactor/rate_talk_use_case.dart';

enum TalkDetailState {
  LOADING_TALK_DETAIL,
  SHOW_TALK_DETAIL,
  SHOW_ERROR_TALK_DETAIL
}

class TalkDetailModel extends UiModel<TalkDetailState> {
  GetTalkDetailUseCase getTalkDetailUseCase;
  RateTalkUseCase rateTalkUseCase;

  Talk talk;
  TalkRating talkRating;

  TalkDetailModel() {
    this.getTalkDetailUseCase = GetTalkDetailUseCase(Injector.talksRepository);
    this.rateTalkUseCase = RateTalkUseCase(Injector.talksRepository);
  }

  @override
  TalkDetailState initialState() {
    return TalkDetailState.LOADING_TALK_DETAIL;
  }

  void getTalkDetail(Talk talk) {
    getTalkDetailUseCase.execute(
      params: talk,
      onData: (response) {
        print('onData');
        this.talk = response.talk;

        show(TalkDetailState.SHOW_TALK_DETAIL);
      },
      onDone: () => print('onDone'),
      onError: (error) {
        print('onError');

        show(TalkDetailState.SHOW_ERROR_TALK_DETAIL);
      },
    );
  }

  void rateTalk(TalkRating talkRating) {
    this.talk.rating = talkRating;
    show(TalkDetailState.SHOW_TALK_DETAIL);

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
