import 'package:flutter_votlin_app/app/injection/injector.dart';
import 'package:flutter_votlin_app/core/viewmodel/view_model.dart';
import 'package:flutter_votlin_app/domain/models.dart';
import 'package:flutter_votlin_app/domain/repositories.dart';

enum TalkDetailState {
  LOADING_TALK_DETAIL,
  SHOW_TALK_DETAIL,
  SHOW_ERROR_TALK_DETAIL
}

class TalkDetailModel extends ViewModel<TalkDetailState> {
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
        setState(TalkDetailState.SHOW_TALK_DETAIL);
      },
      onError: (error) {
        setState(TalkDetailState.SHOW_ERROR_TALK_DETAIL);
      },
    );
  }

  void rateTalk(TalkRating talkRating) {
    this.talk.rating = talkRating;
    setState(TalkDetailState.SHOW_TALK_DETAIL);

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
