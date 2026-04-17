import 'package:drift/drift.dart';
import 'package:test_task/features/core/database/tables/comments_table.dart';
import 'package:test_task/features/core/database/tables/posts_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [PostsTable, CommentsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor executor) : super(executor);
  @override
  int get schemaVersion => 1;
}
