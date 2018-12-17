import 'dart:async';
import 'dart:convert';

import 'package:data/core/network/core_http_client.dart';
import 'package:http/http.dart' as http;

class DartHttpClient implements CoreHttpClient {
  DartHttpClient();

  @override
  Future get(String url) async {
    final response =
        await http.get(url).timeout(Duration(seconds: 10)).catchError((error) {
      String msg;
      if (error is TimeoutException) {
        msg = "Time out requesting $url";
        throw DartHttpClientException.message(msg);
      } else {
        msg = "Unhandled error requesting $url";
        throw DartHttpClientException.exception(error);
      }
    });
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      throw DartHttpClientException.message(
        "Invalid response status code requesting $url. Status code:" +
            response.statusCode.toString(),
      );
    }
  }
}

class DartHttpClientException implements Exception {
  String message = "";
  Exception exception;

  DartHttpClientException.message(this.message);

  DartHttpClientException.exception(this.exception);

  @override
  String toString() {
    if (message.isNotEmpty) {
      return 'DartHttpClientException{message: $message}';
    } else {
      return 'DartHttpClientException{exception: $exception}';
    }
  }
}
