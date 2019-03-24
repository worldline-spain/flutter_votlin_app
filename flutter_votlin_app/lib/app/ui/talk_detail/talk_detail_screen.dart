import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/core/stream_builder/stream_builder_pattern.dart';
import 'package:flutter_votlin_app/app/styles/styles.dart';
import 'package:flutter_votlin_app/app/ui/common/common_widgets.dart';
import 'package:flutter_votlin_app/app/ui/talk_detail/talk_detail_model.dart';
import 'package:flutter_votlin_app/app/ui/talk_detail/talk_detail_widgets.dart';

class TalkDetailScreen extends StatefulWidget {

  final Talk talk;

  TalkDetailScreen(this.talk);

  @override
  _TalkDetailScreenState createState() => _TalkDetailScreenState();
}

class _TalkDetailScreenState extends StreamBuilderState<TalkDetailScreen> {
  TalkDetailModel model;

  _TalkDetailScreenState() {
    this.model = TalkDetailModel();
  }

  @override
  UiModel getUiModel() {
    return model;
  }

  @override
  void onInitState() {
    model.getTalkDetail(widget.talk);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CurrentState>(
        initialData: CurrentState.LOADING_TALK_DETAIL,
        stream: model.uiStateStream(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            switch (asyncSnapshot.data) {
              case CurrentState.LOADING_TALK_DETAIL:
                return Scaffold(body: LoadingWidget());

              case CurrentState.SHOW_ERROR_TALK_DETAIL:
                return Scaffold(
                    body: NetworkErrorWidget(
                      onPressed: () => model.getTalkDetail(widget.talk),
                    ));

              case CurrentState.SHOW_TALK_DETAIL:
                return Scaffold(
                    appBar: AppBar(
                      title: Text(model.talk.name),
                      backgroundColor: _talkHeaderContainerColor(model.talk),
                    ),
                    body: TalkDetailWidget(
                      talk: model.talk,
                      onRatingChanged: (newTalkRating) =>
                          model.rateTalk(newTalkRating),
                    ));
            }
          }
        });
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