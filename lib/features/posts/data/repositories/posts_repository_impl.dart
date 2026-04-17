import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task/features/core/services/connectivity_service.dart';
import 'package:test_task/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:test_task/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:test_task/features/posts/data/mappers/mappers.dart';
import 'package:test_task/features/posts/domain/domain.dart';

@Injectable(as: PostsRepositoryI)
class PostsRepositoryImpl implements PostsRepositoryI {
  final PostsRemoteDataSource postsRemoteDataSource;
  final PostsLocalDataSource postsLocalDataSource;
  final ConnectivityService connectivityService;

  PostsRepositoryImpl({
    required this.postsRemoteDataSource,
    required this.postsLocalDataSource,
    required this.connectivityService,
  });

  @override
  Future<List<Post>> getPosts(int page, {CancelToken? cancelToken}) async {
    final isOnline = await connectivityService.isOnline;
    if (isOnline) {
      final models = await postsRemoteDataSource.getPosts(page: page);
      await postsLocalDataSource.savePosts(models, page);
      return models.map((e) => e.toEntity()).toList();
    } else {
      final cachedModels = await postsLocalDataSource.getPosts(page: page);
      return cachedModels.map((e) => e.toEntity()).toList();
    }
  }

  @override
  Future<List<Comment>> getComments({
    required int postId,
    CancelToken? cancelToken,
  }) async {
    final isOnline = await connectivityService.isOnline;
    if (isOnline) {
      final models = await postsRemoteDataSource.getComments(postId: postId);
      await postsLocalDataSource.saveComments(models);
      return models.map((e) => e.toEntity()).toList();
    } else {
      final cachedModels = await postsLocalDataSource.getCommentsByPostId(
        postId: postId,
      );
      return cachedModels.map((e) => e.toEntity()).toList();
    }
  }
}
