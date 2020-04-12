import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class UiModel<ST> {
  final _currentStateSubject = BehaviorSubject<ST>();

  Stream<ST> uiStateStream() => _currentStateSubject.stream;

  void show(ST newState) {
    _currentStateSubject.add(newState);
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

  void unsubscribe() {
    clearSubscription();
  }

  void clearSubscription() {
    if (compositeSubscription != null) {
      compositeSubscription.clear();
    }
  }

  ST initialState();

  void destroy();
}

abstract class StreamBuilderState<SW extends StatefulWidget, M extends UiModel>
    extends State<SW> {
  M _uiModel;

  StreamBuilderState(UiModel uiModel) {
    this._uiModel = uiModel;
  }

  M get model => _uiModel;

  @override
  void initState() {
    super.initState();
    onInitState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_uiModel != null) {
      _uiModel.clearSubscription();
      _uiModel.destroy();
    }
  }

  void onInitState();
}

class StateProvider<ST> extends StreamBuilder<ST> {
  StateProvider({
    Key key,
    @required UiModel model,
    @required Function builder,
  })  : assert(builder != null),
        super(
        key: key,
        initialData: model.initialState(),
        stream: model.uiStateStream(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            return builder(context, asyncSnapshot.data);
          } else {
            return Container();
          }
        },
      );
}
