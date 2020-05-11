import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/domain/models.dart';
import 'package:flutter_votlin_app/app/components/common_widgets.dart';
import 'package:flutter_votlin_app/app/screens/talks/talks_model.dart';
import 'package:flutter_votlin_app/app/screens/talks/talks_widgets.dart';
import 'package:provider/provider.dart';

class TalksScreen extends StatefulWidget {
  @override
  _TalksScreenState createState() => _TalksScreenState();
}

class _TalksScreenState extends State<TalksScreen> {
  TalksModel model;

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
            body: ChangeNotifierProvider<TalksModel>(
              create: (_) => TalksModel()..getAllTalks(),
              child: Consumer<TalksModel>(
                  builder: (context, TalksModel model, child) {
                this.model = model;
                return buildBody(model.currentState);
              }),
            )));
  }

  Widget buildBody(TalksState state) {
    switch (state) {
      case TalksState.LOADING_TALKS:
        return stateLoading();

      case TalksState.SHOW_ERROR_TALKS:
        return stateShowError();

      case TalksState.SHOW_TALKS:
        return stateShowTalks();
    }
    return Container();
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
