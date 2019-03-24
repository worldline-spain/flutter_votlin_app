import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/core/stream_builder/stream_builder_pattern.dart';
import 'package:flutter_votlin_app/app/ui/common/common_widgets.dart';
import 'package:flutter_votlin_app/app/ui/talks/talks_model.dart';
import 'package:flutter_votlin_app/app/ui/talks/talks_widgets.dart';

class TalksScreen extends StatefulWidget {
  @override
  _TalksScreenState createState() => _TalksScreenState();
}

class _TalksScreenState extends StreamBuilderState<TalksScreen> {
  TalksModel model;

  _TalksScreenState() {
    model = TalksModel();
  }

  @override
  UiModel getUiModel() {
    return model;
  }

  @override
  void onInitState() {
    model.getAllTalks();
  }

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
            body: StreamBuilder<CurrentState>(
              initialData: CurrentState.LOADING_TALKS,
              stream: model.uiStateStream(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  switch (asyncSnapshot.data) {
                    case CurrentState.LOADING_TALKS:
                      return LoadingWidget();

                    case CurrentState.SHOW_ERROR_TALKS:
                      return NetworkErrorWidget(
                          onPressed: () => model.getAllTalks());

                    case CurrentState.SHOW_TALKS:
                      return talksTabBarView();
                  }
                }
              },
            )));
  }

  TabBarView talksTabBarView() {
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
  }
}
