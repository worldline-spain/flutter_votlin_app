import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/app.dart';
import 'package:flutter_votlin_app/core/config/config.dart';

void main() async {
  Config.flavor = Flavor.PLATFORM;
  await MyApp.init();
  runApp(MyApp());
}
