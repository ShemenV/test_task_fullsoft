import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Connectivity connectivity() => Connectivity();

  @lazySingleton
  Dio dio() =>
      Dio(
          BaseOptions(
            baseUrl: "https://jsonplaceholder.typicode.com",
            headers: {
              'User-Agent':
                  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
              'Accept': 'application/json',
            },
          ),
        )
        ..interceptors.add(
          TalkerDioLogger(
            settings: TalkerDioLoggerSettings(
              printRequestHeaders: true,
              printRequestData: true,
              printResponseHeaders: true,
              printResponseMessage: true,
            ),
          ),
        );
}
