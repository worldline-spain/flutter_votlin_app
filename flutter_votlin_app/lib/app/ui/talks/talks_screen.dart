import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/core/scoped_model/scoped_model_pattern.dart';
import 'package:flutter_votlin_app/app/ui/common/common_widgets.dart';
import 'package:flutter_votlin_app/app/ui/talks/talks_model.dart';
import 'package:flutter_votlin_app/app/ui/talks/talks_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class TalksScreen extends StatefulWidget {
  @override
  _TalksState createState() => _TalksState();
}

class _TalksState extends BaseScopedModelState<TalksScreen> {
  TalksModel model;

  _TalksState() {
    model = TalksModel();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TalksModel>(
      model: model,
      child: _TalksScreenContent(),
    );
  }

  @override
  void onInitState() {
    model.getAllTalks();
  }

  @override
  void onDispose() {
    model.destroy();
  }
}

class _TalksScreenContent extends StatefulWidget {
  @override
  __TalksScreenContentState createState() => __TalksScreenContentState();
}

class __TalksScreenContentState extends State<_TalksScreenContent> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              title: Text("Flutter Votlin"),
              bottom: TabBar(isScrollable: true, tabs: [
                Tab(text: "ALL"),
                Tab(text: "BUSINESS"),
                Tab(text: "DEVELOPMENT"),
                Tab(text: "MAKER"),
              ])),
          body: widgetSelector(),
        ));
  }

  Widget widgetSelector() {
    return ScopedModelDescendant<TalksModel>(
        builder: (BuildContext context, Widget child, TalksModel model) {
      print('onBuild: ' + model.currentState.toString());

      if (model.showLoading) {
        return LoadingWidget();
      }
      if (model.showError) {
        return NetworkErrorWidget(onPressed: () => model.getAllTalks());
      }

      return TabBarView(
        children: <Widget>[
          TalkListWidget(
              talkList: model.alltalks,
              onRefresh: () => model.onTrackSelected(Track.ALL)),
          TalkListWidget(
              talkList: model.businessTalks,
              onRefresh: () => model.onTrackSelected(Track.BUSINESS)),
          TalkListWidget(
              talkList: model.developmentTalks,
              onRefresh: () => model.onTrackSelected(Track.DEVELOPMENT)),
          TalkListWidget(
              talkList: model.makerTalks,
              onRefresh: () => model.onTrackSelected(Track.MAKER))
        ],
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    TalksModel.of(context).destroy();
  }
}
