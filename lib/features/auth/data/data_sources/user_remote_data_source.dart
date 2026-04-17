import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';
import 'package:test_task/features/auth/data/models/user_model/user_model.dart';
import 'package:test_task/features/core/core.dart';

@injectable
class UserRemoteDataSource {
  final Talker logger;
  final ApiClientI apiClient;

  UserRemoteDataSource({required this.apiClient, required this.logger});

  Future<UserModel?> getUserByEmail({
    required String email,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await apiClient.get(
        "/users",
        queryParameters: {"email": email},
      );

      final dataList = response.data as List<dynamic>;

      if (dataList.isEmpty) return null;

      return UserModel.fromJson(dataList.first);
    } on DioException catch (error, stack) {
      logger.error(error, stack);
      rethrow;
    } catch (error, stack) {
      logger.error(error, stack);
      rethrow;
    }
  }
}
