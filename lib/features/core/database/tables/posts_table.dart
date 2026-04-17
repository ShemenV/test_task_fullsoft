import 'package:drift/drift.dart';

class PostsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  IntColumn get page => integer().nullable()();
}
