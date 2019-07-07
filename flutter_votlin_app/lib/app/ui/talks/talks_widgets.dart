import 'package:domain/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/core/navigation/app_navigator.dart';
import 'package:flutter_votlin_app/app/styles/styles.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TalkListWidget extends StatelessWidget {
  final List<Talk> talkList;
  final Function onRefresh;

  TalkListWidget({
    Key key,
    @required this.talkList,
    @required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: talkList.length,
          itemBuilder: (context, index) => talkItem(context, talkList[index]),
        ),
      ),
      onRefresh: () async {
        onRefresh();
        return;
      },
    );
  }

  Widget talkItem(BuildContext context, Talk talk) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: <Widget>[_talkHeader(talk), _speakers(talk)],
        ),
      ),
      onTap: () => AppNavigator.goToTalkDetail(context, talk),
    );
  }

  Container _talkHeader(Talk talk) {
    return Container(
      width: double.infinity,
      color: _talkHeaderContainerColor(talk),
      padding: const EdgeInsets.all(10.0),
      child: Text(
        talk.name,
        softWrap: true,
        style: _talkHeaderTitleStyle(talk),
      ),
    );
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

  TextStyle _talkHeaderTitleStyle(Talk talk) {
    switch (talk.track) {
      case Track.ALL:
        return Styles.styleTalkTitle;
      case Track.BUSINESS:
        return Styles.styleTalkTitle;
      case Track.DEVELOPMENT:
        return Styles.styleDarkTalkTitle;
      case Track.MAKER:
        return Styles.styleTalkTitle;
    }
  }

  Widget _speakers(Talk talk) {
    if (talk.speakers.isNotEmpty) {
      return ListView.builder(
          padding: EdgeInsets.all(10.0),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: talk.speakers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: [
                  _speakerAvatar(talk.speakers[index]),
                  _speakerName(talk.speakers[index]),
                ],
              ),
            );
          });
    } else {
      return Container();
    }
  }

  Widget _speakerAvatar(Speaker speaker) {
    if (speaker.photoUrl.isEmpty) {
      return Container(
        width: 24.0,
        height: 24.0,
      );
    } else {
      return Center(
        child: Container(
          padding: EdgeInsets.only(top: 8.0),
          child: Container(
            width: 24.0,
            height: 24.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Icon(Icons.account_circle),
                  imageUrl: speaker.photoUrl,
                )),
          ),
        ),
      );
    }
  }

  Widget _speakerName(Speaker speaker) {
    return Container(
      margin: EdgeInsets.only(left: 4.0),
      child: Text(speaker.name),
    );
  }
}
