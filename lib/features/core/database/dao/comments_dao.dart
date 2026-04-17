import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../app_database.dart';
import '../tables/comments_table.dart';

part 'comments_dao.g.dart';

@injectable
@DriftAccessor(tables: [CommentsTable])
class CommentsDao extends DatabaseAccessor<AppDatabase>
    with _$CommentsDaoMixin {
  CommentsDao(super.db);

  Future<List<CommentsTableData>> getCommentsByPostId({required int postId}) {
    return (select(commentsTable)
          ..where((tbl) => tbl.postId.equals(postId))
          ..orderBy([(t) => OrderingTerm(expression: t.id)]))
        .get();
  }

  Future<void> insertComments(List<CommentsTableCompanion> comments) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(commentsTable, comments);
    });
  }
}
