import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task/features/core/network/api_client/api_client_interface.dart';
import 'package:test_task/features/posts/data/models/comment_model/comment_model.dart';
import 'package:test_task/features/posts/data/models/post_model/post_model.dart';

@injectable
class PostsRemoteDataSource {
  final ApiClientI apiClient;

  PostsRemoteDataSource({required this.apiClient});

  Future<List<PostModel>> getPosts({
    required int page,
    int limit = 10,
    CancelToken? cancelToken,
  }) async {
    ;
    try {
      final response = await apiClient.get(
        "/posts",
        queryParameters: {"_start": (page - 1) * limit, "_limit": limit},
      );

      final data = response.data as List<dynamic>;
      return data
          .map<PostModel>((element) => PostModel.fromJson(element))
          .toList();
    } on DioException catch (error, stack) {
      rethrow;
    } catch (error, stack) {
      rethrow;
    }
  }

  Future<List<CommentModel>> getComments({
    required int postId,
    CancelToken? cancelToken,
  }) async {
    ;
    try {
      final response = await apiClient.get("/posts/$postId/comments");

      final data = response.data as List<dynamic>;
      return data
          .map<CommentModel>((element) => CommentModel.fromJson(element))
          .toList();
    } on DioException catch (error, stack) {
      rethrow;
    } catch (error, stack) {
      rethrow;
    }
  }
}
