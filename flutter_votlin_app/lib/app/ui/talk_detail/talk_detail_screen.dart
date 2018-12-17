import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/styles/styles.dart';
import 'package:flutter_votlin_app/app/ui/common/common_widgets.dart';
import 'package:flutter_votlin_app/app/ui/talk_detail/talk_detail_presenter.dart';
import 'package:flutter_votlin_app/app/core/mvp/mvp_pattern.dart';
import 'package:flutter_votlin_app/app/ui/talk_detail/talk_detail_widgets.dart';

enum _ViewStates {
  LOADING_TALK_DETAIL,
  SHOW_TALK_DETAIL,
  SHOW_ERROR_TALK_DETAIL
}

class TalkDetailScreen extends StatefulWidget {
  final Talk talk;

  TalkDetailScreen(this.talk);

  @override
  _TalkDetailScreenState createState() => _TalkDetailScreenState();
}

class _TalkDetailScreenState extends MvpState<TalkDetailScreen, _ViewStates>
    implements TalkDetailView {
  TalkDetailPresenter _presenter;

  _TalkDetailScreenState() {
    this._presenter = TalkDetailPresenter(this);
  }

  @override
  void onInitState() {
    _presenter.getTalkDetail(widget.talk);
  }

  @override
  Presenter getPresenter() {
    return _presenter;
  }

  @override
  Widget onBuild(BuildContext context, _ViewStates currentState) {
    print('onBuild: ' + currentState.toString());
    return widgetSelector(currentState);
  }

  Widget widgetSelector(_ViewStates currentState) {
    switch (currentState) {
      case _ViewStates.LOADING_TALK_DETAIL:
        return Scaffold(body: LoadingWidget());
      case _ViewStates.SHOW_TALK_DETAIL:
        return Scaffold(
            appBar: AppBar(
              title: Text(_presenter.model.talk.name),
              backgroundColor: _talkHeaderContainerColor(_presenter.model.talk),
            ),
            body: TalkDetailWidget(
              talk: _presenter.model.talk,
              onRatingChanged: (newTalkRating) =>
                  _presenter.rateTalk(newTalkRating),
            ));
      case _ViewStates.SHOW_ERROR_TALK_DETAIL:
        return Scaffold(
          body: NetworkErrorWidget(
              onPressed: () => _presenter.getTalkDetail(widget.talk)),
        );
    }
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

  @override
  void showLoading() {
    rebuild(_ViewStates.LOADING_TALK_DETAIL);
  }

  @override
  void showTalkDetail() {
    rebuild(_ViewStates.SHOW_TALK_DETAIL);
  }

  @override
  void showError() {
    rebuild(_ViewStates.SHOW_ERROR_TALK_DETAIL);
  }
}
