import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/core/navigation/app_navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _flutterLogoAnimationController;
  AnimationController _kotlinLogoAnimationController;
  Animation flutterLogoAnimation;
  Animation kotlinLogoAnimation;

  @override
  void initState() {
    super.initState();
    setupFlutterLogoAnimation();
    setupKotlinLogoAnimation();
    _flutterLogoAnimationController.forward();
  }

  void setupFlutterLogoAnimation() {
    final int animationDuration = 2000;
    _flutterLogoAnimationController = AnimationController(
        vsync: this, duration: new Duration(milliseconds: animationDuration));

    flutterLogoAnimation = Tween(
      begin: 0.0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: _flutterLogoAnimationController,
        curve: Curves.linear,
      ),
    );
    flutterLogoAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _kotlinLogoAnimationController.forward();
      }
    });
  }

  void setupKotlinLogoAnimation() {
    final int animationDuration = 2000;
    _kotlinLogoAnimationController = AnimationController(
        vsync: this, duration: new Duration(milliseconds: animationDuration));
    kotlinLogoAnimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _kotlinLogoAnimationController,
        curve: Curves.linear,
      ),
    );
    kotlinLogoAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(Duration(seconds: 1), () {
          AppNavigator.goToTalks(context);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _flutterLogoAnimationController.dispose();
    _kotlinLogoAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          flutterLogo(),
          kotlinLogo(),
        ],
      ),
    );
  }

  Widget flutterLogo() {
    return AnimatedBuilder(
      animation: flutterLogoAnimation,
      builder: (context, widget) {
        return Transform.translate(
          offset: Offset(0.0, flutterLogoAnimation.value),
          child: Container(
            alignment: Alignment.topCenter,
            child: FlutterLogo(
              size: 100.0,
            ),
          ),
        );
      },
    );
  }

  Widget kotlinLogo() {
    return AnimatedBuilder(
      animation: kotlinLogoAnimation,
      builder: (context, widget) {
        return Center(
          child: FadeTransition(
              opacity: kotlinLogoAnimation,
              child: Image.asset("assets/kotlin.png")),
        );
      },
    );
  }
}
