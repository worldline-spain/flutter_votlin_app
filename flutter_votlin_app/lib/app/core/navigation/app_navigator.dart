import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/domain/model/models.dart';
import 'package:flutter_votlin_app/app/ui/talk_detail/talk_detail_screen.dart';
import 'package:flutter_votlin_app/app/ui/talks/talks_screen.dart';

class AppNavigator {
  static void goToTalks(context) {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => TalksScreen()));
  }

  static void goToTalkDetail(context, Talk talk) {
    if (talk.description.isNotEmpty) {
      Navigator.of(context).push(
          new MaterialPageRoute(builder: (context) => TalkDetailScreen(talk)));
    }
  }

  static void back(context) {
    Navigator.pop(context);
  }
}
