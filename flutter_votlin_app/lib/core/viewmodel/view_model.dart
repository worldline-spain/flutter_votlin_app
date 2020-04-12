import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class ViewModel<ST> extends ChangeNotifier {
  ST currentState;

  ViewModel() {
    this.currentState = initialState();
  }

  void show(ST newState) {
    this.currentState = newState;
    notifyListeners();
  }

  CompositeSubscription compositeSubscription = CompositeSubscription();

  void execute(
    Future future, {
    Function onData,
    Function onError,
    void onDone(),
    bool cancelOnError,
  }) {
    StreamSubscription streamSubscription = future.asStream().listen(
      onData,
      onError: onError,
      onDone: () {
        if (onDone != null) {
          onDone();
        }
      },
      cancelOnError: cancelOnError,
    );
    compositeSubscription.add(streamSubscription);
  }

  @override
  void dispose() {
    super.dispose();
    if (compositeSubscription != null) {
      compositeSubscription.clear();
    }
    destroy();
  }

  ST initialState();

  void destroy();
}
