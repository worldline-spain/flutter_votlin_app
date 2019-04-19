import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/app.dart';
import 'package:flutter_votlin_app/data/core/config/config.dart';

void main() async {
  Config.flavor = Flavor.LOCALHOST_EMULATOR;
  await MyApp.init();
  runApp(MyApp());
}
