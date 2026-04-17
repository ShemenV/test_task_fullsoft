import 'package:dio/dio.dart';
import 'package:dio/src/options.dart';
import 'package:dio/src/response.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task/features/core/network/api_client/api_client_interface.dart';

@LazySingleton(as: ApiClientI)
class DioApiClient implements ApiClientI {
  final Dio _dio;
  DioApiClient(this._dio);

  @override
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final response = await _dio.get(
      url,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );

    return response;
  }

  @override
  Future<Response> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final response = await _dio.patch(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );

    return response;
  }

  @override
  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final response = await _dio.post(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );

    return response;
  }

  @override
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final response = await _dio.put(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );

    return response;
  }

  @override
  Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final response = await _dio.delete(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );

    return response;
  }
}
