// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_dao.dart';

// ignore_for_file: type=lint
mixin _$CommentsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CommentsTableTable get commentsTable => attachedDatabase.commentsTable;
  CommentsDaoManager get managers => CommentsDaoManager(this);
}

class CommentsDaoManager {
  final _$CommentsDaoMixin _db;
  CommentsDaoManager(this._db);
  $$CommentsTableTableTableManager get commentsTable =>
      $$CommentsTableTableTableManager(_db.attachedDatabase, _db.commentsTable);
}
