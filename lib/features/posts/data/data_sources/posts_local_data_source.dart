import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task/features/core/database/dao/comments_dao.dart';
import 'package:test_task/features/core/database/dao/posts_dao.dart';
import 'package:test_task/features/core/database/mappers/comments_table_mappers.dart';
import 'package:test_task/features/core/database/mappers/posts_table_mappers.dart';

import '../models/comment_model/comment_model.dart';
import '../models/post_model/post_model.dart';

@injectable
class PostsLocalDataSource {
  final PostsDao postsDao;
  final CommentsDao commentsDao;

  PostsLocalDataSource(this.postsDao, this.commentsDao);

  Future<List<PostModel>> getPosts({required int page, int limit = 10}) async {
    final data = await postsDao.getPosts(limit: limit, page: (page - 1) * 10);
    return data.map((e) => e.toModel()).toList();
  }

  Future<void> savePosts(List<PostModel> posts, int page) async {
    await postsDao.insertPosts(
      posts.map((e) => e.toCompanion(page: page)).toList(),
    );
  }

  Future<List<CommentModel>> getCommentsByPostId({required int postId}) async {
    final data = await commentsDao.getCommentsByPostId(postId: postId);
    return data.map((e) => e.toModel()).toList();
  }

  Future<void> saveComments(List<CommentModel> comments) async {
    await commentsDao.insertComments(
      comments.map((e) => e.toCompanion()).toList(),
    );
  }
}
