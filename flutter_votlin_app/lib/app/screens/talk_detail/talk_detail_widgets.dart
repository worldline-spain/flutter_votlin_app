import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/core/utils/url_utils.dart';
import 'package:flutter_votlin_app/domain/models.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TalkDetailWidget extends StatelessWidget {
  final Talk talk;
  final Function onRatingChanged;

  TalkDetailWidget({
    Key key,
    @required this.talk,
    @required this.onRatingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[talkDescription(), talkRating(), _speakers(talk)],
    );
  }

  Widget talkDescription() {
    return Card(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Text(talk.description),
        ));
  }

  Widget talkRating() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Center(
        child: SmoothStarRating(
          allowHalfRating: false,
          onRatingChanged: (value) {
            this.onRatingChanged(TalkRating(talkId: talk.id, value: value));
          },
          starCount: 5,
          rating: talk.rating.value,
          size: 40.0,
          color: Colors.red,
          borderColor: Colors.grey,
        ),
      ),
    );
  }

  Widget _speakers(Talk talk) {
    if (talk.speakers.isNotEmpty) {
      return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: talk.speakers.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 10.0),
              child: Column(
                children: <Widget>[
                  _speakerAvatar(talk.speakers[index]),
                  _speakerName(talk.speakers[index]),
                  _speakerBio(talk.speakers[index]),
                  _speakerSocialData(talk.speakers[index]),
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
      return CircleAvatar(
        radius: 24.0,
        child: Text(speaker.avatarInitials()),
      );
    } else {
      return Center(
        child: Container(
          padding: EdgeInsets.only(top: 8.0),
          child: Container(
            width: 48.0,
            height: 48.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
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
        padding: EdgeInsets.only(top: 8.0),
        child: Center(
            child: Text(
          speaker.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        )));
  }

  Widget _speakerBio(Speaker speaker) {
    return Container(
        padding: EdgeInsets.all(8.0), child: Center(child: Text(speaker.bio)));
  }

  Widget _speakerSocialData(Speaker speaker) {
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            assetWithUrlLaunchable(
                localAssetPath: "assets/ic_linkedin.png",
                url: speaker.linkedin),
            assetWithUrlLaunchable(
                localAssetPath: "assets/ic_twitter.png", url: speaker.twitter),
          ],
        ));
  }

  Widget assetWithUrlLaunchable({String localAssetPath, String url}) {
    if (url.isNotEmpty) {
      return GestureDetector(
        child: Container(
            margin: EdgeInsets.only(right: 30.0),
            child: Image.asset(localAssetPath)),
        onTap: () => UrlUtils.openUrl(url),
      );
    } else {
      return Container();
    }
  }
}
