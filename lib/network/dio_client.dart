import 'package:dio/dio.dart';
import 'package:dio_interceptor/models/user.dart';
import 'package:dio_interceptor/network/dio_exception.dart';
import 'package:dio_interceptor/network/endpoints.dart';
import 'package:dio_interceptor/network/interceptors/authorization_interceptor.dart';
import 'package:dio_interceptor/network/interceptors/logger_interceptor.dart';
import 'package:dio_interceptor/network/interceptors/no_authorization_interceptor.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

class DioClient {
  DioClient();

  Future<User?> getUser({required int id}) async {
    try {
      final response = await myDio().get('${Endpoints.users}/$id');
      return User.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<User?> createUser({required User user}) async {
    try {
      final response = await myDio().post(Endpoints.users, data: user.toJson());
      return User.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<void> deleteUser({required int id, required String token}) async {
    try {
      await myDio(token: token).delete('${Endpoints.users}/$id');
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }
}

Dio myDio({String? token}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseURL,
      connectTimeout: Endpoints.connectionTimeout,
      receiveTimeout: Endpoints.receiveTimeout,
      responseType: ResponseType.json,
    ),
  );

  final interceptors = <Interceptor>[
    LoggerInterceptor(),
  ];

  if (token != null) {
    interceptors.add(AuthorizationInterceptor(token: token));
  } else {
    interceptors.add(NoAuthorizationInterceptor());
  }

  dio.interceptors.addAll(interceptors);

  return dio;
}
