import 'package:test_task/features/posts/data/models/comment_model/comment_model.dart';
import 'package:test_task/features/posts/domain/entities/comment/comment.dart';

extension CommentMapper on CommentModel {
  Comment toEntity() {
    return Comment(id: id, name: name, email: email, body: body);
  }
}
