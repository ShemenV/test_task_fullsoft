import 'package:dio/dio.dart';
import 'package:test_task/features/auth/domain/entities/entities.dart';

abstract interface class UserRepositoryI {
  Future<User?> getUserByEmail(String email, {CancelToken? cancelToken});
  Future<int?> getCurrentUserId();
}
