import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_votlin_app/core/data/network/core_http_client.dart';

class DioHttpClient implements CoreHttpClient {
  final Dio dio;

  DioHttpClient(this.dio);

  @override
  Future get(String url) async {
    final response =
        await dio.get(url).timeout(Duration(seconds: 10)).catchError((error) {
      String msg;
      if (error is TimeoutException) {
        msg = "Time out requesting $url";
        throw HttpClientException.message(msg);
      } else {
        msg = "Unhandled error requesting $url";
        throw HttpClientException.exception(error);
      }
    });
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.data;
    } else {
      throw HttpClientException.message(
        "Invalid response status code requesting $url. Status code:" +
            response.statusCode.toString(),
      );
    }
  }
}
