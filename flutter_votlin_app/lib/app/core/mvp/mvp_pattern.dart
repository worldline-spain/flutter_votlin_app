import 'package:flutter/widgets.dart';

abstract class Presenter<M> {
  void destroy();

  M get model;
}

class ViewStateHolder<T> {
  T currentState;
}

abstract class MvpState<SW extends StatefulWidget, ST> extends State<SW>
    with ViewStateHolder<ST> {
  ST currentState;

  @override
  void initState() {
    super.initState();
    onInitState();
  }

  void rebuild(ST newState) {
    setState(() {
      this.currentState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return onBuild(context, currentState);
  }

  @override
  void dispose() {
    super.dispose();
    if (getPresenter() != null) {
      getPresenter().destroy();
    }
  }

  Presenter getPresenter();

  void onInitState();

  Widget onBuild(BuildContext context, ST currentState);
}
