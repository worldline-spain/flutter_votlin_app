import 'package:flutter_votlin_app/app/injection/injector.dart';
import 'package:flutter_votlin_app/core/stream_builder/stream_builder_pattern.dart';
import 'package:flutter_votlin_app/features/talks/models.dart';
import 'package:flutter_votlin_app/features/talks/repositories.dart';

enum TalkDetailState {
  LOADING_TALK_DETAIL,
  SHOW_TALK_DETAIL,
  SHOW_ERROR_TALK_DETAIL
}

class TalkDetailModel extends UiModel<TalkDetailState> {
  TalksRepository talksRepository;

  Talk talk;
  TalkRating talkRating;

  TalkDetailModel() {
    this.talksRepository = Injector.talksRepository;
  }

  @override
  TalkDetailState initialState() {
    return TalkDetailState.LOADING_TALK_DETAIL;
  }

  void getTalkDetail(Talk talk) {
    execute(
      talksRepository.getTalkById(talk.id),
      onData: (talk) {
        this.talk = talk;
        show(TalkDetailState.SHOW_TALK_DETAIL);
      },
      onError: (error) {
        show(TalkDetailState.SHOW_ERROR_TALK_DETAIL);
      },
    );
  }

  void rateTalk(TalkRating talkRating) {
    this.talk.rating = talkRating;
    show(TalkDetailState.SHOW_TALK_DETAIL);

    execute(
      talksRepository.rateTalk(talkRating),
      onData: (success) {
        print('onData' + " updateRatingTalk success:" + success.toString());
      },
      onError: (error) {
        print('onError');
      },
    );
  }

  @override
  void destroy() {}
}
