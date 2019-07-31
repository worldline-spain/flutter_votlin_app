import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/core/stream_builder/stream_builder_pattern.dart';
import 'package:flutter_votlin_app/features/talks/models.dart';
import 'package:flutter_votlin_app/app/styles/styles.dart';
import 'package:flutter_votlin_app/app/ui/common/common_widgets.dart';
import 'package:flutter_votlin_app/app/ui/talk_detail/talk_detail_model.dart';
import 'package:flutter_votlin_app/app/ui/talk_detail/talk_detail_widgets.dart';

class TalkDetailScreen extends StatefulWidget {
  final Talk talk;

  TalkDetailScreen(this.talk);

  @override
  _TalkDetailScreenState createState() =>
      _TalkDetailScreenState(TalkDetailModel());
}

class _TalkDetailScreenState
    extends StreamBuilderState<TalkDetailScreen, TalkDetailModel> {

  _TalkDetailScreenState(UiModel uiModel) : super(uiModel);

  @override
  void onInitState() {
    model.getTalkDetail(widget.talk);
  }

  @override
  Widget build(BuildContext context) {
    return StateProvider<TalkDetailState>(
        model: model,
        builder: (context, state) {
          switch (state) {
            case TalkDetailState.LOADING_TALK_DETAIL:
              return stateLoading();

            case TalkDetailState.SHOW_ERROR_TALK_DETAIL:
              return stateShowError();

            case TalkDetailState.SHOW_TALK_DETAIL:
              return stateShowTalkDetail();
          }
        });
  }

  Widget stateLoading() {
    return Scaffold(body: LoadingWidget());
  }

  Widget stateShowError() {
    return Scaffold(
        body: NetworkErrorWidget(
      onPressed: () => model.getTalkDetail(widget.talk),
    ));
  }

  Widget stateShowTalkDetail() {
    return Scaffold(
        appBar: AppBar(
          title: Text(model.talk.name),
          backgroundColor: _talkHeaderContainerColor(model.talk),
        ),
        body: TalkDetailWidget(
          talk: model.talk,
          onRatingChanged: (newTalkRating) => model.rateTalk(newTalkRating),
        ));
  }

  Color _talkHeaderContainerColor(Talk talk) {
    switch (talk.track) {
      case Track.ALL:
        return Styles.colorTrackAll;
      case Track.BUSINESS:
        return Styles.colorTrackBusiness;
      case Track.DEVELOPMENT:
        return Styles.trackDevelopment;
      case Track.MAKER:
        return Styles.trackMaker;
    }
  }
}
