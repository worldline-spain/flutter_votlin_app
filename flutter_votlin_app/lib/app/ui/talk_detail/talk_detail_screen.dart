import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/core/scoped_model/scoped_model_pattern.dart';
import 'package:flutter_votlin_app/app/styles/styles.dart';
import 'package:flutter_votlin_app/app/ui/common/common_widgets.dart';
import 'package:flutter_votlin_app/app/ui/talk_detail/talk_detail_model.dart';
import 'package:flutter_votlin_app/app/ui/talk_detail/talk_detail_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class TalkDetailScreen extends StatefulWidget {
  final Talk talk;

  TalkDetailScreen(this.talk);

  @override
  _TalkDetailScreenState createState() => _TalkDetailScreenState(talk);
}

class _TalkDetailScreenState extends BaseScopedModelState<TalkDetailScreen> {
  Talk talk;
  TalkDetailModel model;

  _TalkDetailScreenState(Talk talk) {
    this.talk = talk;
    this.model = TalkDetailModel();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TalkDetailModel>(
      model: model,
      child: _TalkDetailScreenContent(talk),
    );
  }

  @override
  void onInitState() {
    model.getTalkDetail(widget.talk);
  }

  @override
  void onDispose() {
    model.destroy();
  }
}

class _TalkDetailScreenContent extends StatefulWidget {
  Talk talk;

  _TalkDetailScreenContent(this.talk);

  @override
  __TalkDetailScreenContentState createState() =>
      __TalkDetailScreenContentState();
}

class __TalkDetailScreenContentState extends State<_TalkDetailScreenContent> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TalkDetailModel>(
        builder: (BuildContext context, Widget child, TalkDetailModel model) {
      print('onBuild: ' + model.currentState.toString());

      if (model.showLoading) {
        return Scaffold(body: LoadingWidget());
      }

      if (model.showError) {
        return Scaffold(
            body: NetworkErrorWidget(
          onPressed: () => model.getTalkDetail(widget.talk),
        ));
      }

      return Scaffold(
          appBar: AppBar(
            title: Text(model.talk.name),
            backgroundColor: _talkHeaderContainerColor(model.talk),
          ),
          body: TalkDetailWidget(
            talk: model.talk,
            onRatingChanged: (newTalkRating) => model.rateTalk(newTalkRating),
          ));
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
