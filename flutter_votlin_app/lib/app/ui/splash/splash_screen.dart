import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/core/navigation/app_navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startSplashTimeout();
  }

  _startSplashTimeout() {
    Timer(Duration(seconds: 2), () {
      AppNavigator.goToTalks(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: FlutterLogo(
          size: 100.0,
        ),
      ),
    );
  }
}
