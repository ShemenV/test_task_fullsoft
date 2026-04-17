import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task/features/core/database/app_database.dart';

import '../tables/posts_table.dart';

part 'posts_dao.g.dart';

@injectable
@DriftAccessor(tables: [PostsTable])
class PostsDao extends DatabaseAccessor<AppDatabase> with _$PostsDaoMixin {
  PostsDao(super.db);

  Future<List<PostsTableData>> getPosts({int limit = 10, int page = 0}) {
    return (select(postsTable)
          ..limit(limit, offset: page)
          ..orderBy([(t) => OrderingTerm(expression: t.id)]))
        .get();
  }

  Future<void> insertPosts(List<PostsTableCompanion> posts) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(postsTable, posts);
    });
  }
}
