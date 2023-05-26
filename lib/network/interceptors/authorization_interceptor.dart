import 'package:dio/dio.dart';

// ignore: constant_identifier_names //Fetch from api this is for example
// const String API_KEY =
//     'cdc9a8ca8aa17b6bed3aa3611a835105bbb4632514d7ca8cf55dbbc5966a7cae';

//* Request methods PUT, POST, PATCH, DELETE needs access token,
//* which needs to be passed with "Authorization" header as Bearer token.
class AuthorizationInterceptor extends Interceptor {
  String token;

  AuthorizationInterceptor({required this.token});
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_needAuthorizationHeader(options)) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  bool _needAuthorizationHeader(RequestOptions options) {
    if (options.method == 'GET') {
      return false;
    } else {
      return true;
    }
  }
}
