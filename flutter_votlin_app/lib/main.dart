import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/app.dart';
import 'package:flutter_votlin_app/core/config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.flavor = Flavor.MOCK;
  await MyApp.init();
  runApp(MyApp());
}
