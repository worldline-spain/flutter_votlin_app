import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/core/injection/injector.dart';
import 'package:flutter_votlin_app/app/styles/styles.dart';
import 'package:flutter_votlin_app/app/ui/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  static init() async {
    Injector.init();
    await Injector.dbHelper.init();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Votlin',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primaryColor: Styles.colorPrimary,
      ),
      home: SplashScreen(),
    );
  }
}
