import 'dart:async';

import 'package:domain/interactor/composite_subscription.dart';

/// Interactor used when we need execute some use case without params.
/// Param R: Response param. Can be a primitive type or can be a class
/// ### Example
/// class GetAllTalksUseCase extends FutureInteractorNoParams<GetAllTalksResponse>
abstract class FutureInteractorNoParams<R> {
  CompositeSubscription compositeSubscription = CompositeSubscription();

  void execute({
    void onData(R event),
    Function onError,
    void onDone(),
    bool cancelOnError,
  }) {
    _clearSubscription();
    StreamSubscription<R> streamSubscription = run().asStream().listen(
      onData,
      onError: onError,
      onDone: () {
        _clearSubscription();
        onDone();
      },
      cancelOnError: cancelOnError,
    );
    compositeSubscription.add(streamSubscription);
  }

  void unsubscribe() {
    _clearSubscription();
  }

  void _clearSubscription() {
    if (compositeSubscription != null) {
      compositeSubscription.clear();
    }
  }

  Future<R> run();
}
