import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/ui/common/common_widgets.dart';
import 'package:flutter_votlin_app/app/ui/talks/talks_presenter.dart';
import 'package:flutter_votlin_app/app/core/mvp/mvp_pattern.dart';
import 'package:flutter_votlin_app/app/ui/talks/talks_widgets.dart';

enum _ViewStates { LOADING_TALKS, SHOW_TALKS, SHOW_ERROR_TALKS }

class TalksScreen extends StatefulWidget {
  @override
  _TalksState createState() => _TalksState();
}

class _TalksState extends MvpState<TalksScreen, _ViewStates>
    with SingleTickerProviderStateMixin
    implements TalksView {
  TalksPresenter _presenter;

  _TalksState() {
    this._presenter = new TalksPresenter(this);
  }

  @override
  Presenter getPresenter() {
    return _presenter;
  }

  @override
  void onInitState() {
    _presenter.getAllTalks();
  }

  @override
  Widget onBuild(BuildContext context, _ViewStates currentState) {
    print('onBuild: ' + currentState.toString());
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
          body: widgetSelector(currentState),
        ));
  }

  Widget widgetSelector(_ViewStates currentState) {
    switch (currentState) {
      case _ViewStates.LOADING_TALKS:
        return LoadingWidget();
      case _ViewStates.SHOW_TALKS:
        return TabBarView(
          children: <Widget>[
            TalkListWidget(
                talkList: _presenter.model.alltalks,
                onRefresh: () => _presenter.onTrackSelected(Track.ALL)),
            TalkListWidget(
                talkList: _presenter.model.businessTalks,
                onRefresh: () => _presenter.onTrackSelected(Track.BUSINESS)),
            TalkListWidget(
                talkList: _presenter.model.developmentTalks,
                onRefresh: () => _presenter.onTrackSelected(Track.DEVELOPMENT)),
            TalkListWidget(
                talkList: _presenter.model.makerTalks,
                onRefresh: () => _presenter.onTrackSelected(Track.MAKER))
          ],
        );
      case _ViewStates.SHOW_ERROR_TALKS:
        return NetworkErrorWidget(onPressed: () => _presenter.getAllTalks());
    }
  }

  @override
  void showLoading() {
    rebuild(_ViewStates.LOADING_TALKS);
  }

  @override
  void showTalks() {
    rebuild(_ViewStates.SHOW_TALKS);
  }

  @override
  void showError() {
    rebuild(_ViewStates.SHOW_ERROR_TALKS);
  }
}
