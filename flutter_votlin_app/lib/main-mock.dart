import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/app.dart';
import 'package:data/core/config/config.dart';

void main() async {
  Config.flavor = Flavor.MOCK;
  await MyApp.init();
  runApp(MyApp());
}
