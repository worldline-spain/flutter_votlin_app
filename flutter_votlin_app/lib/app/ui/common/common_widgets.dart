import 'package:flutter/material.dart';
import 'package:flutter_votlin_app/app/styles/styles.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class NetworkErrorWidget extends StatelessWidget {
  final Function onPressed;

  NetworkErrorWidget({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 24.0),
              child: Icon(
                Icons.mood_bad,
                size: 100.0,
              )),
          Container(
              margin: EdgeInsets.only(bottom: 12.0),
              child: Text("Something went wrong", style: Styles.styleError)),
          Container(
              margin: EdgeInsets.only(bottom: 12.0),
              child: Text("Please review your connection",
                  style: Styles.styleError)),
          RaisedButton(
            color: Styles.colorButtonBackground,
            textColor: Styles.colorButtonText,
            child: Text("Try again"),
            onPressed: () {
              onPressed();
            },
          )
        ],
      ),
    );
  }
}