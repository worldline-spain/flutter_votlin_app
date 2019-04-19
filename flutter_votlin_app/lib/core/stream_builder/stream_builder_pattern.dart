import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class UiModel<ST> {
  final _currentStateSubject = BehaviorSubject<ST>();

  Stream<ST> uiStateStream() => _currentStateSubject.stream;

  void show(ST newState) {
    _currentStateSubject.add(newState);
  }

  void destroy();
}

abstract class StreamBuilderState<SW extends StatefulWidget> extends State<SW> {
  @override
  void initState() {
    super.initState();
    onInitState();
  }

  @override
  void dispose() {
    super.dispose();
    if (getUiModel() != null) {
      getUiModel().destroy();
    }
  }

  UiModel getUiModel();

  void onInitState();
}
