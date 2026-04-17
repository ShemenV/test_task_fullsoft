import 'package:drift/drift.dart';
import 'package:test_task/features/posts/data/models/comment_model/comment_model.dart';

import '../app_database.dart';

extension CommentsTableDataToModel on CommentsTableData {
  CommentModel toModel() {
    return CommentModel(
      id: id,
      postId: postId,
      name: name,
      email: email,
      body: body,
    );
  }
}

extension CommentModelToCompanion on CommentModel {
  CommentsTableCompanion toCompanion({int? page}) {
    return CommentsTableCompanion(
      id: Value(id),
      postId: Value(postId),
      name: Value(name),
      body: Value(body),
      email: Value(email),
    );
  }
}
