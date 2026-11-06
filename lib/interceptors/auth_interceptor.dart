import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String? apiKey;
  AuthInterceptor({this.apiKey});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (apiKey != null && apiKey!.isNotEmpty) {
      options.headers['X-Api-Key'] = apiKey;
    }
    handler.next(options);
  }
}