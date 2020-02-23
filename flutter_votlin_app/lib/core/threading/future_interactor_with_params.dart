import 'dart:async';
import 'package:flutter_votlin_app/core/threading/composite_subscription.dart';
/// Interactor used when we need execute some use case with input params
/// Left param(L): Response param. Can be a primitive type or can be a class
/// Right param (R): Input param. Can be a primitive type or can be a class
/// ### Example
/// class GetTalksByTrackUseCase extends FutureInteractorWithParams<GetTalksByTrackResponse, Track> {
abstract class FutureInteractorWithParams<L, R> {
  CompositeSubscription compositeSubscription = CompositeSubscription();

  void execute({
    R params,
    void onData(L event),
    Function onError,
    void onDone(),
    bool cancelOnError,
  }) {
    _clearSubscription();
    StreamSubscription<L> streamSubscription = run(params).asStream().listen(
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

  Future<L> run(R params);
}
