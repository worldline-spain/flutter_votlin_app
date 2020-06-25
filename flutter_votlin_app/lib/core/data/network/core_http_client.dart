import 'dart:async';

abstract class CoreHttpClient {
  Future get(String url);
}

class HttpClientException implements Exception {
  String message = "";
  Exception exception;

  HttpClientException.message(this.message);

  HttpClientException.exception(this.exception);

  @override
  String toString() {
    if (message.isNotEmpty) {
      return 'HttpClientException{message: $message}';
    } else {
      return 'HttpClientException{exception: $exception}';
    }
  }
}
