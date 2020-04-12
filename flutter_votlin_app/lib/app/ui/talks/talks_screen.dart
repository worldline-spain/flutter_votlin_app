import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/core/stream_builder/stream_builder_pattern.dart';
import 'package:flutter_votlin_app/features/talks/models.dart';
import 'package:flutter_votlin_app/app/ui/common/common_widgets.dart';
import 'package:flutter_votlin_app/app/ui/talks/talks_model.dart';
import 'package:flutter_votlin_app/app/ui/talks/talks_widgets.dart';

class TalksScreen extends StatefulWidget {
  @override
  _TalksScreenState createState() => _TalksScreenState(TalksModel());
}

class _TalksScreenState extends StreamBuilderState<TalksScreen, TalksModel> {
  _TalksScreenState(TalksModel model) : super(model);

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
          body: StateProvider<TalksState>(
              model: model,
              builder: (context, state) {
                switch (state) {
                  case TalksState.LOADING_TALKS:
                    return stateLoading();

                  case TalksState.SHOW_ERROR_TALKS:
                    return stateShowError();

                  case TalksState.SHOW_TALKS:
                    return stateShowTalks();
                }
                return Container();
              }),
        ));
  }

  Widget stateLoading() {
    return LoadingWidget();
  }

  Widget stateShowError() {
    return NetworkErrorWidget(onPressed: () => model.getAllTalks());
  }

  Widget stateShowTalks() {
    return TabBarView(
      children: <Widget>[
        TalkListWidget(
            talkList: model.allTalks,
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
