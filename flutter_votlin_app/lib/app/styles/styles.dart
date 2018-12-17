import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Styles {
  static final baseTextStyle = const TextStyle();

  static final styleTalkTitle = baseTextStyle.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    color: Colors.white,
  );

  static final styleDarkTalkTitle = baseTextStyle.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    color: colorDarkTitle,
  );

  static final styleError = baseTextStyle.copyWith(
    fontSize: 20.0,
    color: colorPrimary,
  );

  static const colorPrimary = Color(0xFF031137);
  static const colorAccent = Color(0xFFFF5B00);
  static const colorTrackAll = Color(0xFF7B6BFF);
  static const colorTrackBusiness = Color(0xFF4B86EA);
  static const trackDevelopment = Color(0xFFF3C12D);
  static const trackMaker = Color(0xFFD9313A);
  static const colorDarkTitle = Color(0xFF000000);
  static const colorDarkSubtitle = Color(0xFF404040);

  static const colorButtonBackground = colorPrimary;
  static const colorButtonText = Colors.white;
}
