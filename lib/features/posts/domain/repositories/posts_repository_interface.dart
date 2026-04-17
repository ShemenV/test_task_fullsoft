import 'package:dio/dio.dart';
import 'package:test_task/features/posts/domain/entities/entities.dart';

abstract interface class PostsRepositoryI {
  Future<List<Post>> getPosts(int page, {CancelToken? cancelToken});
  Future<List<Comment>> getComments({
    required int postId,
    CancelToken? cancelToken,
  });
}
