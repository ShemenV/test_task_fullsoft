import 'package:drift/drift.dart';
import 'package:test_task/features/core/database/app_database.dart';
import 'package:test_task/features/posts/data/models/post_model/post_model.dart';

extension PostTableDataToModel on PostsTableData {
  PostModel toModel() {
    return PostModel(id: id, title: title, body: body);
  }
}

extension PostModelToCompanion on PostModel {
  PostsTableCompanion toCompanion({int? page}) {
    return PostsTableCompanion(
      id: Value(id),
      title: Value(title),
      body: Value(body),
      page: Value(page),
    );
  }
}
