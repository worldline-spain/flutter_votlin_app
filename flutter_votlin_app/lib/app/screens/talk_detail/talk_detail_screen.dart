import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/domain/models.dart';
import 'package:flutter_votlin_app/app/styles/styles.dart';
import 'package:flutter_votlin_app/app/components/common_widgets.dart';
import 'package:flutter_votlin_app/app/screens/talk_detail/talk_detail_model.dart';
import 'package:flutter_votlin_app/app/screens/talk_detail/talk_detail_widgets.dart';

import 'package:provider/provider.dart';

class TalkDetailScreen extends StatefulWidget {
  final Talk talk;

  TalkDetailScreen(this.talk);

  @override
  _TalkDetailScreenState createState() => _TalkDetailScreenState();
}

class _TalkDetailScreenState extends State<TalkDetailScreen> {
  TalkDetailModel model;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TalkDetailModel>(
      create: (_) => TalkDetailModel()..getTalkDetail(widget.talk),
      child: Consumer<TalkDetailModel>(builder: (context, model, child) {
        this.model = model;
        return buildBody(context, model.currentState);
      }),
    );
  }

  Widget buildBody(BuildContext context, TalkDetailState state) {
    switch (state) {
      case TalkDetailState.LOADING_TALK_DETAIL:
        return stateLoading();

      case TalkDetailState.SHOW_ERROR_TALK_DETAIL:
        return stateShowError();

      case TalkDetailState.SHOW_TALK_DETAIL:
        return stateShowTalkDetail();
    }
    return Container();
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
