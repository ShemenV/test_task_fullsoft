// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_dao.dart';

// ignore_for_file: type=lint
mixin _$PostsDaoMixin on DatabaseAccessor<AppDatabase> {
  $PostsTableTable get postsTable => attachedDatabase.postsTable;
  PostsDaoManager get managers => PostsDaoManager(this);
}

class PostsDaoManager {
  final _$PostsDaoMixin _db;
  PostsDaoManager(this._db);
  $$PostsTableTableTableManager get postsTable =>
      $$PostsTableTableTableManager(_db.attachedDatabase, _db.postsTable);
}
